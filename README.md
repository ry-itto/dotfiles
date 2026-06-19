# dotfiles

My personal dotfiles for macOS development environment, managed by [`mise bootstrap`](https://mise.jdx.dev/bootstrap.html).

## 🚀 Quick Start

```bash
# Install mise if you don't have it
brew install mise

# Clone and bootstrap (MISE_EXPERIMENTAL is required the first time — see below)
ghq get ry-itto/dotfiles   # or: git clone https://github.com/ry-itto/dotfiles
cd "$(ghq root)/github.com/ry-itto/dotfiles"
MISE_EXPERIMENTAL=1 mise bootstrap --yes
```

## 📋 Requirements

- macOS (this configuration is macOS-only)
- Command Line Tools for Xcode
- [mise](https://mise.jdx.dev/) ≥ `2026.6.6` (the `mise bootstrap` command was introduced there)
- Internet connection for downloading packages

## 🛠 Installation

```bash
brew install mise
ghq get ry-itto/dotfiles
cd "$(ghq root)/github.com/ry-itto/dotfiles"
MISE_EXPERIMENTAL=1 mise bootstrap --yes
```

`mise bootstrap` runs these steps in order (see `mise bootstrap --help`):

1. **Homebrew packages** — the `post-packages` hook runs `mise run brew-bundle`, which installs formulae **and casks** from the `Brewfile` (mise's native `[bootstrap.packages]` only supports formulae, so the `Brewfile` stays the source of truth).
2. **Dotfiles** — `[dotfiles]` symlinks the sources under `home/` into `$HOME` (e.g. `home/.zshrc` → `~/.zshrc`).
3. **macOS defaults** — `[bootstrap.macos.defaults]` writes Finder/keyboard/Xcode settings; the `post-defaults` hook runs `mise run macos-extra` for the imperative bits (Caps Lock → Control, Xcode dynamic core count, `xcodes install`).
4. **Tools** — `mise install` installs the language runtimes in `[tools]` (グローバルでは言語ランタイムを固定しない方針 — 詳細は [プログラミング言語の管理方針](#-プログラミング言語の管理方針)).
5. **`bootstrap` task** — installs the vim/zsh plugin managers (dein.vim, zplug).

> **Why `MISE_EXPERIMENTAL=1`?** `mise bootstrap` is experimental. On an already-bootstrapped machine `experimental = true` lives in `~/.config/mise/config.toml` (symlinked from `home/.config/mise/config.toml`), but on a fresh machine that file does not exist yet, so the **first** bootstrap must set the env var.

> **One-time mise consolidation:** if a self-installed mise exists at `~/.local/bin/mise` (from `curl mise.run`), it can shadow the Homebrew mise on `PATH`. This repo standardises on the Homebrew mise — remove the self-installed one (`rm ~/.local/bin/mise`) so `mise activate` and `mise bootstrap` use the Homebrew build.

## 🔄 Daily Operations

```bash
# Pull latest changes and re-apply everything
git -C "$(ghq root)/github.com/ry-itto/dotfiles" pull
mise bootstrap --yes

# Preview what bootstrap would do (no changes made)
mise bootstrap --dry-run

# Apply only the dotfile symlinks
mise dotfiles apply

# Show dotfile / package / defaults status
mise dotfiles status
mise bootstrap packages status
```

> **Note:** dotfiles are **symlinks** into this repository (not copies). Editing `~/.zshrc` edits `home/.zshrc` in the repo directly — no separate "apply" step is needed for content changes. The flip side: **do not delete or move the cloned repo**, or the symlinks will break. New entries (`[tools]`, `[dotfiles]`, packages) still require a `mise bootstrap` run.

## 📂 Directory Structure

```
.
├── mise.toml                              # bootstrap config: [tools] / [dotfiles] / [bootstrap.*] / [tasks]
├── Brewfile                               # Homebrew formulae + casks (installed via the brew-bundle task)
├── home/                                  # source tree mirroring $HOME (symlinked by `mise dotfiles apply`)
│   ├── .zshrc                             # → ~/.zshrc
│   ├── .zsh/                              # → ~/.zsh/
│   │   ├── alias.zsh
│   │   ├── env.zsh
│   │   ├── plugin.zsh
│   │   ├── style.zsh
│   │   ├── functions/
│   │   └── bin/reload                     # → ~/.zsh/bin/reload (executable)
│   ├── .gitconfig
│   ├── .vim/
│   ├── .hammerspoon/
│   ├── .claude/settings.json             # → ~/.claude/settings.json (only this file is symlinked)
│   ├── .config/
│   │   ├── ghostty/config
│   │   ├── nvim/
│   │   ├── starship.toml
│   │   └── mise/config.toml              # mise settings (incl. experimental = true)
│   └── Library/Application Support/Code/User/settings.json   # → VSCode settings
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

Modular configuration in `home/.zsh/`:

- `alias.zsh`: Custom command aliases
- `env.zsh`: Environment variables and PATH setup
- `plugin.zsh`: Zsh plugin configuration via zplug
- `style.zsh`: Prompt and appearance settings

### Git

`home/.gitconfig` provides commit template, GitHub CLI helpers, and standard pull/credential settings.

### Vim

Vim setup is wired up via dein.vim. Plugin manifests live under `home/.vim/rc/`.

## 🔧 Customization

1. **Fork this repository** to create your own version
2. **Edit configurations** under `home/` (or edit the symlinked file in `$HOME` directly — it's the same file)
3. **Apply new entries** (tools, dotfiles, packages) with `mise bootstrap` — content edits to already-symlinked files need no re-apply
4. **Modify packages** in `Brewfile`

## 🧭 プログラミング言語の管理方針

この dotfiles では **プログラミング言語ランタイムの共通設定（グローバルバージョン）を持たない** 方針を採る。

### ルール

- **プロジェクト側で指定されている場合**: そのプロジェクトの `mise.toml` / `.tool-versions` / `.node-version` / `.ruby-version` などに従い、mise（または各プロジェクト指定の方法）で導入する。
- **その他、ローカルで一時的に必要になった場合**: `mise use -g <tool>@<version>` などで都度グローバルに入れる。dotfiles 側にはコミットしない。
- **dotfiles 管理下の `home/.config/mise/config.toml`**: 言語ランタイムのバージョンは記述しない。mise 自体の設定（例: `idiomatic_version_file_enable_tools`、`experimental`）に限る。なお、この dotfiles 環境自体が使う Flutter / Rust / Vim はリポジトリ直下の `mise.toml` の `[tools]` で定義する。

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
