<#
.SYNOPSIS
    Copies each application's generated website into this repository, so it can be served at all.

.DESCRIPTION
    PasteJump's and KeyPressOSD's websites used to be GitHub Pages sites of their own, published from
    their own repositories. Both repositories went private on 2026-09-08, and Pages was switched off
    with them: https://lokeshgovindu.github.io/PasteJump/ and .../KeyPressOSD/ answered 404 from that
    day, which is where the shipped .chm, both READMEs and every release note point.

    This repository is public, and the paths are the same ones - a project Pages site is served at
    <user>.github.io/<repo>/, and a folder in the user site is served at <user>.github.io/<folder>/.
    So copying the generated site into a folder of the same name puts every existing link back where it
    was, with no redirect and nothing to update in the applications.

    THE SOURCE OF TRUTH STAYS IN THE APPLICATION REPOSITORY. Both sites are generated there - by
    tools/build-help.ps1 for PasteJump and tools/build-manual.py for KeyPressOSD - and each has a
    --check that keeps the generated copy in step with the markdown it came from. This script only
    moves the result. Run the generator first, then this, or a stale page is what gets published.

    version.json is NEVER touched, in either direction. It sits in the same folder and belongs to
    write-version-manifest.ps1; a mirror that deleted it would take the update check down with it.

.PARAMETER App
    Which application. Defaults to both.

.PARAMETER SourceRoot
    Where the application repositories are checked out. Defaults to this repository's parent, which is
    where they are: they are siblings of this one.

.PARAMETER Check
    Do not write. Report what differs and fail if anything does - so a run before a commit, or after
    regenerating a manual, says whether what is published is current.

.EXAMPLE
    ./script/sync-app-docs.ps1
    Copies both sites in, then `git status` shows what changed.

.EXAMPLE
    ./script/sync-app-docs.ps1 -Check
    Says whether the published sites match the application repositories.
#>

