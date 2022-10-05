Set-StrictMode -Version 3
$ErrorActionPreference = "Stop"

$url = 'http://ants-combat-server.swedencentral.cloudapp.azure.com/api/Teams';
$teamName = Read-Host -Prompt 'Enter team name (3-10 characters, letters, digits or underscores only)'
$apiKey = Invoke-RestMethod -Method Put -Uri "$($url)?teamName=$($teamName)"
Write-Host $apiKey
$apiKey | Set-Content '.apikey'