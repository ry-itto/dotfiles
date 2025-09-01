#!/bin/zsh

# Install tools via mise
if type "mise" > /dev/null; then
    echo "Installing tools via mise..."
    
    # Install tools defined in .mise.toml
    mise install
    
    # Set global versions
    mise use --global flutter@latest
    mise use --global rust@stable
    mise use --global vim@latest
    
    echo "Mise tools installed successfully"
else
    echo "mise is not installed. Please install it via Homebrew first."
    exit 1
fi