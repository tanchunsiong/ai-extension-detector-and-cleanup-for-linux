#!/bin/bash
# --- Interactive AI Cleanup & Removal ---

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

clean_claude() {
    printf "${BLUE}Purging Claude Code...${NC}\n"
    npm uninstall -g @anthropic-ai/claude-code 2>/dev/null
    rm -rf "$HOME/.claude" "$HOME/.claude-code" "$HOME/.config/claude-code" "$HOME/.claude.json"
    echo -e "${GREEN}Claude cleared.${NC}"
}

clean_cline() {
    printf "${BLUE}Purging Cline...${NC}\n"
    pkill -9 -f "saoudrizwan.claude-dev" || true
    code --uninstall-extension saoudrizwan.claude-dev --force 2>/dev/null
    rm -rf "$HOME/Cline" "$HOME/.config/Code/User/globalStorage/saoudrizwan.claude-dev"
    echo -e "${GREEN}Cline cleared.${NC}"
}

clean_antigravity() {
    printf "${BLUE}Purging Antigravity/Gemini...${NC}\n"
    pkill -9 -f antigravity || true
    sudo apt remove -y antigravity anti-gravity 2>/dev/null
    sudo apt autoremove -y 2>/dev/null
    rm -rf "$HOME/.antigravity" "$HOME/.gemini" "$HOME/.config/Antigravity"
    echo -e "${GREEN}Antigravity cleared.${NC}"
}

clean_opencode() {
    printf "${BLUE}Purging OpenCode...${NC}\n"
    pkill -9 -f "opencode|open-devin" || true
    # Try multiple package managers for OpenCode
    npm uninstall -g opencode-ai 2>/dev/null
    sudo apt remove -y opencode 2>/dev/null
    rm -rf "$HOME/.opencode" "$HOME/.config/opencode" "$HOME/.local/share/opencode" "$HOME/open-code"
    echo -e "${GREEN}OpenCode cleared.${NC}"
}

echo -e "${BLUE}======================================${NC}"
echo -e "${BLUE}    AI AGENT INTERACTIVE CLEANUP      ${NC}"
echo -e "${BLUE}======================================${NC}"
echo "1) Remove Claude Code"
echo "2) Remove Cline"
echo "3) Remove Antigravity / Gemini"
echo "4) Remove OpenCode"
echo -e "${RED}5) REMOVE ALL (Nuke Everything)${NC}"
echo "6) Exit"
echo "--------------------------------------"
read -p "Select choice [1-6]: " choice

case $choice in
    1) clean_claude ;;
    2) clean_cline ;;
    3) clean_antigravity ;;
    4) clean_opencode ;;
    5) 
        echo -e "${RED}Final Warning: Nuking all AI agents...${NC}"
        clean_claude; clean_cline; clean_antigravity; clean_opencode
        ;;
    6) exit 0 ;;
    *) echo "Invalid choice." ;;
esac

echo -e "\n${GREEN}Done. Your system is now prepped for Stage 8 orchestration.${NC}"
