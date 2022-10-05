# Set-StrictMode -Version 3
# $ErrorActionPreference = "Stop"

$botFolderPath = '..\ants' # this is just a test should be relative path
Push-Location $botFolderPath
try {
	$apiKey = Get-Content '.apikey'
	dotnet publish . --output '.\bin\publish'
	Remove-Item '.\bin\publish\*.zip' -Force
	Compress-Archive -Path '.\bin\publish\*.*' -DestinationPath '.\bin\publish\bot.zip'

	$uploadFilePath = '.\bin\publish\bot.zip'
	$uploadUrl = 'http://ants-combat-server.swedencentral.cloudapp.azure.com/api/Bots'

	$client = New-Object System.Net.WebClient
	$client.Headers.Add('x-apikey', $apiKey)
	$fullUploadPath = (Get-Item $uploadFilePath).FullName
	$client.UploadFile($uploadUrl, $fullUploadPath)
	Write-Host 'Bot uploaded successfully' -ForegroundColor Green
} 
catch {
	$error[0] | Format-List
	Write-Host 'Please call "New-Team.ps1" before calling this script.'
} finally {
	Pop-Location
}
