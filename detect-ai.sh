#!/bin/bash
# --- AI Agent Detective ---

echo "Searching for active AI coding agents..."
echo "---------------------------------------"

# Array of common process keywords for AI agents
keywords=("antigravity" "claude-code" "claude-dev" "cline" "aider" "openhands" "open-devin" "mcp-server")

found=0

for key in "${keywords[@]}"; do
    # Search for processes while ignoring this script and the grep command itself
    processes=$(ps aux | grep -i "$key" | grep -v "grep" | grep -v "detect-ai.sh")
    
    if [ ! -z "$processes" ]; then
        echo -e "\033[1;31m[FOUND]\033[0m Potential agent related to: $key"
        echo "$processes" | awk '{print "  >> PID: "$2" | Command: "$11" "$12" "$13}'
        found=1
    fi
done

if [ $found -eq 0 ]; then
    echo "No hidden AI agents detected. You are in the clear!"
else
    echo "---------------------------------------"
    echo "If you see processes above, run the removal script to kill them."
fi
