#!/bin/zsh
set -eu

[[ -n "${CI:-}" ]] && exit 0

if ! command -v xcodebuild >/dev/null 2>&1; then
	xcodes install --latest
fi

# Show build duration in Xcode
defaults write com.apple.dt.Xcode ShowBuildOperationDuration YES

# Use all available cores for parallel builds
cores=$(sysctl -n hw.ncpu)
defaults write com.apple.dt.Xcode IDEBuildOperationMaxNumberOfConcurrentCompileTasks "$cores"

# Trim whitespace-only lines
defaults write com.apple.dt.Xcode DVTTextEditorTrimWhitespaceOnlyLines -bool true
