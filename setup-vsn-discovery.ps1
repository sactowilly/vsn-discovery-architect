<#
.SYNOPSIS
  One-shot setup for vsn-discovery-architect dual-agent workflow on Windows.

.DESCRIPTION
  Installs Git, Claude Code, and Codex CLI. Clones the repo (or pulls if
  already cloned). Copies the four updated context files from your Downloads
  folder into the repo, commits, and pushes. Prints next steps.

  Idempotent: safe to re-run. Skips anything already done.

.HOW TO RUN
  1. Save this file anywhere (e.g. Downloads).
  2. Make sure these four files are also in your Downloads folder:
       AGENTS.md
       CLAUDE.md
       README.md
       CHANGELOG.md
  3. Open PowerShell (regular user, not admin needed for most steps).
  4. cd to where you saved the script.
  5. Run:
       powershell -ExecutionPolicy Bypass -File .\setup-vsn-discovery.ps1

  When a browser opens for OAuth (Git, Claude, or Codex), complete the
  sign-in, then come back to the terminal.

.NOTES
  Will Zrnchik · sactowilly · Vision Packaging
  v0.4.2 dual-agent setup
#>

# ---- configuration ----
$RepoUrl       = "https://github.com/sactowilly/vsn-discovery-architect.git"
$RepoName      = "vsn-discovery-architect"
$CodeRoot      = Join-Path $HOME "code"
$RepoPath      = Join-Path $CodeRoot $RepoName
$DownloadsPath = Join-Path $HOME "Downloads"
$Files         = @("AGENTS.md", "CLAUDE.md", "README.md", "CHANGELOG.md")
$CommitMessage = @"
v0.4.2 dual-agent setup

Promote AGENTS.md as canonical context file (read by both Claude Code
and Codex CLI). Reduce CLAUDE.md to a pointer at AGENTS.md. Document
dual-agent workflow protocol with commit prefixing ([claude] and [codex])
and role bias (Claude builds, Codex audits).
"@

# ---- helpers ----
function Write-Step($msg) {
    Write-Host ""
    Write-Host "==> $msg" -ForegroundColor Cyan
}
function Write-OK($msg)   { Write-Host "    [OK]   $msg" -ForegroundColor Green }
function Write-Skip($msg) { Write-Host "    [skip] $msg" -ForegroundColor DarkGray }
function Write-Warn($msg) { Write-Host "    [warn] $msg" -ForegroundColor Yellow }
function Write-Fail($msg) { Write-Host "    [FAIL] $msg" -ForegroundColor Red }
function Test-Cmd($cmd)   { [bool](Get-Command $cmd -ErrorAction SilentlyContinue) }
function Refresh-Path {
    $env:Path = `
        [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + `
        [System.Environment]::GetEnvironmentVariable("Path","User")
}

Write-Host ""
Write-Host "===============================================" -ForegroundColor Cyan
Write-Host "  vsn-discovery-architect setup (v0.4.2)" -ForegroundColor Cyan
Write-Host "===============================================" -ForegroundColor Cyan

# ---- 1/6 prereq files ----
Write-Step "1/6  Verify context files are in $DownloadsPath"
$missing = @()
foreach ($f in $Files) {
    if (Test-Path (Join-Path $DownloadsPath $f)) {
        Write-OK $f
    } else {
        Write-Fail "missing: $f"
        $missing += $f
    }
}
if ($missing.Count -gt 0) {
    Write-Host ""
    Write-Fail "Download the missing files from the Claude chat, save them to"
    Write-Fail "$DownloadsPath, then re-run this script."
    exit 1
}

# ---- 2/6 install Git ----
Write-Step "2/6  Install Git (if missing)"
if (Test-Cmd "git") {
    Write-OK "git already installed: $(git --version)"
} else {
    if (Test-Cmd "winget") {
        Write-Host "    Installing Git via winget..." -ForegroundColor Gray
        winget install --id Git.Git -e --silent --accept-source-agreements --accept-package-agreements
        Refresh-Path
        if (Test-Cmd "git") {
            Write-OK "git installed: $(git --version)"
        } else {
            Write-Warn "git installed but not in current session PATH."
            Write-Warn "Close this PowerShell, open a new one, and re-run the script."
            exit 1
        }
    } else {
        Write-Fail "winget not available. Install Git manually from https://git-scm.com/download/win, then re-run."
        exit 1
    }
}

