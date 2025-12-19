# 🚀 Claude Code Router: Master Setup Guide (WSL + Gemini + OpenRouter)

This repository is the official companion for our YouTube tutorial on setting up **Claude Code** inside Windows using **WSL2**. We use the **Claude Code Router (CCR)** to unlock models like **Google Gemini** and **DeepSeek** directly within the Anthropic CLI.

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

Inside your **WSL / Ubuntu** terminal, run:

```bash
curl -sSL https://raw.githubusercontent.com/devhammad0/claude-code-router-setup/main/scripts/install.sh | bash
```

> After the script finishes:

```bash
source ~/.bashrc
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

You will use this file in the next steps.

---

### Step 2: Create Config File

```bash
mkdir -p ~/.claude-code-router
nano ~/.claude-code-router/config.json
```

Paste **one** of the following templates.

---

### Option A: Google Gemini

```json
{
  "LOG": true,
  "LOG_LEVEL": "info",
  "HOST": "127.0.0.1",
  "PORT": 3456,
  "API_TIMEOUT_MS": 600000,
  "Providers": [
    {
      "name": "gemini",
      "api_base_url": "https://generativelanguage.googleapis.com/v1beta/models/",
      "api_key": "$GOOGLE_API_KEY",
      "models": [
        "gemini-3-flash-preview",
        "gemini-3-pro-preview",
        "gemini-flash-lite-latest",
        "gemini-flash-latest"
      ],
      "transformer": { "use": ["gemini"] }
    }
  ],
  "Router": {
    "default": "gemini,gemini-3-flash-preview",
    "background": "gemini,gemini-flash-lite-latest",
    "think": "gemini,gemini-flash-lite-latest",
    "longContext": "gemini,gemini-flash-lite-latest",
    "longContextThreshold": 60000
  }
}
```

---

### Option B: OpenRouter

```json
{
  "LOG": true,
  "PORT": 3456,
  "Providers": [
    {
      "name": "openrouter",
      "api_base_url": "https://openrouter.ai/api/v1/chat/completions",
      "api_key": "$OPENROUTER_API_KEY",
      "models": [
        "google/gemini-3-flash-preview",
        "openai/gpt-oss-120b",
        "deepseek/deepseek-v3.2"
      ],
      "transformer": { "use": ["openrouter"] }
    }
  ],
  "Router": {
    "default": "openrouter,google/gemini-3-flash-preview",
    "think": "openrouter,deepseek/deepseek-v3.2"
  }
}
```

---

### Step 3: Set API Keys

Use the file you identified earlier.

**If using bash:**

```bash
echo 'export GOOGLE_API_KEY="YOUR_KEY_HERE"' >> ~/.bashrc
echo 'export OPENROUTER_API_KEY="YOUR_KEY_HERE"' >> ~/.bashrc
source ~/.bashrc
```

**If using zsh:**

```bash
echo 'export GOOGLE_API_KEY="YOUR_KEY_HERE"' >> ~/.zshrc
echo 'export OPENROUTER_API_KEY="YOUR_KEY_HERE"' >> ~/.zshrc
source ~/.zshrc
```

---

## 🚀 How to Run

```bash
ccr code
```

---

## 💡 Essential Commands

* `/status` → Check connection
* `/model provider,model_name` → Switch models
* `ccr ui` → Dashboard at `http://localhost:3456`

---

**Maintained by Muhammad Hammad**
*Agentic AI Architect | Chatbots & Automation Specialist*

