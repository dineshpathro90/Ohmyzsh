#!/bin/bash

# Clone zsh-autosuggestions plugin
echo "Cloning zsh-autosuggestions plugin..."
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

# Clone zsh-syntax-highlighting plugin
echo "Cloning zsh-syntax-highlighting plugin..."
git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

# Clone zsh-completions plugin
echo "Cloning zsh-completions plugin..."
git clone https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/custom/plugins/zsh-completions

# Clone zsh-history-substring-search plugin
echo "Cloning zsh-history-substring-search plugin..."
git clone https://github.com/zsh-users/zsh-history-substring-search ~/.oh-my-zsh/custom/plugins/zsh-history-substring-search

# Clone zsh-autocomplete plugin
echo "Cloning zsh-autocomplete plugin..."
git clone https://github.com/marlonrichert/zsh-autocomplete ~/.oh-my-zsh/custom/plugins/zsh-autocomplete

# Clone zsh-you-should-use plugin
echo "Cloning zsh-you-should-use plugin..."
git clone https://github.com/MichaelAquilina/zsh-you-should-use ~/.oh-my-zsh/custom/plugins/zsh-you-should-use

# Clone zsh-dircolors-solarized plugin
echo "Cloning zsh-dircolors-solarized plugin..."
git clone https://github.com/joel-porquet/zsh-dircolors-solarized ~/.oh-my-zsh/custom/plugins/zsh-dircolors-solarized

# Clone zsh-interactive-cd plugin
echo "Cloning zsh-interactive-cd plugin..."
git clone https://github.com/changyuheng/zsh-interactive-cd ~/.oh-my-zsh/custom/plugins/zsh-interactive-cd

# Configure Oh My Zsh
echo "Configuring Oh My Zsh..."
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="agnoster"/g' ~/.zshrc
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc

# Add plugins to the list of plugins
sed -i '/^plugins=/c\plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-completions zsh-history-substring-search zsh-autocomplete zsh-you-should-use zsh-dircolors-solarized zsh-interactive-cd)' ~/.zshrc

echo "Oh My Zsh plugins configuration completed successfully. Please restart your terminal."