[CmdletBinding()]
param(
    [ValidateSet('PasteJump', 'KeyPressOSD')]
    [string[]] $App = @('PasteJump', 'KeyPressOSD'),

    [string] $SourceRoot,

    [switch] $Check
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$repoRoot = Split-Path -Parent $PSScriptRoot

if (-not $SourceRoot) {
    $SourceRoot = Split-Path -Parent $repoRoot
}

# Where each site is generated, and what in that folder is NOT part of the website.
#
# PasteJump keeps its site and some working notes in one docs/ folder, so the notes are named here
# rather than published: they are about how to fill in a SourceForge page and how to record a demo,
# and neither is a page anybody should land on. help/ carries the .hhp/.hhc/.hhk the .chm is compiled
# from alongside the same topics the web serves; those three are inert over HTTP and a few kilobytes,
# so they ride along rather than earning an exclude list that would have to track the .chm build.
#
# launch/README.md was NOT on this list and should have been from the start. It is the drafted Show HN
# title, body and first comment, the AlternativeTo copy and the press list - and it was live at
# lokeshgovindu.github.io/PasteJump/launch/README.md, answering 200, found on 2026-09-14. Nothing
# terrible is in it, but a launch post is worth less once it can be read before it is posted, and
# nobody chose to publish it.
#
# THE LESSON THIS LIST TEACHES IS THAT IT IS THE WRONG SHAPE: an exclude list publishes anything
# added to docs/ by default and has to be remembered for each new file. An include list would fail
# the other way, which is the safe direction for something that decides what becomes public. Left as
# an exclude list because changing it means enumerating every page of two sites and getting that
# wrong is a site with holes in it - but a new working note under docs/ must be added here.
$Applications = @{
    # PasteJump's website is STAGED by tools/build-site.py into artifacts/site: docs/help is the source
    # of the .chm, so the navigation sidebar is added to a copy, never to docs/. Mirroring docs/ itself,
    # as this did until 2026-10-04, served the manual here with no sidebar at all while
    # pastejump.sourceforge.io had one. The staged site leaves out the release notes and the Markdown
    # manual (a plain web host cannot render them), and this site renders both, so they come from
    # docs/ directly.
    PasteJump   = @{
        Source    = 'artifacts/site'
        Generate  = @('py', '-3', 'tools/build-site.py')
        Also      = @(
            @{ From = 'docs/release-notes'; To = 'release-notes' },
            @{ From = 'docs/manual'; To = 'manual' },
            @{ From = 'docs/architecture.md'; To = 'architecture.md' },
            @{ From = 'docs/download-stats.csv'; To = 'download-stats.csv' }
        )
        # release-notes/README.md is the repository's note on how the release pipeline reads that
        # folder. GitHub Pages renders a folder's README as its index, so it was what "What's new"
        # opened, on the application's own website and here, until 2026-10-04.
        Exclude = @('sourceforge-files-readme.md', 'sourceforge-page.md', 'video-script.md',
                    'launch/README.md', 'release-notes/README.md')
        # Pages this repository owns inside the application's folder: the release-notes index is a
        # Jekyll page that renders every notes file, newest first, and the application repository
        # has no such page to mirror.
        Preserve = @('release-notes/index.html')
    }
    KeyPressOSD = @{
        Source  = 'docs/site'
        Exclude = @()
    }
}

# Belongs to write-version-manifest.ps1. Never copied over, never deleted.
$Preserve = @('version.json')

function Get-RelativeFiles {
    param([Parameter(Mandatory)] [string] $Root)

    $prefix = (Resolve-Path -LiteralPath $Root).Path.TrimEnd('\') + '\'

    # Forward slashes, because that is how the Exclude list spells a path in a subfolder. With the
    # backslashes Windows returns, 'launch/README.md' matched nothing, and the 2026-10-04 sync put the
    # launch drafts back on the site three weeks after they were taken down.
    Get-ChildItem -LiteralPath $Root -Recurse -File -Force |
        ForEach-Object { $_.FullName.Substring($prefix.Length).Replace('\', '/') }
}

function Test-SameFile {
    param([string] $A, [string] $B)

    if (-not (Test-Path -LiteralPath $A) -or -not (Test-Path -LiteralPath $B)) {
        return $false
    }

    if ((Get-Item -LiteralPath $A).Length -ne (Get-Item -LiteralPath $B).Length) {
        return $false
    }

    # Hash rather than timestamps: a copy changes the write time, so timestamps would report every
    # file as different on every run and the -Check mode would be worthless.
    (Get-FileHash -LiteralPath $A -Algorithm SHA256).Hash -eq
    (Get-FileHash -LiteralPath $B -Algorithm SHA256).Hash
}

$differences = @()

foreach ($name in $App) {
    $settings = $Applications[$name]
    $source = Join-Path $SourceRoot (Join-Path $name $settings.Source)
    $destination = Join-Path $repoRoot $name

    if (-not (Test-Path -LiteralPath (Join-Path $SourceRoot $name))) {
        throw "No $name repository at '$(Join-Path $SourceRoot $name)'. Pass -SourceRoot with where the repositories are."
    }

    # A staged site is build output, untracked, and rebuilt whenever its author likes - several times an
    # hour while working. So it is regenerated HERE, immediately before it is read: trusting whatever
    # is on disk would publish whoever ran the generator last, or a tree caught half-written.
    if ($settings.ContainsKey('Generate')) {
        $appRoot = Join-Path $SourceRoot $name
        Push-Location $appRoot
        try {
            $output = & $settings.Generate[0] $settings.Generate[1..($settings.Generate.Count - 1)] 2>&1
            $code = $LASTEXITCODE
        }
        finally {
            Pop-Location
        }
        if ($code -ne 0) {
            $output | ForEach-Object { Write-Host "  $_" }
            throw "$name's site generator failed ($($settings.Generate -join ' '), exit $code)."
        }
        Write-Host "staged  $name : $($settings.Generate -join ' ')"
    }

    if (-not (Test-Path -LiteralPath $source)) {
        throw "No generated site at '$source'. Generate the application's site first."
    }

    # Every file to publish, by its path in the published folder, mapped to where it comes from: the
    # staged site, then any folders or files taken straight from the repository beside it (Also).
    $map = [ordered]@{}
    foreach ($relative in Get-RelativeFiles -Root $source) {
        $map[$relative] = Join-Path $source $relative
    }
    foreach ($extra in @($(if ($settings.ContainsKey('Also')) { $settings.Also }))) {
        $from = Join-Path $SourceRoot (Join-Path $name $extra.From)
        if (-not (Test-Path -LiteralPath $from)) {
            throw "No '$from' to publish as $name/$($extra.To)."
        }
        if (Test-Path -LiteralPath $from -PathType Leaf) {
            $map[$extra.To] = $from
        }
        else {
            foreach ($relative in Get-RelativeFiles -Root $from) {
                $map["$($extra.To)/$relative"] = Join-Path $from $relative
            }
        }
    }

    $wanted = @($map.Keys | Where-Object { $settings.Exclude -notcontains $_ })

    $present = @()
    if (Test-Path -LiteralPath $destination) {
        $keep = @($Preserve) + @($(if ($settings.ContainsKey('Preserve')) { $settings.Preserve }))
        $present = @(Get-RelativeFiles -Root $destination | Where-Object { $keep -notcontains $_ })
    }

    $copied = 0
    $removed = 0
    $same = 0

    foreach ($relative in $wanted) {
        $from = $map[$relative]
        $to = Join-Path $destination $relative

        if (Test-SameFile -A $from -B $to) {
            $same++
            continue
        }

        if ($Check) {
            $differences += "$name/$relative"
            continue
        }

        $folder = Split-Path -Parent $to
        if ($folder -and -not (Test-Path -LiteralPath $folder)) {
            New-Item -ItemType Directory -Path $folder -Force | Out-Null
        }

        Copy-Item -LiteralPath $from -Destination $to -Force
        $copied++
    }

    # Anything here that the application no longer generates. Without this a renamed page stays
    # published for ever, and the old one is the copy search engines already know about.
    foreach ($relative in $present) {
        if ($wanted -contains $relative) {
            continue
        }

        if ($Check) {
            $differences += "$name/$relative (no longer generated)"
            continue
        }

        Remove-Item -LiteralPath (Join-Path $destination $relative) -Force
        $removed++
    }

    if ($Check) {
        Write-Host ("checked $name : {0} file(s) in the generated site" -f $wanted.Count)
    }
    else {
        Write-Host ("synced  $name : {0} copied, {1} removed, {2} already current" -f $copied, $removed, $same) -ForegroundColor Green
    }
}

if ($Check) {
    if ($differences.Count -eq 0) {
        Write-Host 'ok      every published page matches the application repositories' -ForegroundColor Green
    }
    else {
        Write-Host ''
        Write-Host 'STALE   these differ:' -ForegroundColor Red
        $differences | ForEach-Object { Write-Host "  $_" }
        Write-Error "$($differences.Count) file(s) differ. Run this script without -Check and commit the result."
        exit 1
    }
}
