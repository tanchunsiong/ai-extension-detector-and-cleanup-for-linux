#!/bin/bash
# --- AI Deep Cleanup (Targeted) ---

# Helper for a simple dot-spinner while waiting
wait_dots() {
  local pid=$1
  while kill -0 "$pid" 2>/dev/null; do
    printf "."
    sleep 0.5
  done
  printf " Done!\n"
}

echo "Starting AI Deep Cleanup..."

# 1. Claude Code
# Targets: Global instructions, project memory, and auth settings
printf "Purging Claude Code "
(
  npm uninstall -g @anthropic-ai/claude-code
  rm -f ~/.local/bin/claude
  rm -rf ~/.claude ~/.claude-code ~/.config/claude-code ~/.cache/claude-code ~/.claude.json
  # Project-level hidden folders (run in current directory)
  rm -rf .claude
) &>/dev/null & wait_dots $!

# 2. Cline
# Targets: Global rules, task history, and the VS Code extension itself
printf "Purging Cline "
(
  pkill -9 -f "saoudrizwan.claude-dev"
  code --uninstall-extension saoudrizwan.claude-dev --force
  # Primary data locations
  rm -rf "$HOME/Cline"
  rm -rf "$HOME/.config/Code/User/globalStorage/saoudrizwan.claude-dev"
  # Clean local repo markers
  rm -f .clinerules
) &>/dev/null & wait_dots $!

# 3. Antigravity / Gemini
# Targets: The 'Brain' directory, planning files, and mission control logs
printf "Purging Antigravity "
(
  pkill -9 -f antigravity
  sudo apt remove -y antigravity anti-gravity
  sudo apt autoremove -y
  # Deep folder wipe
  rm -rf ~/.antigravity ~/.gemini ~/.config/Antigravity ~/.cache/Antigravity
  # Current project 'brain' files
  rm -rf .gemini
) &>/dev/null & wait_dots $!

echo "Cleanup finished. System is clear."
