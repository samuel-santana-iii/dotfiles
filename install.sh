#!/bin/bash

# Core shell environment setup - portable across machines

# Detect distro
if [ -f /etc/os-release ]; then
    . /etc/os-release
    DISTRO=$ID
else
    echo "Cannot detect distribution. /etc/os-release not found."
    exit 1
fi

# Determine package manager based on ID or ID_LIKE
PKG_MGR=""
if [[ "$DISTRO" =~ ^(ubuntu|debian)$ ]] || [[ "$ID_LIKE" =~ (ubuntu|debian) ]]; then
    PKG_MGR="apt"
elif [[ "$DISTRO" =~ ^(arch|manjaro|cachyos)$ ]] || [[ "$ID_LIKE" =~ arch ]]; then
    PKG_MGR="pacman"
elif [[ "$DISTRO" =~ ^(fedora|nobara)$ ]] || [[ "$ID_LIKE" =~ (fedora|rhel) ]]; then
    PKG_MGR="dnf"
fi

# Update & Essentials
echo "Updating system and installing packages..."
case $PKG_MGR in
    apt)
        sudo apt update && sudo apt install -y git curl unzip fontconfig bat zsh
        ;;
    pacman)
        sudo pacman -Syu --noconfirm git curl unzip fontconfig bat zsh
        ;;
    dnf)
        sudo dnf install -y git curl unzip fontconfig bat zsh
        ;;
    *)
        echo "Unsupported distribution: $DISTRO"
        echo "Supported: Debian/Ubuntu-based, Arch-based, Fedora/RHEL-based"
        exit 1
        ;;
esac

# Link Configs
echo "Linking dotfiles..."
rm -rf ~/.zshrc ~/.vimrc ~/.config/starship.toml

ln -sf ~/dotfiles/zshrc ~/.zshrc
ln -sf ~/dotfiles/vimrc ~/.vimrc
mkdir -p ~/.config
ln -sf ~/dotfiles/config/starship.toml ~/.config/starship.toml

# Configure Git
echo "Configuring git to use vim..."
git config --global core.editor vim

# Install zsh plugins
echo "Installing zsh plugins..."
mkdir -p ~/.zsh
if [ ! -d ~/.zsh/zsh-autosuggestions ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
fi
if [ ! -d ~/.zsh/zsh-syntax-highlighting ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.zsh/zsh-syntax-highlighting
fi

# Install Starship
if ! command -v starship &> /dev/null; then
    echo "Installing Starship..."
    curl -sS https://starship.rs/install.sh | sh -s -- -y
fi

# Install Zoxide
if ! command -v zoxide &> /dev/null; then
    echo "Installing Zoxide..."
    curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
fi

# Change Shell
echo "Changing default shell to Zsh..."
sudo chsh -s $(which zsh) $USER

echo "Done! Restart your terminal."
