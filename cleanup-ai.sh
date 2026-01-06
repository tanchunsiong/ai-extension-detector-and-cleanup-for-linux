#!/bin/bash
# --- AI Deep Cleanup ---

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

# 1. Claude
printf "Cleaning Claude Code "
(
  npm uninstall -g @anthropic-ai/claude-code && \
  rm -f ~/.local/bin/claude && \
  rm -rf ~/.claude ~/.claude-code ~/.config/claude-code ~/.cache/claude-code ~/.claude.json
) &>/dev/null & wait_dots $!

# 2. Cline
printf "Cleaning Cline "
(
  # 1. Kill the process first to release file locks
  pkill -9 -f "saoudrizwan.claude-dev" || true
  
  # 2. Uninstall extension
  code --uninstall-extension saoudrizwan.claude-dev --force || true
  
  # 3. Aggressive recursive delete (force)
  # Using -rf with sudo if necessary, but usually -rf is enough
  rm -rf "$HOME/Cline"
  rm -rf "$HOME/.config/Code/User/globalStorage/saoudrizwan.claude-dev"
) &>/dev/null & wait_dots $!

# 3. Antigravity
printf "Cleaning Antigravity "
(
  sudo apt remove -y antigravity anti-gravity && \
  sudo apt autoremove -y && \
  rm -rf ~/.antigravity ~/.gemini ~/.config/Antigravity ~/.cache/Antigravity && \
  pkill -f antigravity
) &>/dev/null & wait_dots $!

echo "Cleanup finished. System is clear."
