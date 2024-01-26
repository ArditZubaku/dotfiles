#!/bin/bash

# Update system and install required packages
sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm zsh git curl

# Set Zsh as the default shell
chsh -s $(which zsh)

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone --depth 1 https://github.com/marlonrichert/zsh-autocomplete.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autocomplete

# Install Powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k

# Configure .zshrc for plugins and theme
echo 'source ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
echo 'plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-autocomplete)' >>~/.zshrc

# Apply changes
source ~/.zshrc
