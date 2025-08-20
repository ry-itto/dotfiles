#!/bin/zsh

# Collect environment information for README
# This script outputs JSON format for easy parsing

set -e

# Initialize JSON output
echo "{"

# System Information
echo '  "system": {'
echo '    "os": "'$(sw_vers -productName)'",'
echo '    "version": "'$(sw_vers -productVersion)'",'
echo '    "arch": "'$(uname -m)'",'
echo '    "kernel": "'$(uname -r)'"'
echo '  },'

# Homebrew packages
echo '  "homebrew": {'
if command -v brew &> /dev/null; then
    echo '    "version": "'$(brew --version | head -n1 | cut -d' ' -f2)'",'
    echo '    "formulae": ['
    
    # Get installed formulae with versions
    first=true
    brew list --formula --versions | while IFS= read -r line; do
        if [ "$first" = true ]; then
            first=false
        else
            echo ","
        fi
        name=$(echo "$line" | cut -d' ' -f1)
        version=$(echo "$line" | cut -d' ' -f2-)
        printf '      {"name": "%s", "version": "%s"}' "$name" "$version"
    done
    
    echo ''
    echo '    ],'
    echo '    "casks": ['
    
    # Get installed casks
    first=true
    brew list --cask --versions 2>/dev/null | while IFS= read -r line; do
        if [ "$first" = true ]; then
            first=false
        else
            echo ","
        fi
        name=$(echo "$line" | cut -d' ' -f1)
        version=$(echo "$line" | cut -d' ' -f2-)
        printf '      {"name": "%s", "version": "%s"}' "$name" "$version"
    done
    
    echo ''
    echo '    ]'
else
    echo '    "version": "not installed",'
    echo '    "formulae": [],'
    echo '    "casks": []'
fi
echo '  },'

# Programming Languages and Tools
echo '  "languages": {'

# Node.js
if command -v node &> /dev/null; then
    echo '    "node": "'$(node --version)'",'
else
    echo '    "node": "not installed",'
fi

# npm
if command -v npm &> /dev/null; then
    echo '    "npm": "'$(npm --version)'",'
else
    echo '    "npm": "not installed",'
fi

# Python
if command -v python3 &> /dev/null; then
    echo '    "python": "'$(python3 --version 2>&1 | cut -d' ' -f2)'",'
else
    echo '    "python": "not installed",'
fi

# Ruby
if command -v ruby &> /dev/null; then
    echo '    "ruby": "'$(ruby --version | cut -d' ' -f2)'",'
else
    echo '    "ruby": "not installed",'
fi

# Go
if command -v go &> /dev/null; then
    echo '    "go": "'$(go version | cut -d' ' -f3 | sed 's/go//')'",'
else
    echo '    "go": "not installed",'
fi

# Rust
if command -v rustc &> /dev/null; then
    echo '    "rust": "'$(rustc --version | cut -d' ' -f2)'",'
else
    echo '    "rust": "not installed",'
fi

# Dart
if command -v dart &> /dev/null; then
    echo '    "dart": "'$(dart --version 2>&1 | cut -d' ' -f4)'",'
else
    echo '    "dart": "not installed",'
fi

# Flutter
if command -v flutter &> /dev/null; then
    flutter_version=$(flutter --version 2>/dev/null | head -n1 | cut -d' ' -f2)
    echo '    "flutter": "'$flutter_version'"'
else
    echo '    "flutter": "not installed"'
fi

echo '  },'

# Development Tools
echo '  "tools": {'

# Git
if command -v git &> /dev/null; then
    echo '    "git": "'$(git --version | cut -d' ' -f3)'",'
else
    echo '    "git": "not installed",'
fi

# Docker
if command -v docker &> /dev/null; then
    echo '    "docker": "'$(docker --version | cut -d' ' -f3 | sed 's/,//')'",'
else
    echo '    "docker": "not installed",'
fi

# tmux
if command -v tmux &> /dev/null; then
    echo '    "tmux": "'$(tmux -V | cut -d' ' -f2)'",'
else
    echo '    "tmux": "not installed",'
fi

# Neovim
if command -v nvim &> /dev/null; then
    echo '    "neovim": "'$(nvim --version | head -n1 | cut -d' ' -f2)'",'
else
    echo '    "neovim": "not installed",'
fi

# Starship
if command -v starship &> /dev/null; then
    echo '    "starship": "'$(starship --version | head -n1 | cut -d' ' -f2)'",'
else
    echo '    "starship": "not installed",'
fi

# GitHub CLI
if command -v gh &> /dev/null; then
    echo '    "gh": "'$(gh --version | head -n1 | cut -d' ' -f3)'",'
else
    echo '    "gh": "not installed",'
fi

# mise
if command -v mise &> /dev/null; then
    echo '    "mise": "'$(mise --version 2>&1 | cut -d' ' -f2)'",'
else
    echo '    "mise": "not installed",'
fi

# fzf
if command -v fzf &> /dev/null; then
    echo '    "fzf": "'$(fzf --version | cut -d' ' -f1)'"'
else
    echo '    "fzf": "not installed"'
fi

echo '  },'

# Shell Information
echo '  "shell": {'
echo '    "default": "'$SHELL'",'
echo '    "zsh_version": "'$ZSH_VERSION'"'
echo '  },'

# Timestamp
echo '  "updated_at": "'$(date -u +"%Y-%m-%dT%H:%M:%SZ")'"'

echo "}"