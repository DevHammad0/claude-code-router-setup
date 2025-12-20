# 🚀 Claude Code Router: Master Setup Guide (WSL + Gemini)

This repository is the official companion for our YouTube tutorial on setting up **Claude Code** inside Windows using **WSL2**. We use the **Claude Code Router (CCR)** to unlock **Google Gemini** models directly within the Anthropic CLI.

---

## 🛠 Step 0: Install Windows Subsystem for Linux (WSL)

**Important:** This is the first thing you need to do. We are setting up a Linux environment where **Claude Code** will run.

### 1. Open PowerShell as Administrator

* Press the **Windows** key
* Search for **PowerShell**
* Click **Run as administrator**
* Click **Yes**

### 2. Run the Install Command

```powershell
wsl --install
```

### 3. Downloading & Launching

* Windows will download and install WSL
* Ubuntu will launch automatically
* Stay in the same window while it provisions

### 4. Set Your Username & Password

* Enter a **username**
* Enter a **password**
* Confirm the password

> ⚠️ Password typing is hidden. This is normal in Linux.

### 5. Success

When you see something like:

```bash
hammad@PC:/mnt/c/WINDOWS/system32$

```

Keep this terminal open and continue.

---

## ⚡ Method 1: Automated "Speedrun" Script

### 1. Run the Installer
Inside your **WSL / Ubuntu** terminal, run:

```bash
curl -sSL https://raw.githubusercontent.com/devhammad0/claude-code-router-setup/main/scripts/install.sh | bash

```

> After the script finishes:

```bash
source ~/.bashrc
```

### 2. Set Your Google API Key
Replace `YOUR_KEY_HERE` with your key from <a href="https://aistudio.google.com/" target="_blank">Google AI Studio</a>:

```bash
echo 'export GOOGLE_API_KEY="YOUR_KEY_HERE"' >> ~/.bashrc
```

### 3. Reload your Environment

```bash
source ~/.bashrc
```

### 4. Laucnh Claude Code Router

```bash
ccr code
```

---

## 🛠 Method 2: Manual Installation (Step-by-Step)

### 1. Update Linux Packages

```bash
sudo apt update && sudo apt upgrade -y
sudo apt install -y curl git build-essential
```

### 2. Install Node.js (via NVM)

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
source ~/.bashrc
nvm install --lts
```

### 3. Install Claude Code & CCR Router

```bash
npm install -g @anthropic-ai/claude-code @musistudio/claude-code-router
```

---

## ⚙️ Configuration Setup

### Step 1: Check Your Shell (Important)

Run:

```bash
echo $SHELL
```

* If output contains `/bash` → use `~/.bashrc`
* If output contains `/zsh` → use `~/.zshrc`

---

### Step 2: Create Config File (Google Gemini)

```bash
mkdir -p ~/.claude-code-router ~/.claude
```

Run the following command to create your configuration:

```json
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
        "gemini-2.0-flash",
        "gemini-1.5-pro"
      ],
      "transformer": { "use": ["gemini"] }
    }
  ],
  "Router": {
    "default": "gemini,gemini-3-flash-preview",
    "background": "gemini,gemini-3-flash-preview",
    "think": "gemini,gemini-3-pro-preview",
    "longContext": "gemini,gemini-3-pro-preview",
    "longContextThreshold": 60000
  }
}
EOF
```

---

### Step 3: Set API Key

Use the shell configuration file you identified in Step 1. Replace `YOUR_KEY_HERE` with your actual Google AI Studio API key.

**If using bash:**

```bash
echo 'export GOOGLE_API_KEY="YOUR_KEY_HERE"' >> ~/.bashrc
source ~/.bashrc
```

**If using zsh:**

```bash
echo 'export GOOGLE_API_KEY="YOUR_KEY_HERE"' >> ~/.zshrc
source ~/.zshrc
```

---

## 🚀 How to Run

```bash
ccr code
```

---

## 💡 Essential Commands

* `ccr start` / `ccr stop` / `ccr status` — Manage the background router service.
* `ccr model` — Quick interactive configuration of your model providers.
* `ccr ui` → Dashboard at `http://localhost:3456`
---


## ❓ Troubleshooting

### 1. Service Startup Timeout  

If `ccr code` shows a "Timeout" error, the background service might just need a manual kickstart. Run these separately:  

```bash
ccr start
ccr code
```

### 2. Status shows "Not Running"  

This usually means a "ghost" process is already using the port. Run this to clear it:

```bash
# Find any process on port 3456
sudo lsof -i :3456
# Use the PID found to kill it: sudo kill -9 <PID>
```

### 3. Verification Commands  

Use these commands to verify your setup:

- `ccr status` — Check if the background service is running.
- `/status` — (Inside Claude) Verify the Base URL is 127.0.0.1:3456.

---  


**Maintained by Muhammad Hammad**
*Agentic AI Architect | Chatbots & Automation Specialist*

