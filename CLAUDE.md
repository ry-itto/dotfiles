# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a dotfiles repository for a macOS development environment, managed by [chezmoi](https://www.chezmoi.io/). Dotfiles, run-once installers, and run-onchange configuration scripts are organized using chezmoi's filename conventions (`dot_*`, `private_*`, `executable_*`, `run_once_*`, `run_onchange_*`).

Language runtimes (Flutter, Rust, Node, Ruby) are managed by [mise](https://mise.jdx.dev/) via `dot_config/mise/config.toml`. Homebrew packages are defined in `dot_Brewfile` and installed by `run_onchange_install-brew-packages.sh.tmpl`.

## Commands

### Setup and Installation

```bash
# First time on a new machine
brew install chezmoi
chezmoi init --apply ry-itto/dotfiles

# Pull latest changes from the repo and re-apply
chezmoi update

# See what would change before applying
chezmoi diff

# Apply pending changes
chezmoi apply
```

### Editing Managed Files

After migrating to chezmoi, editing files directly under `$HOME` does **not** sync back to this repository. Always use one of:

```bash
# Open the source file in $EDITOR
chezmoi edit ~/.zshrc

# Or jump to the source directory and edit there
cd "$(chezmoi source-path)"
$EDITOR dot_zshrc
chezmoi apply
```

### Adding New Files

```bash
# Move an existing $HOME file into chezmoi management
chezmoi add ~/.somefile
```

## Architecture

### Source Layout

The repository **is** the chezmoi source directory. chezmoi reads filename prefixes to decide where each file goes in `$HOME`:

- `dot_<name>` → `~/.<name>` (e.g. `dot_zshrc` → `~/.zshrc`)
- `executable_<name>` → preserves +x bit on apply
- `private_<name>` → applied with mode 0600/0700
- `<name>.tmpl` → rendered with chezmoi's template engine before apply
- `run_once_<name>.sh` → executed once per machine
- `run_onchange_<name>.sh` → executed when the script's content changes

### Top-Level Files

**Managed dotfiles** (chezmoi targets):
- `dot_zshrc` — entrypoint that sources modules under `~/.zsh/`
- `dot_zsh/` — modular Zsh config: `alias.zsh`, `env.zsh`, `style.zsh`, `plugin.zsh`, `functions/`, `bin/executable_reload`
- `dot_gitconfig`, `dot_Brewfile`, `dot_commit_template`
- `dot_vim/`, `dot_hammerspoon/`, `dot_claude/`
- `dot_config/nvim/`, `dot_config/starship.toml`, `dot_config/mise/config.toml`
- `private_Library/private_Application Support/Code/User/settings.json` — VSCode user settings

**Run scripts** (executed during `chezmoi apply`):
- `run_onchange_install-brew-packages.sh.tmpl` — re-runs when `dot_Brewfile` changes
- `run_onchange_configure-macos-defaults.sh` — `defaults write` for NSGlobalDomain, Finder, key repeat, Caps Lock → Control
- `run_onchange_configure-xcode.sh` — `defaults write` for Xcode build settings
- `run_once_install-zplug.sh` — bootstrap zplug
- `run_once_install-dein.sh` — bootstrap dein.vim
- `run_once_install-mise-tools.sh` — runs `mise install` for tools defined in `dot_config/mise/config.toml`

**Configuration**:
- `.chezmoiignore` — paths chezmoi should skip during apply (README, scripts/, CI files, destination-side local files)

**Repository support files** (excluded from `chezmoi apply` via `.chezmoiignore`):
- `.github/workflows/ci.yml` — lint, chezmoi-verify
- `README.md`, `CLAUDE.md`, `LICENSE`

### Run Script Execution Order

`chezmoi apply` runs `run_*` scripts in lexical order of their filename. The current ordering ensures:

1. `run_onchange_configure-macos-defaults.sh`
2. `run_onchange_configure-xcode.sh`
3. `run_onchange_install-brew-packages.sh` (installs `mise` via Brewfile)
4. `run_once_install-dein.sh`
5. `run_once_install-mise-tools.sh` (skips with a notice if `mise` is not yet on PATH)
6. `run_once_install-zplug.sh`

If `mise` is not yet installed when `run_once_install-mise-tools.sh` runs, the script exits cleanly. Re-running `chezmoi apply` after the brew bundle finishes will trigger it again.

All run scripts honor `CI=1` and exit early in CI to avoid expensive operations.

## Development Stack

- **iOS Development**: Xcode, XcodeGen, xcbeautify (Homebrew)
- **Flutter / Rust / Node / Ruby**: managed by mise (`dot_config/mise/config.toml`)
- **Web Development**: Node.js (via mise), npm/yarn ecosystem
- **General**: Git, GitHub CLI, Neovim, Starship prompt

## Key Design Principles

1. **Single source of truth**: chezmoi manages all dotfiles; mise manages all language runtimes.
2. **macOS-only**: no OS branching. `defaults write` and other macOS-specific commands run unconditionally.
3. **Idempotency**: `run_once_*` scripts gate themselves on existence checks; `run_onchange_*` scripts re-run only when their content (or referenced files) change.
4. **Hand-off to upstream tools**: chezmoi delegates package management to Homebrew (`brew bundle`) and mise (`mise install`) rather than reimplementing version logic.
