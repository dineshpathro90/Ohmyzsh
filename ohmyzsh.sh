#!/bin/bash

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo "Git is not installed. Please install Git and rerun this script."
    exit 1
fi

# Install Oh My Zsh
echo "Installing Oh My Zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Check if Oh My Zsh installation was successful
if [ $? -ne 0 ]; then
    echo "Oh My Zsh installation failed."
    exit 1
fi

# Clone zsh-autosuggestions plugin
echo "Cloning zsh-autosuggestions plugin..."
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

# Clone zsh-syntax-highlighting plugin
echo "Cloning zsh-syntax-highlighting plugin..."
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

# Clone zsh-completions plugin
echo "Cloning zsh-completions plugin..."
git clone https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/custom/plugins/zsh-completions

# Clone zsh-history-substring-search plugin
echo "Cloning zsh-history-substring-search plugin..."
git clone https://github.com/zsh-users/zsh-history-substring-search ~/.oh-my-zsh/custom/plugins/zsh-history-substring-search

# Clone zsh-navigation-tools plugin
echo "Cloning zsh-navigation-tools plugin..."
git clone https://github.com/psprint/zsh-navigation-tools.git ~/.oh-my-zsh/custom/plugins/zsh-navigation-tools

# Clone zsh-autocomplete plugin
echo "Cloning zsh-autocomplete plugin..."
git clone https://github.com/marlonrichert/zsh-autocomplete ~/.oh-my-zsh/custom/plugins/zsh-autocomplete

# Configure Oh My Zsh
echo "Configuring Oh My Zsh..."
sed -i -e 's/ZSH_THEME="robbyrussell"/ZSH_THEME="agnoster"/g' ~/.zshrc
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc

# Add plugins to the list of plugins
sed -i -e 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-completions zsh-history-substring-search zsh-navigation-tools zsh-autocomplete)/g' ~/.zshrc

# Set Zsh as default shell
echo "Setting Zsh as default shell..."
chsh -s $(which zsh)

echo "Oh My Zsh installation and configuration completed successfully. Please restart your terminal."
