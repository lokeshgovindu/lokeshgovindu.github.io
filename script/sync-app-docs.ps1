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
$Applications = @{
    PasteJump   = @{
        Source  = 'docs'
        Exclude = @('sourceforge-files-readme.md', 'sourceforge-page.md', 'video-script.md')
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

    Get-ChildItem -LiteralPath $Root -Recurse -File -Force |
        ForEach-Object { $_.FullName.Substring($prefix.Length) }
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

    if (-not (Test-Path -LiteralPath $source)) {
        throw "No generated site at '$source'. Pass -SourceRoot with where the repositories are."
    }

    $wanted = @(Get-RelativeFiles -Root $source | Where-Object { $settings.Exclude -notcontains $_ })

    $present = @()
    if (Test-Path -LiteralPath $destination) {
        $present = @(Get-RelativeFiles -Root $destination | Where-Object { $Preserve -notcontains $_ })
    }

    $copied = 0
    $removed = 0
    $same = 0

    foreach ($relative in $wanted) {
        $from = Join-Path $source $relative
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
