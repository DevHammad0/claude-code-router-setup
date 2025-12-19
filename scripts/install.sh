#!/bin/bash
set -e

echo "🌟 Starting Automated Setup for Claude Code Router..."

# Update and Install Essentials
sudo apt update && sudo apt upgrade -y
sudo apt install -y curl git build-essential

# Install NVM if not present
if [ ! -d "$HOME/.nvm" ]; then
    echo "📦 Installing NVM..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
fi

# Load NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Install Node LTS
echo "🟢 Installing Node.js LTS..."
nvm install --lts
nvm use --lts

# Install Claude Code & Router
echo "🤖 Installing Claude Code and Router..."
npm install -g @anthropic-ai/claude-code @musistudio/claude-code-router

# Create Config Directory
mkdir -p ~/.claude-code-router

echo -e "\n\033[1;32m✅ ALL DONE!\033[0m"
echo "-------------------------------------------------------"
echo -e "\033[1;33m⚠️  ACTION REQUIRED TO RELOAD YOUR PATH:\033[0m"
echo ""
echo "   Run this command now:"
echo -e "   \033[1;36msource ~/.bashrc\033[0m"
echo ""
echo "   (Or simply close and reopen your WSL terminal)"
echo "-------------------------------------------------------"
echo "Next Steps:"
echo "1. Create your config: nano ~/.claude-code-router/config.json"
echo "2. Run 'ccr code' to start!"
echo "-------------------------------------------------------"