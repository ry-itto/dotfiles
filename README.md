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
6. Run `run_once_install-mise-tools.sh` to install any tools defined in `dot_config/mise/config.toml` (グローバルでは言語ランタイムを固定しない方針 — 詳細は [プログラミング言語の管理方針](#-プログラミング言語の管理方針))

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
├── dot_gitconfig
├── dot_Brewfile
├── dot_vim/
├── dot_hammerspoon/
├── dot_claude/                            # → ~/.claude/
├── dot_config/
│   ├── ghostty/config
│   ├── nvim/
│   ├── starship.toml
│   └── mise/config.toml                   # mise settings
├── private_Library/
│   └── private_Application Support/Code/User/settings.json   # → VSCode settings
├── run_onchange_install-brew-packages.sh.tmpl
├── run_onchange_configure-macos-defaults.sh
├── run_onchange_configure-xcode.sh
├── run_once_install-zplug.sh
├── run_once_install-dein.sh
├── run_once_install-mise-tools.sh
├── .chezmoiignore                         # files to skip during apply
└── .github/workflows/ci.yml
```

## 🎯 What's Included

### Development Tools

- **Package Managers**: Homebrew, mise
- **Shell**: Zsh with zplug, Starship prompt
- **Editors**: Neovim, VSCode
- **Version Control**: Git, GitHub CLI

### Language Runtimes

[mise](https://mise.jdx.dev/) でプロジェクトごとに管理する。詳細は [プログラミング言語の管理方針](#-プログラミング言語の管理方針) を参照。

### Other Stacks

- **iOS Development**: Xcode, XcodeGen, xcbeautify
- **macOS Apps**: Ghostty, Raycast, Hammerspoon, Rectangle

## ⚙️ Configuration

### Zsh

Modular configuration in `dot_zsh/`:

- `alias.zsh`: Custom command aliases
- `env.zsh`: Environment variables and PATH setup
- `plugin.zsh`: Zsh plugin configuration via zplug
- `style.zsh`: Prompt and appearance settings

### Git

`dot_gitconfig` provides commit template, GitHub CLI helpers, and standard pull/credential settings.

### Vim

Vim setup is wired up via dein.vim. Plugin manifests live under `dot_vim/rc/`.

## 🔧 Customization

1. **Fork this repository** to create your own version
2. **Edit configurations** under `~/.local/share/chezmoi/` (or via `chezmoi edit`)
3. **Apply changes** with `chezmoi apply`
4. **Modify packages** in `dot_Brewfile`

## 🧭 プログラミング言語の管理方針

この dotfiles では **プログラミング言語ランタイムの共通設定（グローバルバージョン）を持たない** 方針を採る。

### ルール

- **プロジェクト側で指定されている場合**: そのプロジェクトの `mise.toml` / `.tool-versions` / `.node-version` / `.ruby-version` などに従い、mise（または各プロジェクト指定の方法）で導入する。
- **その他、ローカルで一時的に必要になった場合**: `mise use -g <tool>@<version>` などで都度グローバルに入れる。dotfiles 側にはコミットしない。
- **dotfiles 管理下の `dot_config/mise/config.toml`**: 言語ランタイムのバージョンは記述しない。mise 自体の設定（例: `idiomatic_version_file_enable_tools`）に限る。

### 理由

共通設定でランタイムのバージョンを固定すると、

- マシンごと・プロジェクトごとのバージョン差異に追従するために dotfiles 側を頻繁に更新することになる
- プロジェクト側の指定とグローバル指定が衝突したときの優先順位の調整が面倒

になる。プロジェクト側の指定を常に優先することで、dotfiles を「環境の土台」だけに保つ。

### 例外: Homebrew 経由で入る言語

Homebrew のフォーミュラの依存関係として Python・Ruby などが入ってしまうケースは許容する。`brew bundle` の出力や `/opt/homebrew/Cellar` 配下に入るものは、ツールの動作に必要な副産物とみなす（プロジェクト用途では mise 側を優先する）。

## 🤝 Contributing

Feel free to open issues or submit pull requests if you have suggestions for improvements.

## 📄 License

This repository is available under the MIT License. Feel free to fork and modify for your own use.
