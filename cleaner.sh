#!/bin/bash
# --- AI Deep Cleanup & Removal ---

echo "Initiating deep removal of AI agent footprints..."

# 1. Kill the background 'Monkeys'
echo "Killing background processes..."
# -f matches the full command line, catching agents running via Node/Python
pkill -9 -f "antigravity"
pkill -9 -f "claude-code"
pkill -9 -f "saoudrizwan.claude-dev"
pkill -9 -f "cline"
pkill -9 -f "aider"
pkill -9 -f "openhands"

# 2. Delete Persistence Folders (Memory/Configs)
echo "Wiping persistent agent memory and configurations..."

# Antigravity (Google)
rm -rf ~/.antigravity ~/.config/Antigravity ~/.cache/Antigravity ~/.gemini

# Claude Code (Anthropic)
rm -rf ~/.claude ~/.claude-code ~/.config/claude-code ~/.cache/claude-code ~/.claude.json

# Cline / Claude-Dev (VS Code)
rm -rf ~/Cline
rm -rf ~/.config/Code/User/globalStorage/saoudrizwan.claude-dev

# Aider & OpenHands
rm -rf ~/.aider* # (Careful: OpenHands usually runs in Docker, but removes local logs/configs here)
rm -rf ~/.openhands

# 3. Final Package Cleanup
if command -v antigravity &> /dev/null; then
    sudo apt-get remove -y antigravity 2>/dev/null
    sudo rm -f /etc/apt/sources.list.d/antigravity.list
fi

echo "-------------------------------------------"
echo "Cleanup complete. Your system is now a blank slate."
