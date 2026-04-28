# dotfiles

My personal dotfiles for macOS development environment, managed by [chezmoi](https://www.chezmoi.io/).

## 🚀 Quick Start

```bash
# Install chezmoi if you don't have it
brew install chezmoi

# Initialize and apply this repository
chezmoi init --apply ry-itto/dotfiles
```

## 📋 Requirements

- macOS (this configuration is macOS-only)
- Command Line Tools for Xcode
- Internet connection for downloading packages

<!-- START ENVIRONMENT INFO -->
## 📦 Package Configuration

> **Tested on**: macOS 26.2 (arm64) - Last updated: 2026-04-28 06:48 UTC

The following packages are defined in `dot_Brewfile` (rendered to `~/.Brewfile`) for installation:

<details>
<summary>🛠️ Homebrew Formulae (30 packages)</summary>


**zsh関係**

- `zsh` - Z shell - Modern shell with advanced features
- `zplug` - Zsh plugin manager

**iOS**

- `xcodegen` - Generate Xcode projects from spec files
- `xcbeautify` - Xcode build output formatter

**Flutter**

- `usbmuxd` - USB multiplexing daemon for iOS devices
- `libimobiledevice` (latest development version) - iOS device communication library
- `ideviceinstaller` - Manage iOS apps from command line
- `ios-deploy` - Install and debug iOS apps from command line

**MCP**

- `uv` - Fast Python package installer and resolver

**ツール**

- `ag` - The Silver Searcher - Fast code searching
- `gh` - GitHub CLI
- `ghq` - Git repository organizer
- `fzf` - Fuzzy finder for command line
- `jq` - JSON processor
- `tig` - Text-mode interface for git
- `tree` - Display directory tree structure
- `nkf` - Network Kanji Filter - Character encoding converter
- `git` - Distributed version control system
- `emojify` - Emoji on the command line
- `nvim` - Neovim - Hyperextensible Vim-based text editor
- `tmux` - Terminal multiplexer
- `starship` - Cross-shell prompt
- `mise` - Development environment manager (formerly rtx)
- `act` - Run GitHub Actions locally

**gPRC**

- `protobuf` - Protocol Buffers - Google's data interchange format

**ruby-build**

- `openssl@3` - Cryptography and SSL/TLS toolkit
- `readline` - GNU readline library
- `libyaml` - YAML parser and emitter library
- `autoconf` - Automatic configure script builder
- `gmp` - GNU multiple precision arithmetic library

</details>

<details>
<summary>🖥️ Homebrew Casks - GUI Applications (12 apps)</summary>


**Cask**

- `clipy` - Clipboard manager
- `raycast` - Productivity launcher
- `font-hack-nerd-font` - Hack font with Nerd Font patches
- `font-hackgen` - Japanese programming font
- `font-hackgen-nerd` - HackGen with Nerd Font patches
- `notion` - All-in-one workspace
- `notion-calendar` - Calendar app by Notion
- `figma` - Collaborative design tool
- `discord` - Voice, video, and text chat
- `rectangle` - Window management app
- `hammerspoon` - Desktop automation tool
- `wezterm` - GPU-accelerated terminal emulator

</details>
<!-- END ENVIRONMENT INFO -->

## 🛠 Installation

```bash
brew install chezmoi
chezmoi init --apply ry-itto/dotfiles
```

`chezmoi init --apply` will:

1. Clone this repository into `~/.local/share/chezmoi`
2. Render dotfiles into `$HOME` (e.g. `dot_zshrc` → `~/.zshrc`)
3. Run `run_onchange_install-brew-packages.sh` to install Homebrew bundle from `~/.Brewfile`
4. Run `run_onchange_configure-macos-defaults.sh` and `run_onchange_configure-xcode.sh` to apply system defaults
5. Run `run_once_install-zplug.sh`, `run_once_install-dein.sh` to bootstrap shell/editor plugin managers
6. Run `run_once_install-mise-tools.sh` to install language runtimes (flutter, rust, node, ruby) defined in `dot_config/mise/config.toml`

## 🔄 Daily Operations

```bash
# Pull latest changes from this repo and re-apply
chezmoi update

# Edit a managed file (opens source file in $EDITOR)
chezmoi edit ~/.zshrc

# See what would change before applying
chezmoi diff

# Add a new file from $HOME into management
chezmoi add ~/.somefile
```

> **Note:** After migrating to chezmoi, editing files in `$HOME` directly does **not** sync back to this repository. Use `chezmoi edit` or edit the source file under `~/.local/share/chezmoi`, then `chezmoi apply`.

## 📂 Directory Structure

```
.
├── dot_zshrc                              # → ~/.zshrc
├── dot_zsh/                               # → ~/.zsh/
│   ├── alias.zsh
│   ├── env.zsh
│   ├── plugin.zsh
│   ├── style.zsh
│   ├── functions/
│   └── bin/executable_reload              # → ~/.zsh/bin/reload (chmod +x)
├── dot_tmux.conf
├── dot_gitconfig
├── dot_Brewfile
├── dot_commit_template
├── dot_vim/
├── dot_wezterm.lua
├── dot_hammerspoon/
├── dot_claude/                            # → ~/.claude/
├── dot_config/
│   ├── nvim/
│   ├── starship.toml
│   └── mise/config.toml                   # mise tool definitions
├── private_Library/
│   └── private_Application Support/Code/User/settings.json   # → VSCode settings
├── run_onchange_install-brew-packages.sh.tmpl
├── run_onchange_configure-macos-defaults.sh
├── run_onchange_configure-xcode.sh
├── run_once_install-zplug.sh
├── run_once_install-dein.sh
├── run_once_install-mise-tools.sh
├── .chezmoiignore                         # files to skip during apply
├── scripts/                               # README generator (CI only)
└── .github/workflows/ci.yml
```

## 🎯 What's Included

### Development Tools

- **Package Managers**: Homebrew, mise
- **Shell**: Zsh with zplug, Starship prompt
- **Terminal**: WezTerm, tmux
- **Editors**: Neovim, VSCode
- **Version Control**: Git, GitHub CLI

### Language Runtimes (managed by mise)

Defined in `dot_config/mise/config.toml`:

- Flutter
- Rust
- Node.js
- Ruby

### Other Stacks

- **iOS Development**: Xcode, XcodeGen, xcbeautify
- **macOS Apps**: Raycast, Hammerspoon, Rectangle, Clipy

## ⚙️ Configuration

### Zsh

Modular configuration in `dot_zsh/`:

- `alias.zsh`: Custom command aliases
- `env.zsh`: Environment variables and PATH setup
- `plugin.zsh`: Zsh plugin configuration via zplug
- `style.zsh`: Prompt and appearance settings

### Git

`dot_gitconfig` provides commit template, GitHub CLI helpers, and standard pull/credential settings.

### Tmux / Vim

Pre-configured tmux key bindings and Vim setup with dein.vim plugin manager.

## 🔧 Customization

1. **Fork this repository** to create your own version
2. **Edit configurations** under `~/.local/share/chezmoi/` (or via `chezmoi edit`)
3. **Apply changes** with `chezmoi apply`
4. **Adjust runtime versions** in `dot_config/mise/config.toml`
5. **Modify packages** in `dot_Brewfile`

## 🤝 Contributing

Feel free to open issues or submit pull requests if you have suggestions for improvements.

## 📄 License

This repository is available under the MIT License. Feel free to fork and modify for your own use.
