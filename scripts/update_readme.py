#!/usr/bin/env python3

import json
import sys
import subprocess
from datetime import datetime
from pathlib import Path

def run_command(cmd):
    """Run a shell command and return output"""
    try:
        result = subprocess.run(cmd, shell=True, capture_output=True, text=True)
        return result.stdout.strip()
    except Exception as e:
        print(f"Error running command '{cmd}': {e}", file=sys.stderr)
        return None

def collect_environment():
    """Collect environment information"""
    script_path = Path(__file__).parent / "collect_environment.sh"
    output = run_command(f"zsh {script_path}")
    if output:
        try:
            return json.loads(output)
        except json.JSONDecodeError as e:
            print(f"Error parsing JSON: {e}", file=sys.stderr)
            print(f"Output was: {output}", file=sys.stderr)
    return None

def parse_brewfile():
    """Parse .Brewfile to get intended packages"""
    script_path = Path(__file__).parent / "parse_brewfile.py"
    output = run_command(f"python3 {script_path}")
    if output:
        try:
            return json.loads(output)
        except json.JSONDecodeError as e:
            print(f"Error parsing Brewfile JSON: {e}", file=sys.stderr)
    return {"formulae": {}, "casks": {}}

def format_languages_table(languages):
    """Format programming languages as a markdown table"""
    lines = ["| Language | Version |", "|----------|---------|"]
    
    lang_display = {
        "node": "Node.js",
        "npm": "npm",
        "python": "Python",
        "ruby": "Ruby",
        "go": "Go",
        "rust": "Rust",
        "dart": "Dart",
        "flutter": "Flutter"
    }
    
    for key, version in languages.items():
        if version != "not installed":
            display_name = lang_display.get(key, key.title())
            lines.append(f"| {display_name} | `{version}` |")
    
    return "\n".join(lines)

def format_tools_table(tools):
    """Format development tools as a markdown table"""
    lines = ["| Tool | Version |", "|------|---------|"]
    
    tool_display = {
        "git": "Git",
        "docker": "Docker",
        "tmux": "tmux",
        "neovim": "Neovim",
        "starship": "Starship",
        "gh": "GitHub CLI",
        "mise": "mise",
        "fzf": "fzf"
    }
    
    for key, version in tools.items():
        if version != "not installed":
            display_name = tool_display.get(key, key.title())
            lines.append(f"| {display_name} | `{version}` |")
    
    return "\n".join(lines)

def format_brewfile_packages(brewfile_data, package_type="formulae"):
    """Format packages from Brewfile with categories and descriptions"""
    packages = brewfile_data.get(package_type, {})
    
    if not packages:
        return f"*No {package_type} defined*"
    
    lines = []
    
    for category, items in packages.items():
        if not items:
            continue
            
        # Add category header
        lines.append(f"\n**{category}**\n")
        
        for item in items:
            name = item['name']
            description = item.get('description', '')
            version = item.get('version', '')
            
            # Format the line
            if version and version != 'unknown':
                if version == 'HEAD':
                    line = f"- `{name}` (latest development version)"
                else:
                    line = f"- `{name}` (v{version})"
            else:
                line = f"- `{name}`"
            
            # Add description if available
            if description:
                line += f" - {description}"
            
            lines.append(line)
    
    return "\n".join(lines)

def update_readme(env_data, brewfile_data):
    """Update README.md with environment information"""
    template_path = Path(__file__).parent.parent / "README.template.md"
    readme_path = Path(__file__).parent.parent / "README.md"
    
    if not template_path.exists():
        print(f"Template file not found: {template_path}", file=sys.stderr)
        return False
    
    # Read template
    with open(template_path, 'r') as f:
        content = f.read()
    
    # Count total packages from Brewfile
    formulae_count = sum(len(items) for items in brewfile_data.get('formulae', {}).values())
    casks_count = sum(len(items) for items in brewfile_data.get('casks', {}).values())
    
    # Prepare replacement values
    replacements = {
        "{{OS_NAME}}": env_data['system']['os'],
        "{{OS_VERSION}}": env_data['system']['version'],
        "{{ARCH}}": env_data['system']['arch'],
        "{{UPDATED_AT}}": datetime.fromisoformat(env_data['updated_at'].replace('Z', '+00:00')).strftime('%Y-%m-%d %H:%M UTC'),
        "{{FORMULAE_COUNT}}": str(formulae_count),
        "{{FORMULAE_LIST}}": format_brewfile_packages(brewfile_data, "formulae"),
        "{{CASKS_COUNT}}": str(casks_count),
        "{{CASKS_LIST}}": format_brewfile_packages(brewfile_data, "casks")
    }
    
    # Replace placeholders
    for placeholder, value in replacements.items():
        content = content.replace(placeholder, value)
    
    # Write updated README
    with open(readme_path, 'w') as f:
        f.write(content)
    
    print(f"✅ README.md updated successfully")
    print(f"   - Environment: {env_data['system']['os']} {env_data['system']['version']} ({env_data['system']['arch']})")
    print(f"   - {formulae_count} Homebrew formulae defined in .Brewfile")
    print(f"   - {casks_count} Homebrew casks defined in .Brewfile")
    
    return True

def main():
    """Main function"""
    print("📊 Collecting environment information...")
    env_data = collect_environment()
    
    if not env_data:
        print("❌ Failed to collect environment information", file=sys.stderr)
        sys.exit(1)
    
    print("📦 Parsing .Brewfile...")
    brewfile_data = parse_brewfile()
    
    print("📝 Updating README.md...")
    if update_readme(env_data, brewfile_data):
        sys.exit(0)
    else:
        sys.exit(1)

if __name__ == "__main__":
    main()