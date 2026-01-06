#!/bin/bash
# --- 2026 Extreme AI Agent & Footprint Detective ---

# Define all known AI-related hidden directories & IDE paths
AI_DIRS=(
    # Claude & Anthropic
    "$HOME/.claude" "$HOME/.claude-code" "$HOME/.config/claude-code" "$HOME/.cache/claude-code"
    # Cline, RooCode & VS Code agents
    "$HOME/Cline" "$HOME/RooCode" "$HOME/.config/Code/User/globalStorage/saoudrizwan.claude-dev"
    # Google Antigravity & Gemini
    "$HOME/.antigravity" "$HOME/.gemini" "$HOME/.config/Antigravity" "$HOME/.cache/Antigravity"
    # OpenCode & OpenDevin
    "$HOME/.opencode" "$HOME/.open-devin" "$HOME/open-code" "$HOME/.config/opencode"
    # Cursor, Windsurf & Continue
    "$HOME/.cursor" "$HOME/.windsurf" "$HOME/.continue" "$HOME/.codeium" "$HOME/.config/Cursor"
    # Aider & Misc CLI
    "$HOME/.aider" "$HOME/.aider.conf.yml" "$HOME/.openhands" "$HOME/.supermaven"
    # Local Inference
    "$HOME/.ollama" "$HOME/.lmstudio"
)

# Known agent process patterns
PROCESS_REGEX="antigravity|claude|cline|aider|openhands|opencode|mcp|ollama|cursor|windsurf|cascade|roocode"

echo -e "\033[1;34m[SCANNIG]\033[0m Deep-audit of AI footprints starting..."
echo "----------------------------------------------------"

found_any=0

# 1. Check for directory existence
for dir in "${AI_DIRS[@]}"; do
    if [ -d "$dir" ] || [ -f "$dir" ]; then
        echo -e "\033[1;33m[FOUND]\033[0m Path: $dir"
        found_any=1
        
        # Check if any process is currently locking this folder
        lock_info=$(lsof +D "$dir" 2>/dev/null)
        if [ ! -z "$lock_info" ]; then
            echo -e "  \033[1;31m|-- ACTIVE LOCK:\033[0m A process is using this folder right now!"
            echo "$lock_info" | awk 'NR>1 {print "  |   >> PID: "$2" ("$1")"}' | sort -u
        fi
    fi
done

# 2. Aggressive Process Check (matches full command line)
echo -e "\n\033[1;34m[CHECKING]\033[0m Active AI processes..."
active_procs=$(pgrep -af "$PROCESS_REGEX" | grep -v "detect-ai.sh")
if [ ! -z "$active_procs" ]; then
    echo -e "$active_procs" | awk '{print "\033[1;31m[ACTIVE]\033[0m PID: "$1" | Cmd: "$2" "$3}'
    found_any=1
else
    echo "  >> No matching AI processes found."
fi

# 3. Project-Level "Marker" Files (Checks current directory)
echo -e "\n\033[1;34m[CHECKING]\033[0m Project-level AI markers..."
PROJECT_MARKERS=(".clinerules" ".cursorrules" ".windsurf" "CLAUDE.md" "beads.json" ".continuerc.json" ".aider*")
for marker in "${PROJECT_MARKERS[@]}"; do
    match=$(ls $marker 2>/dev/null)
    if [ ! -z "$match" ]; then
        echo -e "\033[1;35m[MARKER]\033[0m Found AI rule file: $match"
        found_any=1
    fi
done

# 4. Local AI Port Scan
echo -e "\n\033[1;34m[CHECKING]\033[0m AI Sidecar Ports (Ollama/MCP/Local APIs)..."
# 11434: Ollama, 3000/8000/8080: Common for agent web UIs
ports=$(ss -lntp | grep -E "11434|3000|8000|8080" | grep -v "grep")
if [ ! -z "$ports" ]; then
    echo -e "\033[1;35m[PORT]\033[0m Detected traffic on potential AI ports:\n$ports"
    found_any=1
fi

echo "----------------------------------------------------"
if [ $found_any -eq 0 ]; then
    echo -e "\033[1;32m[CLEAN]\033[0m No AI footprints detected. You are in a blank state."
else
    echo -e "\033[1;31m[ALERT]\033[0m AI footprints detected. Use cleanup-ai.sh to purge."
fi
