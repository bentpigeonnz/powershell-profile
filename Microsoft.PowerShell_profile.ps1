# PowerShell Profile for Marcus

# Start in Projects folder
Set-Location "$env:USERPROFILE\Documents\Projects"

# === Oh-My-Posh Prompt ===
$ompPath = "C:\Users\miste\scoop\shims\oh-my-posh.exe"
$themePath = "$env:LOCALAPPDATA\Programs\oh-my-posh\themes\jandedobbeleer.omp.json"
& $ompPath init pwsh --config $themePath | Invoke-Expression

# === Git Shortcuts as Functions ===
function gs { git status }
function ga { git add $args }
function gc { git commit $args }
function gcm { git commit -m $args }
function gp { git push }
function gl { git log --oneline --graph --decorate --all }
function gb { git branch }
function gco { git checkout $args }
function gst { git stash $args }

# === Auto-Activate Python Virtual Env ===
if (Test-Path ".\venv\Scripts\Activate.ps1") {
    . .\venv\Scripts\Activate.ps1
}

# === Terminal Window Title ===
function Set-TerminalTitle {
    $path = Split-Path -Leaf (Get-Location)
    $branch = git rev-parse --abbrev-ref HEAD 2>$null
    $title = if ($branch) { "$path [$branch]" } else { "$path" }
    $host.ui.RawUI.WindowTitle = $title
}
Set-TerminalTitle
Register-EngineEvent PowerShell.OnIdle -Action { Set-TerminalTitle } | Out-Null

# === Output Confirmation ===
Write-Host ✔️ PowerShell profile loaded with Oh-My-Posh, Git aliases, Python venv check, and dynamic title!" -ForegroundColor Green

# === Docker Aliases ===
function dps { docker ps }
function dpsa { docker ps -a }
function dcu { docker-compose up -d }
function dcd { docker-compose down }
function dim { docker images }
function drm { docker rm $args }
function drmi { docker rmi $args }

# === NPM Aliases ===
function nr { npm run $args }
function ni { npm install $args }
function nid { npm install --save-dev $args }
function nis { npm install --save $args }
function npub { npm publish }

# === Projects Shortcut ===
function proj {
    Set-Location "$env:USERPROFILE\Documents\Projects"
}

# === Open GitHub Profile ===
function github {
    Start-Process "https://github.com/marcusmurraynz"
}

