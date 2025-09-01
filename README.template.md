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

> **Tested on**: {{OS_NAME}} {{OS_VERSION}} ({{ARCH}}) - Last updated: {{UPDATED_AT}}

The following packages are defined in `.Brewfile` for installation:

<details>
<summary>🛠️ Homebrew Formulae ({{FORMULAE_COUNT}} packages)</summary>

{{FORMULAE_LIST}}

</details>

<details>
<summary>🖥️ Homebrew Casks - GUI Applications ({{CASKS_COUNT}} apps)</summary>

{{CASKS_LIST}}

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
/bin/zsh installers/mise.sh    # Version management + Flutter/Rust/Vim
/bin/zsh installers/dein.sh    # Vim plugin manager
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