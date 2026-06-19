# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a dotfiles repository for a macOS development environment, managed by [`mise bootstrap`](https://mise.jdx.dev/bootstrap.html). A single `mise.toml` at the repo root declares everything: language runtimes (`[tools]`), dotfile symlinks (`[dotfiles]`), macOS defaults (`[bootstrap.macos.defaults]`), lifecycle hooks (`[bootstrap.hooks]`), and tasks (`[tasks]`). Homebrew packages live in `Brewfile`.

> `mise bootstrap` is **experimental** (requires `experimental = true` / `MISE_EXPERIMENTAL=1`) and was introduced in mise **2026.6.6**. mise itself is installed via Homebrew (`brew 'mise'` in `Brewfile`); bootstrap is a mise subcommand, so mise must exist before it can run.

## Commands

### Setup and Installation

```bash
# First time on a new machine (mise must already be installed via brew)
brew install mise
ghq get ry-itto/dotfiles
cd "$(ghq root)/github.com/ry-itto/dotfiles"
MISE_EXPERIMENTAL=1 mise bootstrap --yes   # env var needed on first run only

# Pull latest changes and re-apply
git pull && mise bootstrap --yes

# Preview without making changes
mise bootstrap --dry-run

# Apply only the dotfile symlinks
mise dotfiles apply
```

### Editing Managed Files

Dotfiles are **symlinks** into `home/` (not copies). Editing `~/.zshrc` edits `home/.zshrc` in this repo directly — no apply step is needed for content changes. Run `mise bootstrap` only when adding new `[tools]` / `[dotfiles]` / packages.

> **Do not delete or move the cloned repo** — the symlinks point into it and would break.

### Adding New Files

Add the source file under `home/` (mirroring its `$HOME` path), then add a `[dotfiles]` entry in `mise.toml` and run `mise dotfiles apply`. `mise dotfiles add ~/.somefile` can do both steps.

## Architecture

### Source Layout

- `mise.toml` — bootstrap config: `[tools]`, `[dotfiles]`, `[bootstrap.macos.defaults]`, `[bootstrap.hooks]`, `[tasks]`.
- `Brewfile` — Homebrew formulae **and casks**. mise's native `[bootstrap.packages]` only resolves formulae, so the Brewfile is the source of truth and is installed via the `brew-bundle` task.
- `home/` — source tree mirroring `$HOME`. Each file/dir is symlinked to its target by `[dotfiles]` (e.g. `home/.zshrc` → `~/.zshrc`). Executable bits are preserved through the symlink.
- `home/.config/mise/config.toml` — the user's **global** mise settings (`idiomatic_version_file_enable_tools`, `experimental = true`), symlinked to `~/.config/mise/config.toml`. Distinct from the repo-root `mise.toml` (the bootstrap orchestrator).

### Bootstrap Step Order

`mise bootstrap` runs steps in this fixed order (see `mise bootstrap --help`):

1. `[bootstrap.packages]` install + `post-packages` hook → `mise run brew-bundle` (Homebrew formulae + casks from `Brewfile`).
2. `[dotfiles]` apply → symlinks under `home/`.
3. `[bootstrap.macos.defaults]` + `post-defaults` hook → declarative defaults, then `mise run macos-extra` for imperative settings (Caps Lock → Control, Xcode dynamic core count, `xcodes install`).
4. `mise install` → language runtimes in `[tools]` (Flutter, Rust, Vim).
5. `bootstrap` task → vim/zsh plugin managers (dein.vim, zplug).

Hooks delegate to tasks because hooks do **not** expand `{{config_root}}` and lack `$MISE_PROJECT_ROOT`; tasks do (and `mise run` works from a hook since the hook's cwd is the repo root).

### Tasks (`[tasks]` in mise.toml)

- `brew-bundle` — `brew bundle` from `Brewfile`. Uses `{{config_root}}/Brewfile`.
- `macos-extra` — imperative macOS settings with no declarative form.
- `bootstrap` — dein.vim + zplug installers. Runs **every** bootstrap, so each step self-gates on an existence check for idempotency.

All tasks exit early when `CI` is set (`[ -n "${CI:-}" ] && exit 0`).

### CI (`.github/workflows/ci.yml`)

- **lint** (ubuntu): shellcheck for non-zsh `.sh`, `zsh -n` syntax check on `home/` zsh files.
- **mise-bootstrap-verify** (macOS): `brew install mise`, validate `mise.toml` (`tasks ls`, `fmt --check`), `mise dotfiles apply` to an ephemeral HOME and assert symlinks resolve, `mise bootstrap --dry-run`, and an idempotency check. Runs with `CI=1` and `MISE_EXPERIMENTAL=1`.

## Development Stack

- **iOS Development**: Xcode, XcodeGen, xcbeautify (Homebrew)
- **Flutter / Rust / Vim**: managed by mise (`[tools]` in `mise.toml`)
- **General**: Git, GitHub CLI, Neovim, Starship prompt, Ghostty, Hammerspoon

## Key Design Principles

1. **Single source of truth**: `mise bootstrap` (`mise.toml`) manages dotfiles, packages, defaults, and tools; Homebrew owns package installation via `Brewfile`.
2. **macOS-only**: no OS branching. `defaults write` and other macOS-specific commands run unconditionally.
3. **Idempotency**: declarative steps (dotfiles, defaults, tools) converge; the `bootstrap` task self-gates on existence checks because it runs on every bootstrap.
4. **Hand-off to upstream tools**: bootstrap delegates package management to Homebrew (`brew bundle`) and runtime management to mise (`mise install`) rather than reimplementing version logic.
5. **Symlinks, not copies**: dotfiles live in `home/` and are symlinked into `$HOME`; the repo must remain present at its clone location.
