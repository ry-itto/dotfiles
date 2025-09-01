# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a dotfiles repository for macOS development environment setup. It manages system configurations, development tools, and application settings through automated installation scripts.

## Commands

### Setup and Installation
```bash
# Install all dotfiles and dependencies
make all

# Only install dotfiles (symlinks and settings)
make install

# Only install dependencies (brew, tools, etc.)
make deps

# List all dotfiles that will be installed
make list
```

### Manual Installation Scripts
```bash
# Install Homebrew dependencies
/bin/zsh installers/brew.sh

# Install development tools via mise
/bin/zsh installers/mise.sh

# Install other tools (run as needed)
/bin/zsh installers/dein.sh    # Vim plugin manager
/bin/zsh installers/xcode.sh    # Xcode settings
/bin/zsh installers/zplug.sh    # Zsh plugin manager
```

## Architecture

### Core Components

1. **Makefile**: Main orchestrator that:
   - Symlinks dotfiles from repo to home directory
   - Copies `.config/` contents to `~/.config/`
   - Executes installer scripts in sequence
   - Excludes `.DS_Store`, `.git`, `.config`, `.ruby-version`, `.github` from symlinking

2. **Dotfiles** (symlinked to home):
   - `.Brewfile`: Homebrew bundle configuration with all packages
   - `.zshrc`: Main shell configuration that sources modular configs
   - `.tmux.conf`: Tmux configuration
   - `.gitconfig`: Git configuration
   - `.commit_template`: Git commit template

3. **Modular Zsh Configuration** (`.zsh/`):
   - `alias.zsh`: Command aliases and shortcuts
   - `env.zsh`: Environment variables
   - `style.zsh`: Shell appearance and prompt
   - `plugin.zsh`: Zsh plugin management

4. **Installers** (`installers/`):
   - Shell scripts for installing various development tools
   - `mise.sh`: Installs Flutter, Rust, and Vim via mise
   - `dein.sh`: Installs dein.vim plugin manager
   - `xcode.sh`: Configures Xcode settings
   - `zplug.sh`: Installs zplug shell plugin manager
   - Each script checks if tool exists before installation
   - Designed to be idempotent

5. **Settings** (`settings/`):
   - Platform-specific configurations (macOS, VSCode, Xcode)
   - Each has its own `install.sh` script

## Development Stack

The repository configures a comprehensive development environment for:
- **iOS Development**: Xcode tools, XcodeGen, Mint
- **Flutter Development**: Flutter (via mise), Dart, iOS deployment tools
- **Web Development**: Node.js (via n), various JS tools
- **General Development**: Git, GitHub CLI, tmux, neovim, starship prompt, Vim (via mise)
- **Language Support**: Go, Dart, Ruby, Rust (via mise), Flutter (via mise)

## Key Design Principles

1. **Modularity**: Configurations are split into logical components
2. **Idempotency**: Scripts can be run multiple times safely
3. **Automation**: Single `make` command sets up entire environment
4. **Version Management**: Uses mise for language version management
5. **Tool Management**: Homebrew as primary package manager with Brewfile for reproducibility