#!/bin/bash
set -e

echo "🌟 Starting Automated Setup for Claude Code Router (Gemini 3 Ready)..."

# 1. Update and Install Essentials
# We do this to ensure your system list is fresh and you have the necessary compilers.
sudo apt update && sudo apt upgrade -y
sudo apt install -y curl git build-essential

# 2. Install NVM (Node Version Manager) if not present
if [ ! -d "$HOME/.nvm" ]; then
    echo "📦 Installing NVM..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
fi

# Load NVM into the current shell session
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# 3. Install Node.js LTS
echo "🟢 Installing Node.js LTS..."
nvm install --lts
nvm use --lts

# 4. Install Claude Code & Router
echo "🤖 Installing Claude Code and Router..."
npm install -g @anthropic-ai/claude-code @musistudio/claude-code-router

# 5. Create Config Directory and Generate Gemini 3 Config
mkdir -p ~/.claude-code-router ~/.claude

echo "📝 Generating optimized config.json..."
cat > ~/.claude-code-router/config.json << 'EOF'
{
  "LOG": true,
  "LOG_LEVEL": "info",
  "HOST": "127.0.0.1",
  "PORT": 3456,
  "APIKEY": "your_secure_password_here",
  "API_TIMEOUT_MS": 600000,
  "Providers": [
    {
      "name": "gemini",
      "api_base_url": "https://generativelanguage.googleapis.com/v1beta/models/",
      "api_key": "$GOOGLE_API_KEY",
      "models": [
        "gemini-3-flash-preview",
        "gemini-3-pro-preview",
        "gemini-2.5-flash-lite",
        "gemini-2.0-flash"
      ],
      "transformer": { "use": ["gemini"] }
    }
  ],
  "Router": {
    "default": "gemini,gemini-2.5-flash-lite",
    "background": "gemini,gemini-2.5-flash-lite",
    "think": "gemini,gemini-2.5-flash-lite",
    "longContext": "gemini,gemini-2.5-flash-lite",
    "longContextThreshold": 60000
  }
}
EOF

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
echo "1. Set your API Key: echo 'export GOOGLE_API_KEY=\"your_key\"' >> ~/.bashrc"
echo "2. Run 'ccr code' to start!"
echo "-------------------------------------------------------"