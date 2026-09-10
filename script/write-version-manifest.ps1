<#
.SYNOPSIS
    Writes <App>/version.json - the update manifest an application asks what the newest release is.

.DESCRIPTION
    Since 2026-09-08 the application repositories are private, and a private repository answers 404 to
    an anonymous request. That is the same 404 an empty one answers, so GitHub's release API can no
    longer tell any copy of these programs that a version exists - the check is not merely degraded,
    it is incapable of ever firing again.

    This site is public, so a file served from it can be read by anybody. That is the whole idea: the
    private repository stays the source of truth, and this is the one fact about it that has to be
    readable without credentials.

    THE MANIFEST IS WRITTEN IN GITHUB'S OWN SHAPE - the same tag_name, draft, prerelease,
    published_at, html_url and assets field names, as an array newest-first. That is deliberate and
    worth keeping: each application already had a tested parser for GitHub's document, along with its
    channel rules (prereleases, the week's delay on the delayed-stable channel, reading the version out
    of an asset's file name). Inventing a format would have meant a second parser in each of them and a
    second copy of every rule to keep in step. So the applications changed which URL they ask, and
    nothing about how they read the answer.

    One field is not copied verbatim: html_url is rewritten to point at the SourceForge mirror, because
    a GitHub release page is exactly what the reader cannot open. Where there is no mirror the
    application's own web page is used, so nobody is sent to a 404.

    Reads the releases with `gh`, which is authenticated as the repository's owner, so this must be run
    by that person - a release manifest is not something CI on a public repository could produce.

.PARAMETER App
    Which application. Defaults to all of them.

.PARAMETER StableOnly
    Write only releases fit to offer everyone, dropping prereleases. Needed for PerchBar, whose check
    has no prerelease flag of its own and takes the first entry as the answer.

.PARAMETER Check
    Do not write. Compare what would be written against what is on disk and fail if they differ - so
    CI, or a run before a commit, can say the manifest has gone stale.

.EXAMPLE
    ./script/write-version-manifest.ps1
    Rewrites every manifest, then `git diff` shows what a release changed.

.EXAMPLE
    ./script/write-version-manifest.ps1 -App PasteJump -Check
    Says whether PasteJump/version.json still matches the releases.
#>

[CmdletBinding()]
param(
    [ValidateSet('PasteJump', 'KeyPressOSD', 'PerchBar')]
    [string[]] $App = @('PasteJump', 'KeyPressOSD', 'PerchBar'),

    [switch] $StableOnly,

    [switch] $Check
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

# Where a person is sent to download each application, since a release page on a private repository is
# the one link that cannot work. Keyed by repository name.
#
# PerchBar has NO mirror and no published release: its manifest is written as an empty list, which its
# check reads as "nothing published yet" rather than as a failure. Give it a DownloadPage the day it
# gets a release, and check the URL resolves before adding one - an invented download link is worse
# than none.
$Applications = @{
    PasteJump   = @{
        DownloadPage = 'https://sourceforge.net/projects/pastejump/files/'
        StableOnly   = $false
    }
    KeyPressOSD = @{
        DownloadPage = 'https://sourceforge.net/projects/keypressosd/files/'
        StableOnly   = $false
    }
    PerchBar    = @{
        DownloadPage = 'https://lokeshgovindu.github.io/PerchBar/'
        # Its check has no notion of a prerelease and takes the first entry, so it must not be offered
        # one.
        StableOnly   = $true
    }
}

$repoRoot = Split-Path -Parent $PSScriptRoot

function Get-Manifest {
    param(
        [Parameter(Mandatory)] [string] $Name,
        [Parameter(Mandatory)] [hashtable] $Settings
    )

    # Ten is plenty to find the newest release on any channel and keeps the file small. The
    # applications ask for the same number from the API.
    $raw = & gh api "repos/lokeshgovindu/$Name/releases?per_page=10" 2>&1

    if ($LASTEXITCODE -ne 0) {
        throw "gh could not read $Name's releases (is gh authenticated as the owner?): $raw"
    }

    $releases = $raw | ConvertFrom-Json

    # An account with no releases yields an empty array, not null - but be explicit, because the
    # difference decides between "[]" and a crash.
    if ($null -eq $releases) {
        $releases = @()
    }

    $stableOnly = $StableOnly -or $Settings.StableOnly

    # A List rather than the output of a foreach, because a foreach that iterates nothing assigns $null,
    # and @($null) is an array of length ONE holding a null - which is how PerchBar's empty manifest came
    # out as "[[]]" on the first attempt. A list is empty when nothing was added, and says so.
    $entries = [System.Collections.Generic.List[object]]::new()

    foreach ($release in $releases) {
        # A draft is never published: its tag may not exist and nobody but the author can open it, so
        # offering one would be offering a 404. The applications reject drafts too; dropping them here
        # as well keeps the file honest for anyone reading it directly.
        if ($release.draft) { continue }
        if ($stableOnly -and $release.prerelease) { continue }

        $entries.Add([ordered] @{
            tag_name     = $release.tag_name
            draft        = [bool] $release.draft
            prerelease   = [bool] $release.prerelease
            published_at = $release.published_at

            # NOT the GitHub release page, which is the one URL the reader cannot open. This is where
            # they can actually get it.
            html_url     = $Settings.DownloadPage

            # Only the names, and only because PasteJump reads the version out of one: its tags are
            # "2026.1-pre6", which parses to 2026.1.0.0, so a copy running 2026.1.0.226 would compare
            # as newer than every release ever made and the check would say "up to date" for ever. The
            # archive name carries the revision. Sizes, download counts and URLs are all dropped - the
            # applications read none of them.
            assets       = @(
                foreach ($asset in $release.assets) {
                    [ordered] @{ name = $asset.name }
                }
            )
        })
    }

    # An array ALWAYS, including when there is one release or none. The parsers take either shape, but a
    # manifest whose shape changed with the number of releases would be a trap for anything else that
    # reads it. The leading comma passes it out as one item instead of letting the pipeline enumerate it.
    ,$entries.ToArray()
}

$stale = @()

foreach ($name in $App) {
    $settings = $Applications[$name]
    # NOT wrapped in @(...). Get-Manifest returns the array as a single pipeline item on purpose, and
    # @() would collect that one item into an array containing it - giving [[...]] and an entry count of
    # one however many releases there are.
    $entries = Get-Manifest -Name $name -Settings $settings

    # -InputObject rather than the pipeline, and NO -AsArray. Both halves of that were bugs first:
    #
    #   * piping an EMPTY array sends nothing down the pipeline, so ConvertTo-Json is never called and
    #     the file comes out as a lone newline instead of "[]" - and a manifest that is not JSON at all
    #     reads as unreadable, sending the check on to the API to be told 404 by a private repository.
    #     That is PerchBar's case exactly, since it has no releases.
    #   * -AsArray with -InputObject wraps the array in ANOTHER array, giving "[[...]]", because the
    #     array handed to -InputObject is one object as far as it is concerned. Without it an array is
    #     already serialised as an array, empty or not.
    #
    # Depth matters too: the default of 2 would render the assets as type names.
    $json = (ConvertTo-Json -InputObject $entries -Depth 6) + "`n"

    $directory = Join-Path $repoRoot $name
    $path = Join-Path $directory 'version.json'

    if ($Check) {
        $current = (Test-Path -LiteralPath $path) ? (Get-Content -LiteralPath $path -Raw) : ''

        if ($current -ne $json) {
            Write-Host "STALE   $name/version.json does not match the published releases" -ForegroundColor Red
            $stale += $name
        }
        else {
            Write-Host "ok      $name/version.json" -ForegroundColor Green
        }

        continue
    }

    if (-not (Test-Path -LiteralPath $directory)) {
        New-Item -ItemType Directory -Path $directory | Out-Null
    }

    # UTF-8 without a BOM: a BOM would be the first thing every JSON parser trips over.
    [System.IO.File]::WriteAllText($path, $json, [System.Text.UTF8Encoding]::new($false))

    $count = $entries.Count
    $newest = $count -gt 0 ? $entries[0].tag_name : '(none)'
    Write-Host "wrote   $name/version.json - $count release(s), newest $newest" -ForegroundColor Green
}

if ($stale.Count -gt 0) {
    Write-Error "Stale manifest(s): $($stale -join ', '). Run this script without -Check and commit the result."
    exit 1
}
