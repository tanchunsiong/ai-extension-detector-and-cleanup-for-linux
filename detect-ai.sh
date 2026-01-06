#!/bin/bash
# --- 2026 Universal AI Footprint Detector ---

# Comprehensive list of AI-related directories
AI_DIRS=(
    # --- The Big Three (Anthropic, Google, VSCode) ---
    "$HOME/.claude" "$HOME/.claude-code" "$HOME/.config/claude-code" "$HOME/.cache/claude-code"
    "$HOME/.antigravity" "$HOME/.gemini" "$HOME/.config/Antigravity" "$HOME/.cache/Antigravity"
    "$HOME/Cline" "$HOME/RooCode" "$HOME/.config/Code/User/globalStorage/saoudrizwan.claude-dev"
    
    # --- Advanced Orchestrators & Agents ---
    "$HOME/.opencode" "$HOME/.open-devin" "$HOME/open-code" "$HOME/.config/opencode"
    "$HOME/.aider" "$HOME/.aider.conf.yml" "$HOME/.openhands" "$HOME/.agentfs"
    "$HOME/.supermaven" "$HOME/.tabnine" "$HOME/.continue" "$HOME/.codeium"
    
    # --- AI-Native IDEs & Extensions ---
    "$HOME/.cursor" "$HOME/.config/Cursor" "$HOME/.windsurf" "$HOME/.codeium/windsurf"
    "$HOME/.zed" "$HOME/.config/zed" "$HOME/.jetbrains/ai-assistant"
    
    # --- Local Inference & Model Servers ---
    "$HOME/.ollama" "$HOME/.lmstudio" "$HOME/.local/share/ollama"
    "$HOME/.config/vllm" "$HOME/.cache/huggingface"
)

# Known AI Binaries in PATH
AI_BINS=(
    "claude" "opencode" "antigravity" "aider" "ollama" 
    "cursor" "windsurf" "openhands" "mcp" "cline"
)

echo -e "\033[1;34m[DETECTOR]\033[0m Starting deep-audit for AI footprints..."
echo "----------------------------------------------------"

found_count=0

# 1. Audit Filesystem Directories
for dir in "${AI_DIRS[@]}"; do
    if [ -d "$dir" ] || [ -f "$dir" ]; then
        echo -e "\033[1;33m[FOUND]\033[0m Path: $dir"
        ((found_count++))
        
        # Check if any process is currently holding a lock on this folder
        lock_info=$(lsof +D "$dir" 2>/dev/null)
        if [ ! -z "$lock_info" ]; then
            echo -e "  \033[1;31m|-- ACTIVE LOCK:\033[0m $(echo "$lock_info" | awk 'NR>1 {print $1" (PID: "$2")"}' | head -n 1)"
        fi
    fi
done

# 2. Audit Installed Binaries
for bin in "${AI_BINS[@]}"; do
    if command -v "$bin" &> /dev/null; then
        echo -e "\033[1;36m[BINARY]\033[0m $bin installed at: $(which "$bin")"
        ((found_count++))
    fi
done

echo "----------------------------------------------------"
if [ $found_count -eq 0 ]; then
    echo -e "\033[1;32m[CLEAN]\033[0m No AI agent footprints found. System is a blank slate."
else
    echo -e "\033[1;31m[ALERT]\033[0m $found_count AI footprints detected. Use cleanup-ai.sh to purge."
fi
