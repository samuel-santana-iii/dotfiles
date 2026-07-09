#!/bin/bash

# Core shell environment setup - portable across machines

# Update & Essentials
echo "Updating system..."
sudo apt update && sudo apt install -y git curl unzip fontconfig bat zsh

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

# Install Oh My Zsh (Unattended)
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

    # Install Plugins
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi

# Change Shell
echo "Changing default shell to Zsh..."
sudo chsh -s $(which zsh) $USER

echo "Done! Restart your terminal."
