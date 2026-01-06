#!/bin/bash
# --- AI Deep Cleanup (Force Version) ---

echo "Starting AI Deep Cleanup..."

# 1. Kill everything first to release file locks
printf "Terminating AI processes... "
pkill -9 -f "antigravity|claude|cline|aider|openhands|mcp" || true
echo "Done."

# 2. Claude
printf "Cleaning Claude Code... "
npm uninstall -g @anthropic-ai/claude-code &>/dev/null
rm -f "$HOME/.local/bin/claude"
rm -rf "$HOME/.claude" "$HOME/.claude-code" "$HOME/.config/claude-code" "$HOME/.cache/claude-code" "$HOME/.claude.json"
echo "Done."

# 3. Cline
printf "Cleaning Cline... "
code --uninstall-extension saoudrizwan.claude-dev --force &>/dev/null
rm -rf "$HOME/Cline" "$HOME/.config/Code/User/globalStorage/saoudrizwan.claude-dev"
echo "Done."

# 4. Antigravity / Gemini (The persistent one)
printf "Cleaning Antigravity & Gemini... "
sudo apt remove -y antigravity anti-gravity &>/dev/null
# FORCE DELETE - even if they are busy
rm -rf "$HOME/.antigravity"
rm -rf "$HOME/.gemini"
rm -rf "$HOME/.config/Antigravity"
rm -rf "$HOME/.cache/Antigravity"
echo "Done."

echo "Cleanup finished. System is clear."
