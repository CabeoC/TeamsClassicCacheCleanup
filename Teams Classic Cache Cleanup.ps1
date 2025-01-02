# This script deletes old Classic Teams and its cache from all users' AppData.
# Classic Teams is no longer suppported, so this is safe to do to free up space.
# Written by ChatGPT and verified by Google Gemini and CabeoC
# ChatGPT - https://chatgpt.com/share/6723ed36-4634-8003-ac7d-5fbca504451a
# Gemini - https://g.co/gemini/share/ee4f0ddb1a63

# Get all user profiles on the system from C:\Users, except Public
$profiles = Get-ChildItem -Path "C:\Users" | Where-Object {
    $_.PSIsContainer -and $_.Name -notmatch "Public|Default"
}

foreach ($profile in $profiles) {
    # Define the Teams cache paths for AppData (Roaming) and LocalAppData
    $appDataPath = Join-Path -Path $profile.FullName -ChildPath "AppData\Roaming\Microsoft\Teams"
    $localAppDataPath = Join-Path -Path $profile.FullName -ChildPath "AppData\Local\Microsoft\Teams"

    # Remove contents of the AppData Teams cache folder if it exists
    if (Test-Path -Path $appDataPath) {
        Write-Output "Clearing Teams cache at $appDataPath for user $($profile.Name)"
        Remove-Item -Path "$appDataPath\*" -Recurse -Force -ErrorAction SilentlyContinue
    }

    # Remove contents of the LocalAppData Teams cache folder if it exists
    if (Test-Path -Path $localAppDataPath) {
        Write-Output "Clearing Teams cache at $localAppDataPath for user $($profile.Name)"
        Remove-Item -Path "$localAppDataPath\*" -Recurse -Force -ErrorAction SilentlyContinue
    }
}

Write-Output "Classic Teams cache cleared for all users."
