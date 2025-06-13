# PowerShell Profile for Marcus

# Start in Projects folder
Set-Location "$env:USERPROFILE\Documents\Projects"

# === Oh-My-Posh Prompt Setup ===
$ompTheme = "$env:POSH_THEMES_PATH\jandedobbeleer.omp.json"
if (-not (Test-Path $ompTheme)) {
    $ompTheme = "$(oh-my-posh get shell-path powershell)"
}
oh-my-posh init pwsh --config "$ompTheme" | Invoke-Expression

# === Git Shortcuts as Functions (avoid alias conflicts) ===
function gs { git status }
function ga { git add @args }
function gc { git commit @args }
function gcm { git commit -m @args }
function gp { git push }
function gl { git log --oneline --graph --decorate --all }
function gb { git branch }
function gco { git checkout @args }
function gst { git stash @args }

# === Auto-Activate Python Virtual Environment if present ===
if (Test-Path ".\venv\Scripts\Activate.ps1") {
    . .\venv\Scripts\Activate.ps1
}

# === Terminal Window Title with current folder and Git branch ===
function Set-TerminalTitle {
    $path = Split-Path -Leaf (Get-Location)
    $branch = git rev-parse --abbrev-ref HEAD 2>$null
    $title = if ($branch) { "$path [$branch]" } else { "$path" }
    $host.UI.RawUI.WindowTitle = $title
}
Set-TerminalTitle
Register-EngineEvent PowerShell.OnIdle -Action { Set-TerminalTitle } | Out-Null

# === Docker Aliases ===
function dps { docker ps }
function dpsa { docker ps -a }
function dcu { docker-compose up -d }
function dcd { docker-compose down }
function dim { docker images }
function drm { docker rm @args }
function drmi { docker rmi @args }

# === NPM Aliases ===
function nr { npm run @args }
function ni { npm install @args }
function nid { npm install --save-dev @args }
function nis { npm install --save @args }
function npub { npm publish }

# === Projects Shortcut ===
function proj {
    Set-Location "$env:USERPROFILE\Documents\Projects"
}

function dogapp {
    Set-Location "D:\projects\nz_dog_shelter_app"
    code .
}

# === Open GitHub Profile ===
function github {
    Start-Process "https://github.com/marcusmurraynz"
}

# === Auto-commit and push profile on exit ===
Register-EngineEvent PowerShell.Exiting -Action {
    git -C "$env:USERPROFILE\OneDrive\Documents\WindowsPowerShell" add .
    git -C "$env:USERPROFILE\OneDrive\Documents\WindowsPowerShell" commit -m "Auto-sync on exit" --allow-empty
    git -C "$env:USERPROFILE\OneDrive\Documents\WindowsPowerShell" push
}
