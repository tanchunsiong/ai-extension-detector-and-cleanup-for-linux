#!/bin/bash
# --- Extreme AI Agent Detector ---

echo "Running Deep Scan for AI footprint..."

# Define all known AI-related hidden directories
AI_DIRS=(
    "$HOME/.claude" "$HOME/.claude-code" "$HOME/.config/claude-code"
    "$HOME/Cline" "$HOME/RooCode" "$HOME/.config/Code/User/globalStorage/saoudrizwan.claude-dev"
    "$HOME/.antigravity" "$HOME/.gemini" "$HOME/.config/Antigravity"
    "$HOME/.cursor" "$HOME/.windsurf" "$HOME/.codeium" "$HOME/.config/Cursor"
    "$HOME/.aider" "$HOME/.openhands" "$HOME/.continue" "$HOME/.tabnine"
)

found_folders=0
active_locks=0

# 1. Check for directory existence
for dir in "${AI_DIRS[@]}"; do
    if [ -d "$dir" ]; then
        echo -e "[DIR FOUND] $dir"
        ((found_folders++))
        
        # 2. Check for active file locks (someone is using this folder right now)
        lock_info=$(lsof +D "$dir" 2>/dev/null)
        if [ ! -z "$lock_info" ]; then
            echo -e "  |-- \033[1;31m[ACTIVE LOCK]\033[0m A process is currently using this folder!"
            echo "$lock_info" | awk 'NR>1 {print "  |   >> PID: "$2" ("$1")"}' | sort -u
            ((active_locks++))
        fi
    fi
done

# 3. Check for specific AI project files in the current repo
PROJECT_FILES=(".clinerules" ".cursorrules" ".windsurf" "CLAUDE.md" "beads.json")
for file in "${PROJECT_FILES[@]}"; do
    if [ -f "$file" ]; then
        echo -e "[PROJECT FILE] Found $file in current directory."
    fi
done

echo "---------------------------------------"
echo "Scan Summary: $found_folders directories found, $active_locks active processes."
