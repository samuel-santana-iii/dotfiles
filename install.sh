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
        sudo apt update && sudo apt install -y git curl unzip fontconfig bat zsh ripgrep fd-find
        ;;
    pacman)
        sudo pacman -Syu --noconfirm git curl unzip fontconfig bat zsh ripgrep fd
        ;;
    dnf)
        sudo dnf install -y git curl unzip fontconfig bat zsh ripgrep fd-find
        ;;
    *)
        echo "Unsupported distribution: $DISTRO"
        echo "Supported: Debian/Ubuntu-based, Arch-based, Fedora/RHEL-based"
        exit 1
        ;;
esac

# Install Neovim
echo "Installing Neovim..."
if command -v nvim &> /dev/null; then
    NVIM_VERSION=$(nvim --version | head -n1 | awk '{print $2}' | sed 's/^v//')
    echo "Neovim $NVIM_VERSION is already installed."
else
    case $PKG_MGR in
        apt)
            # Use AppImage for latest Neovim (LazyVim requires v0.12.0+)
            echo "Installing latest Neovim via AppImage..."
            curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
            chmod u+x nvim.appimage
            sudo mv nvim.appimage /usr/local/bin/nvim
            ;;
        pacman)
            # Arch usually has latest stable
            sudo pacman -S --noconfirm neovim
            ;;
        dnf)
            # Fedora may lag behind, use AppImage for guaranteed latest
            echo "Installing latest Neovim via AppImage..."
            curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
            chmod u+x nvim.appimage
            sudo mv nvim.appimage /usr/local/bin/nvim
            ;;
    esac
fi

# Link Configs
echo "Linking dotfiles..."
rm -rf ~/.zshrc ~/.vimrc ~/.config/starship.toml ~/.config/nvim

ln -sf ~/dotfiles/zshrc ~/.zshrc
ln -sf ~/dotfiles/vimrc ~/.vimrc
mkdir -p ~/.config
ln -sf ~/dotfiles/config/starship.toml ~/.config/starship.toml
ln -sf ~/dotfiles/config/nvim ~/.config/nvim

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

# Neovim first launch note
if command -v nvim &> /dev/null; then
    echo ""
    echo "Note: Neovim will download plugins on first launch (1-2 minutes)."
    echo "Run ':LazyHealth' after first launch to verify setup."
fi

echo "Done! Restart your terminal."
