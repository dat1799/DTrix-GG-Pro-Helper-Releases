# Alias to run.ps1 on dat1799/DTrix-GG-Pro-Helper-Releases
$script = (Invoke-RestMethod -Uri "https://raw.githubusercontent.com/dat1799/DTrix-GG-Pro-Helper-Releases/main/run.ps1")
Invoke-Expression $script
