#!/usr/bin/env python3

import re
import json
from pathlib import Path

def parse_brewfile():
    """Parse .Brewfile and extract package information with categories"""
    brewfile_path = Path(__file__).parent.parent / ".Brewfile"
    
    if not brewfile_path.exists():
        return {"formulae": {}, "casks": {}}
    
    with open(brewfile_path, 'r') as f:
        lines = f.readlines()
    
    result = {
        "formulae": {},
        "casks": {}
    }
    
    current_category = "Uncategorized"
    
    for line in lines:
        line = line.strip()
        
        # Skip empty lines
        if not line:
            continue
            
        # Detect category comments
        if line.startswith('#'):
            current_category = line[1:].strip()
            continue
        
        # Parse brew formula
        brew_match = re.match(r'brew\s+[\'"]([^\'",]+)[\'"](?:,\s*args:\s*\[(.*?)\])?', line)
        if brew_match:
            package = brew_match.group(1)
            args = brew_match.group(2)
            
            if current_category not in result["formulae"]:
                result["formulae"][current_category] = []
            
            package_info = {"name": package}
            
            # Check for specific version or special args
            if args:
                if "HEAD" in args:
                    package_info["version"] = "HEAD"
                # Add other args parsing if needed
                package_info["args"] = args
            
            result["formulae"][current_category].append(package_info)
            continue
        
        # Parse cask
        cask_match = re.match(r'cask\s+[\'"]([^\'",]+)[\'"]', line)
        if cask_match:
            package = cask_match.group(1)
            
            if current_category not in result["casks"]:
                result["casks"][current_category] = []
            
            result["casks"][current_category].append({"name": package})
    
    return result

def get_package_descriptions():
    """Define descriptions for common packages"""
    return {
        # Shell & Terminal
        "zsh": "Z shell - Modern shell with advanced features",
        "zplug": "Zsh plugin manager",
        "tmux": "Terminal multiplexer",
        "starship": "Cross-shell prompt",
        "wezterm": "GPU-accelerated terminal emulator",
        
        # iOS Development
        "xcodegen": "Generate Xcode projects from spec files",
        "xcbeautify": "Xcode build output formatter",
        "mint": "Swift package manager for command line tools",
        
        # Flutter/Mobile
        "usbmuxd": "USB multiplexing daemon for iOS devices",
        "libimobiledevice": "iOS device communication library",
        "ideviceinstaller": "Manage iOS apps from command line",
        "ios-deploy": "Install and debug iOS apps from command line",
        
        # Version Management
        "mise": "Development environment manager (formerly rtx)",
        "n": "Node.js version manager",
        
        # Git & Source Control
        "git": "Distributed version control system",
        "gh": "GitHub CLI",
        "ghq": "Git repository organizer",
        "tig": "Text-mode interface for git",
        "lazygit": "Terminal UI for git commands",
        
        # Search & Navigation
        "ag": "The Silver Searcher - Fast code searching",
        "fzf": "Fuzzy finder for command line",
        "tree": "Display directory tree structure",
        
        # Development Tools
        "nvim": "Neovim - Hyperextensible Vim-based text editor",
        "jq": "JSON processor",
        "nkf": "Network Kanji Filter - Character encoding converter",
        "emojify": "Emoji on the command line",
        "act": "Run GitHub Actions locally",
        "uv": "Fast Python package installer and resolver",
        
        # Language Support
        "protobuf": "Protocol Buffers - Google's data interchange format",
        "openssl@3": "Cryptography and SSL/TLS toolkit",
        "readline": "GNU readline library",
        "libyaml": "YAML parser and emitter library",
        "autoconf": "Automatic configure script builder",
        "gmp": "GNU multiple precision arithmetic library",
        
        # GUI Applications
        "clipy": "Clipboard manager",
        "raycast": "Productivity launcher",
        "rectangle": "Window management app",
        "hammerspoon": "Desktop automation tool",
        "notion": "All-in-one workspace",
        "notion-calendar": "Calendar app by Notion",
        "figma": "Collaborative design tool",
        "discord": "Voice, video, and text chat",
        
        # Fonts
        "font-hack-nerd-font": "Hack font with Nerd Font patches",
        "font-hackgen": "Japanese programming font",
        "font-hackgen-nerd": "HackGen with Nerd Font patches",
    }

def main():
    """Main function to output parsed Brewfile data"""
    data = parse_brewfile()
    descriptions = get_package_descriptions()
    
    # Enhance with descriptions
    for category, packages in data["formulae"].items():
        for package in packages:
            if package["name"] in descriptions:
                package["description"] = descriptions[package["name"]]
    
    for category, packages in data["casks"].items():
        for package in packages:
            if package["name"] in descriptions:
                package["description"] = descriptions[package["name"]]
    
    print(json.dumps(data, indent=2, ensure_ascii=False))

if __name__ == "__main__":
    main()