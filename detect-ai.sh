#!/bin/bash
# --- 2026 Universal AI Footprint Detective (Aggressive) ---

# Comprehensive list of AI-related directories and config files
AI_DIRS=(
    # Claude & Anthropic
    "$HOME/.claude" "$HOME/.claude-code" "$HOME/.config/claude-code" "$HOME/.cache/claude-code"
    # Cline / RooCode (Handles the massive 'tasks' cache)
    "$HOME/Cline" "$HOME/RooCode" "$HOME/.config/Code/User/globalStorage/saoudrizwan.claude-dev"
    "$HOME/.config/Code/User/globalStorage/rooveterinaryinc.roo-cline"
    # Antigravity / Gemini
    "$HOME/.antigravity" "$HOME/.gemini" "$HOME/.config/Antigravity" "$HOME/.cache/Antigravity"
    # OpenCode (SST)
    "$HOME/.opencode" "$HOME/.config/opencode" "$HOME/.local/share/opencode" "$HOME/open-code"
    # Cursor, Windsurf & Continue
    "$HOME/.cursor" "$HOME/.config/Cursor" "$HOME/.windsurf" "$HOME/.codeium" "$HOME/.continue"
    # Aider, OpenHands & General Agents
    "$HOME/.aider" "$HOME/.openhands" "$HOME/.agentfs" "$HOME/.supermaven" "$HOME/.tabnine"
    # Local Inference & Model Stores
    "$HOME/.ollama" "$HOME/.lmstudio" "$HOME/.cache/huggingface"
)

# AI Binaries to search for in PATH
AI_BINS=("claude" "opencode" "antigravity" "aider" "ollama" "cursor" "windsurf" "cline" "roo")

echo "Starting Deep AI Audit..."
echo "----------------------------------------------------"
found_count=0

# 1. Audit Filesystem for Directories
for dir in "${AI_DIRS[@]}"; do
    if [ -d "$dir" ] || [ -f "$dir" ]; then
        echo -e "[FOUND] Path: $dir"
        ((found_count++))
        
        # Check if any process is actively locking/using this directory
        lock_info=$(lsof +D "$dir" 2>/dev/null | awk 'NR>1 {print $1" (PID: "$2")"}' | head -n 1)
        if [ ! -z "$lock_info" ]; then
            echo -e "  |-- ACTIVE PROC: $lock_info"
        fi
    fi
done

# 2. Audit System Binaries
for bin in "${AI_BINS[@]}"; do
    bin_path=$(which "$bin" 2>/dev/null)
    if [ ! -z "$bin_path" ]; then
        echo -e "[FOUND] Binary: $bin_path"
        ((found_count++))
    fi
done

echo "----------------------------------------------------"
if [ $found_count -eq 0 ]; then
    echo "No AI footprints detected. System is clear."
else
    echo "Total $found_count AI footprints detected."
fi
