# RailSmith 🛤️⚒️

This repository provides a modern and complete **DevContainer** configuration template, designed for developing **Ruby on Rails** applications using AI and secure credential management, with full support for **GitHub Codespaces** and local **VS Code**.

## ✨ Features Included

*   💎 **Ruby 3.3** and a pre-configured Rails environment.
*   🐘 **PostgreSQL 15** (Relational Database).
*   🟥 **Redis 7** (Cache, Hotwire/ActionCable, and Background Jobs).
*   🤖 **Claude Code CLI** (Anthropic's AI assistant integrated into the terminal).
*   🔐 **Bitwarden CLI & Extension** (Secure password and secrets management).
*   📦 **Node.js (LTS)** and **GitHub CLI** configured via Features.
*   🛠️ **Extra Tools:** `libvips` (for image processing in ActiveStorage), `postgresql-client`, and `redis-tools`.
*   💻 **IDE Support:** Excellent support for VS Code and RubyMine (JetBrains).

---

## ☁️ How to use in GitHub Codespaces (Recommended)

The fastest way to start coding is by using this repository directly in the cloud through GitHub.

1. **Fork or Use as a Template** this repository.
2. Go to your new repository on GitHub.
3. Click the green **"<> Code"** button.
4. Switch to the **"Codespaces"** tab.
5. Click **"Create codespace on main"**.

GitHub will automatically initialize VS Code in your browser (or your local machine, if you prefer), download the images, start Postgres and Redis, and install Rails and AI dependencies in the background.

---

## 💻 How to use Locally (VS Code)

If you prefer to run it on your own computer using Docker:

### Prerequisites
*   [Docker Desktop](https://www.docker.com/products/docker-desktop) installed and running.
*   [Visual Studio Code](https://code.visualstudio.com/).
*   VS Code Extension: [Dev Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers).

### Steps
1. Clone this repository to your computer:
   ```bash
   git clone <YOUR_REPOSITORY_URL>
   cd <FOLDER_NAME>
   ```
2. Open the folder in VS Code:
   ```bash
   code .
   ```
3. VS Code will detect the `.devcontainer` folder and show a pop-up in the bottom right corner saying: *"Folder contains a Dev Container configuration file"*.
4. Click **"Reopen in Container"** (or press `F1` and type `Dev Containers: Reopen in Container`).
5. Wait for Docker to build the environment. The first time, this may take a few minutes.

---

## 🛠️ First Steps After Initialization

When the terminal opens inside your Codespace or local container, you will already be logged in as the `vscode` user and ready to create your application.

### 1. Create and configure the Rails app
If the folder is still empty (no app code), create a new Rails project already configured for the Postgres database:

```bash
rails new . --database=postgresql --force
```

Next, setup the Rails database:
```bash
# As Postgres is already running via Docker Compose, simply run:
rails db:create db:migrate
```

### 2. Using Claude Code (AI Assistant)
Anthropic's assistant is already installed globally. To start a pair-programming session with AI, just run:
```bash
claude
# This will launch the interactive CLI. You'll need to authenticate with your Anthropic account the first time.
```

### 3. Using Bitwarden
To avoid typing passwords repeatedly or keeping outdated `.env` files, log into your vault:
```bash
bw login
export BW_SESSION=$(bw unlock --raw)

# Example: Pulling a production API Key securely
# export STRIPE_KEY=$(bw get password "Stripe API Key")
```
*Tip: You can also use the Bitwarden extension directly in the VS Code Activity Bar (sidebar).*

---

## 🧩 Modifying the Environment

*   If you need to change the Ruby version, modify the `VARIANT` parameter in the `.devcontainer/devcontainer.json` or `.devcontainer/Dockerfile` file.
*   To add more services (e.g., Elasticsearch, Meilisearch), edit the `.devcontainer/docker-compose.yml` file.
*   Whenever you make changes to files inside the `.devcontainer` folder, open the VS Code Command Palette (`F1`) and run **"Dev Containers: Rebuild Container"** to apply the changes.