# ---- 3/6 install Claude Code ----
Write-Step "3/6  Install Claude Code (if missing)"
if (Test-Cmd "claude") {
    Write-OK "claude already installed"
} else {
    Write-Host "    Installing Claude Code via official PowerShell installer..." -ForegroundColor Gray
    try {
        Invoke-RestMethod -Uri "https://claude.ai/install.ps1" | Invoke-Expression
        Refresh-Path
        if (Test-Cmd "claude") {
            Write-OK "claude installed"
        } else {
            Write-Warn "claude installed but not in current session PATH (normal). It will work in a fresh PowerShell."
        }
    } catch {
        Write-Fail "Claude Code install failed: $_"
        Write-Fail "You can install manually later: irm https://claude.ai/install.ps1 | iex"
    }
}

# ---- 4/6 install Codex CLI ----
Write-Step "4/6  Install Codex CLI (if missing)"
if (Test-Cmd "codex") {
    Write-OK "codex already installed"
} else {
    Write-Host "    Installing Codex CLI via official PowerShell installer..." -ForegroundColor Gray
    try {
        Invoke-RestMethod -Uri "https://chatgpt.com/codex/install.ps1" | Invoke-Expression
        Refresh-Path
        if (Test-Cmd "codex") {
            Write-OK "codex installed"
        } else {
            Write-Warn "codex installed but not in current session PATH (normal). It will work in a fresh PowerShell."
        }
    } catch {
        Write-Fail "Codex CLI install failed: $_"
        Write-Fail "You can install manually later: irm https://chatgpt.com/codex/install.ps1 | iex"
    }
}

# ---- 5/6 clone or update repo ----
Write-Step "5/6  Clone or update $RepoName"
if (-not (Test-Path $CodeRoot)) {
    New-Item -ItemType Directory -Path $CodeRoot | Out-Null
}
if (-not (Test-Path $RepoPath)) {
    Write-Host "    Cloning fresh into $RepoPath..." -ForegroundColor Gray
    Push-Location $CodeRoot
    git clone $RepoUrl
    Pop-Location
    if (-not (Test-Path $RepoPath)) {
        Write-Fail "Clone failed. If the repo is private, you may need to authenticate first."
        Write-Fail "Try: gh auth login   OR   git clone the URL manually to set up credentials."
        exit 1
    }
    Write-OK "cloned"
} else {
    Write-Host "    Already cloned, pulling latest..." -ForegroundColor Gray
    Push-Location $RepoPath
    git pull
    Pop-Location
    Write-OK "up to date"
}

# ---- 6/6 copy, commit, push ----
Write-Step "6/6  Install updated files, commit, and push"
foreach ($f in $Files) {
    $src = Join-Path $DownloadsPath $f
    $dst = Join-Path $RepoPath $f
    Copy-Item -Path $src -Destination $dst -Force
    Write-OK "wrote: $f"
}

Push-Location $RepoPath
$status = git status --porcelain
if ([string]::IsNullOrWhiteSpace($status)) {
    Write-Skip "No changes to commit. Repo already has these versions."
} else {
    git add AGENTS.md CLAUDE.md README.md CHANGELOG.md
    git commit -m $CommitMessage | Out-Null
    Write-OK "committed locally"
    Write-Host "    Pushing to GitHub..." -ForegroundColor Gray
    Write-Host "    (First push from this machine: a browser will open for git auth)" -ForegroundColor DarkGray
    git push
    if ($LASTEXITCODE -eq 0) {
        Write-OK "pushed"
    } else {
        Write-Fail "Push failed. Resolve credentials, then run:"
        Write-Fail "    cd $RepoPath; git push"
    }
}
Pop-Location

# ---- next steps ----
Write-Host ""
Write-Host "===============================================" -ForegroundColor Cyan
Write-Host "  Setup complete." -ForegroundColor Cyan
Write-Host "===============================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "  Open a fresh PowerShell window so PATH picks up claude and codex." -ForegroundColor White
Write-Host ""
Write-Host "  Then:" -ForegroundColor White
Write-Host "    cd $RepoPath" -ForegroundColor White
Write-Host ""
Write-Host "  And run either:" -ForegroundColor White
Write-Host "    claude     # first run opens a browser for Claude OAuth" -ForegroundColor White
Write-Host "    codex      # first run opens a browser for ChatGPT OAuth" -ForegroundColor White
Write-Host ""
Write-Host "  First message to send the agent:" -ForegroundColor White
Write-Host "    Read AGENTS.md, then tell me the current state of the project" -ForegroundColor Gray
Write-Host "    and what's at the top of the Unreleased priority list." -ForegroundColor Gray
Write-Host ""
Write-Host "  Live tool: https://sactowilly.github.io/vsn-discovery-architect/" -ForegroundColor Cyan
Write-Host "  Repo:      https://github.com/sactowilly/vsn-discovery-architect" -ForegroundColor Cyan
Write-Host ""
