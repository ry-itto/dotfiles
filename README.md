# dotfiles

My personal dotfiles for macOS development environment setup. This repository contains configurations for various development tools and automated installation scripts.

## 🚀 Quick Start

```bash
# Clone the repository
git clone https://github.com/ry-itto/dotfiles.git ~/ghq/github.com/ry-itto/dotfiles
cd ~/ghq/github.com/ry-itto/dotfiles

# Install everything (dotfiles + dependencies)
make all
```

## 📋 Requirements

- macOS (tested on macOS 14+)
- Command Line Tools for Xcode
- Internet connection for downloading packages

<!-- START ENVIRONMENT INFO -->
## 📦 Package Configuration

> **Tested on**: macOS 15.5 (arm64) - Last updated: 2025-08-22 04:38 UTC

The following packages are defined in `.Brewfile` for installation:

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

### Full Installation (Recommended)

Installs all dotfiles and dependencies:

```bash
make all
```

### Partial Installation

Install only dotfiles (symlinks and configs):

```bash
make install
```

Install only dependencies (Homebrew, tools, etc.):

```bash
make deps
```

### Manual Installation

You can also run individual installer scripts as needed:

```bash
# Install Homebrew and packages
/bin/zsh installers/brew.sh

# Install development tools
/bin/zsh installers/mise.sh    # Version management
/bin/zsh installers/flutter.sh # Flutter SDK
/bin/zsh installers/rust.sh    # Rust toolchain
/bin/zsh installers/vim.sh     # Vim plugins
/bin/zsh installers/xcode.sh   # Xcode tools
/bin/zsh installers/zplug.sh   # Zsh plugin manager
```

## 📂 Directory Structure

```
.
├── .config/           # Application configs (copied to ~/.config/)
│   ├── hammerspoon/   # Hammerspoon automation
│   ├── karabiner/     # Karabiner-Elements key mappings
│   ├── raycast/       # Raycast shortcuts
│   ├── starship.toml  # Starship prompt config
│   └── wezterm/       # WezTerm terminal config
├── .zsh/              # Modular Zsh configuration
│   ├── alias.zsh      # Command aliases
│   ├── env.zsh        # Environment variables
│   ├── plugin.zsh     # Zsh plugins
│   └── style.zsh      # Shell appearance
├── installers/        # Installation scripts
├── scripts/           # Utility scripts
│   ├── collect_environment.sh  # Collect system info
│   └── update_readme.py        # Update README with env info
├── settings/          # Platform-specific settings
│   ├── macos/         # macOS system preferences
│   ├── vscode/        # VSCode settings & extensions
│   └── xcode/         # Xcode themes & templates
├── .Brewfile          # Homebrew bundle definition
├── .commit_template   # Git commit template
├── .gitconfig         # Git configuration
├── .tmux.conf         # Tmux configuration
├── .zshrc             # Main shell configuration
├── CLAUDE.md          # AI assistant instructions
├── README.md          # This file (auto-generated from template)
├── README.template.md # Template for README generation
└── Makefile           # Installation orchestrator
```

## 🎯 What's Included

### Development Tools

- **Package Managers**: Homebrew, mise (for version management)
- **Shell**: Zsh with zplug, Starship prompt
- **Terminal**: WezTerm, tmux
- **Editors**: Neovim, VSCode
- **Version Control**: Git, GitHub CLI, Lazygit

### Development Stacks

- **iOS Development**: Xcode, XcodeGen, Mint, SwiftLint, SwiftFormat
- **Flutter Development**: Flutter SDK, Dart, FVM
- **Web Development**: Node.js (via n), npm packages
- **General**: Go, Rust, Ruby

### macOS Applications

- **Productivity**: Raycast, Hammerspoon, Karabiner-Elements
- **Development**: Docker, Orbstack, TablePlus, Fork
- **Communication**: Slack, Discord, Zoom
- **Utilities**: 1Password, AppCleaner, The Unarchiver

## ⚙️ Configuration

### Zsh

The shell configuration is modular and organized in `.zsh/`:

- `alias.zsh`: Custom command aliases
- `env.zsh`: Environment variables and PATH setup
- `plugin.zsh`: Zsh plugin configuration
- `style.zsh`: Prompt and appearance settings

### Git

Custom Git configuration includes:
- Commit template for consistent commit messages
- Useful aliases and shortcuts
- GitHub CLI integration

### Tmux

Pre-configured with:
- Custom key bindings
- Status bar configuration
- Plugin management via TPM

### Vim/Neovim

Vim configuration includes:

#### Coc Extensions

Install extensions using:

```vim
:CocInstall {extension-name}
```

Included extensions:
- coc-flutter - Flutter/Dart language support

## 🔧 Customization

1. **Fork this repository** to create your own version
2. **Edit configuration files** to match your preferences:
   - Modify `.Brewfile` to add/remove packages
   - Update `.zsh/alias.zsh` for custom aliases
   - Adjust `.gitconfig` with your user information
3. **Add your own dotfiles** - they'll be automatically symlinked
4. **Customize installers** in the `installers/` directory

## 📝 Make Commands

```bash
make all      # Install everything
make install  # Install dotfiles only
make deps     # Install dependencies only
make list     # List all dotfiles to be installed
make help     # Show available commands
```

## 🤝 Contributing

Feel free to open issues or submit pull requests if you have suggestions for improvements.

## 📄 License

This repository is available under the MIT License. Feel free to fork and modify for your own use.

## 🙏 Acknowledgments

Inspired by the dotfiles community and various developers who share their configurations publicly.