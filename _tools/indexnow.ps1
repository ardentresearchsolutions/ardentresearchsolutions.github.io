# IndexNow submitter for arspakistan.pk (Bing, Yandex, Seznam, Naver, etc.)
# Usage (after the push has gone live):
#   Double-click IndexNow.cmd              -> submits every URL in sitemap.xml
#   IndexNow.cmd https://arspakistan.pk/insights/new-page.html [more URLs]
#                                          -> submits only the URLs given
# This folder starts with "_" so GitHub Pages does not publish it.

param([string[]]$Urls)

$ErrorActionPreference = 'Stop'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$HostName = 'arspakistan.pk'
$Key      = 'aafecb3622aca40e2ad105f3847da93f'
$KeyUrl   = "https://$HostName/$Key.txt"

if (-not $Urls -or $Urls.Count -eq 0) {
    $sitemapPath = Join-Path $PSScriptRoot '..\sitemap.xml'
    [xml]$sitemap = Get-Content -Raw -Encoding UTF8 $sitemapPath
    $Urls = @($sitemap.urlset.url | ForEach-Object { $_.loc.Trim() })
    Write-Host "Submitting all $($Urls.Count) URLs from sitemap.xml"
} else {
    Write-Host "Submitting $($Urls.Count) URL(s)"
}

# 1. Make sure the key file is live, otherwise IndexNow rejects the submission
try {
    $k = Invoke-WebRequest -Uri $KeyUrl -UseBasicParsing
    if ($k.Content.Trim() -ne $Key) { throw "Key file content does not match." }
    Write-Host "Key file OK: $KeyUrl"
} catch {
    Write-Host "Key file not reachable at $KeyUrl - push it first (and purge Cloudflare if needed)." -ForegroundColor Red
    Write-Host $_.Exception.Message
    exit 1
}

# 2. Submit
$body = @{
    host        = $HostName
    key         = $Key
    keyLocation = $KeyUrl
    urlList     = $Urls
} | ConvertTo-Json -Depth 3

try {
    $r = Invoke-WebRequest -Uri 'https://api.indexnow.org/indexnow' -Method Post `
         -ContentType 'application/json; charset=utf-8' `
         -Body ([Text.Encoding]::UTF8.GetBytes($body)) -UseBasicParsing
    Write-Host "IndexNow response: $($r.StatusCode) (200 or 202 = accepted)" -ForegroundColor Green
} catch {
    $code = $_.Exception.Response.StatusCode.value__
    Write-Host "IndexNow error: HTTP $code" -ForegroundColor Red
    switch ($code) {
        400 { Write-Host 'Bad request - check the URL list.' }
        403 { Write-Host 'Key not valid - key file missing or wrong content.' }
        422 { Write-Host 'URLs do not belong to arspakistan.pk.' }
        429 { Write-Host 'Too many requests - wait and try later.' }
    }
    exit 1
}
