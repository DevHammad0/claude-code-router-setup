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

echo "✅ ALL DONE!"
echo "-------------------------------------------------------"
echo "1. Restart your terminal (or run: source ~/.bashrc)"
echo "2. Create your config file: nano ~/.claude-code-router/config.json"
echo "3. Run 'ccr code' to start!"
echo "-------------------------------------------------------"