#!/bin/bash

# Development tools setup - Node.js, AI CLI tools, etc.

# Install NVM
export NVM_DIR="$HOME/.nvm"

if [ -d "$NVM_DIR" ]; then
    echo "NVM is already installed."
else
    echo "Installing NVM..."

    # Fetch the latest version tag from GitHub API
    LATEST_NVM_VERSION=$(curl -s https://api.github.com/repos/nvm-sh/nvm/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')

    # Download and run the install script
    curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/${LATEST_NVM_VERSION}/install.sh" | bash

    echo "NVM installed ($LATEST_NVM_VERSION)"

    # Load NVM into the current shell session
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

    # Install LTS Node version
    nvm install --lts
    nvm use --lts
fi

# Install Gemini CLI
PACKAGE_NAME="@google/gemini-cli"

if npm list -g "$PACKAGE_NAME" >/dev/null 2>&1; then
    echo "$PACKAGE_NAME is already installed."
else
    echo "Installing $PACKAGE_NAME..."
    npm install -g "$PACKAGE_NAME"
    echo "$PACKAGE_NAME installed successfully."
fi

# Install Claude Code
if command -v claude >/dev/null 2>&1; then
    echo "Claude Code is already installed."
else
    echo "Installing Claude Code..."
    curl -fsSL https://claude.ai/install.sh | bash
    echo "Claude Code installed."
fi

echo "Development tools installed!"
