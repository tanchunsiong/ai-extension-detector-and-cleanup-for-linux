When moving to advanced AI orchestration systems like Gas Town, OpenCode.ai, or Vibe Kanban, legacy background processes from tools like Antigravity, Cline (Claude-Dev), and Claude Code can cause "process thrashing," file locks, and context pollution.

This repository provides two surgical tools to audit and deep-clean your Linux development environment.

🔍 The Tools
detect-ai.sh: A "Sentry" script that identifies hidden AI background processes, MCP servers, and "zombie" agents running under generic Node/Python headers.

cleanup-ai.sh: The "Janitor" script. It force-kills active agents and performs a "Deep Wipe" of hidden configuration folders, cache, and persistent task memories (Beads/Rules).

🚀 Quick Start
1. Clone the repository
Bash

git clone https://github.com/tanchunsiong/ai-extension-detector-and-cleanup-for-linux.git
cd ai-extension-detector-and-cleanup-for-linux
2. Make the scripts executable
Bash

chmod +x detect-ai.sh cleanup-ai.sh
3. Run the Detector
Use this first to see what "Monkeys" are currently running on your system:

Bash

./detect-ai.sh
4. Run the Cleanup
Warning: This is a destructive operation. It will wipe your conversation histories and local agent settings for the targeted tools.

Bash

./cleanup-ai.sh
🎯 Target List
This tool identifies and removes footprints from:

Google Antigravity (Packages, GPG keys, and ~/.gemini cache)

Cline / Claude-Dev (Global rules, task history, and VS Code storage)

Claude Code CLI (MCP configs, __store.db, and Auth states)

Aider (Persistent history and repo maps)

OpenHands (Orphaned background processes)

🛠️ Why is this necessary?
In the era of "Vibe Coding," having multiple agents from different ecosystems (e.g., a Cline agent in VS Code and a Gas Town horde in Tmux) trying to edit the same file is a recipe for a "facemelt."

This utility ensures your "factory floor" is empty before you deploy your next "Horde."

📜 License
MIT - Clean your pipes and build something great.
