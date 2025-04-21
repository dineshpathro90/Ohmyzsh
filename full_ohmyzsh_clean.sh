#!/bin/bash

set -e

# Determine the user and their home directory
if [ "$EUID" -eq 0 ]; then
    USERNAME="root"
    USER_HOME="/root"  # Root user home directory
else
    USERNAME="$USER"
    USER_HOME=$(eval echo "~$USERNAME")
fi

ZSH_CUSTOM="${USER_HOME}/.oh-my-zsh/custom"

# Function to clean up old configuration files
clean_old_files() {
    echo "[!] Cleaning up old Zsh config files..."
    if [ "$EUID" -eq 0 ]; then
        TARGET_USER="root"
        TARGET_HOME="/root"
    else
        TARGET_USER="$USERNAME"
        TARGET_HOME="$USER_HOME"
    fi

    read -rp "Do you want to delete existing ~/.oh-my-zsh and .zshrc for $TARGET_USER? [y/N]: " confirm
    confirm="${confirm,,}"  # Convert to lowercase

    if [[ "$confirm" == "y" || "$confirm" == "yes" ]]; then
        sudo -u "$TARGET_USER" rm -rf "${TARGET_HOME}/.oh-my-zsh"
        sudo -u "$TARGET_USER" rm -f "${TARGET_HOME}/.zshrc"
        sudo -u "$TARGET_USER" rm -rf "${TARGET_HOME}/.zsh_history"
        echo "[*] Old config removed for $TARGET_USER."
    else
        echo "[*] Skipping removal of old files for $TARGET_USER."
    fi
}

# Function to install Zsh
install_zsh() {
    if ! command -v zsh >/dev/null 2>&1; then
        echo "[*] Installing Zsh..."
        if command -v apt >/dev/null 2>&1; then
            sudo apt update && sudo apt install -y zsh
        elif command -v pacman >/dev/null 2>&1; then
            sudo pacman -Sy --noconfirm zsh
        else
            echo "[!] Unsupported package manager."
            exit 1
        fi
    else
        echo "[*] Zsh already installed."
    fi
}

# Function to install Oh My Zsh
install_oh_my_zsh() {
    if [ ! -d "${USER_HOME}/.oh-my-zsh" ]; then
        echo "[*] Installing Oh My Zsh..."
        sudo -u "$USERNAME" sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    else
        echo "[*] Oh My Zsh is already installed."
    fi
}

# Function to install plugins
install_plugins() {
    echo "[*] Installing plugins..."

    declare -A plugins=(
        [zsh-autosuggestions]="https://github.com/zsh-users/zsh-autosuggestions"
        [zsh-syntax-highlighting]="https://github.com/zsh-users/zsh-syntax-highlighting"
        [zsh-completions]="https://github.com/zsh-users/zsh-completions"
        [zsh-history-substring-search]="https://github.com/zsh-users/zsh-history-substring-search"
        [zsh-z]="https://github.com/agkozak/zsh-z"
        [zsh-vi-mode]="https://github.com/jeffreytse/zsh-vi-mode"
        [zsh-nvm]="https://github.com/lukechilds/zsh-nvm"
        [fzf-tab]="https://github.com/Aloxaf/fzf-tab"
        [you-should-use]="https://github.com/MichaelAquilina/zsh-you-should-use"
        [zsh-autocomplete]="https://github.com/marlonrichert/zsh-autocomplete"
    )

    mkdir -p "$ZSH_CUSTOM/plugins"

    for plugin in "${!plugins[@]}"; do
        plugin_dir="$ZSH_CUSTOM/plugins/$plugin"
        git clone --depth=1 "${plugins[$plugin]}" "$plugin_dir" || git -C "$plugin_dir" pull --quiet
    done
}

# Function to install Powerlevel10k theme
install_powerlevel10k() {
    echo "[*] Installing Powerlevel10k..."
    local theme_dir="${ZSH_CUSTOM}/themes/powerlevel10k"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$theme_dir" || git -C "$theme_dir" pull --quiet
}

# Function to install fzf
install_fzf() {
    if ! command -v fzf >/dev/null 2>&1; then
        echo "[*] Installing fzf..."
        sudo -u "$USERNAME" git clone --depth 1 https://github.com/junegunn/fzf.git "${USER_HOME}/.fzf"
        sudo -u "$USERNAME" bash -c "${USER_HOME}/.fzf/install --all"
    fi
}

# Function to configure .zshrc
configure_zshrc() {
    echo "[*] Writing new .zshrc config..."

    ZSHRC_PATH="${USER_HOME}/.zshrc"

    cat <<EOF > "$ZSHRC_PATH"
export ZSH="\$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-completions
    zsh-history-substring-search
    zsh-z
    zsh-vi-mode
    zsh-nvm
    fzf-tab
    you-should-use
    zsh-autocomplete
)

source \$ZSH/oh-my-zsh.sh

export NVM_DIR="\$HOME/.nvm"
[ -s "\$NVM_DIR/nvm.sh" ] && \. "\$NVM_DIR/nvm.sh"

source \$ZSH_CUSTOM/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh
EOF

    chown "$USERNAME:$USERNAME" "$ZSHRC_PATH"
}

# Function to set default shell
set_default_shell() {
    if [ "$SHELL" != "$(which zsh)" ]; then
        echo "[*] Setting Zsh as default shell for $USERNAME"
        chsh -s "$(which zsh)" "$USERNAME"
    fi
}

# Main Execution
clean_old_files
install_zsh
install_oh_my_zsh
install_plugins
install_powerlevel10k
install_fzf
configure_zshrc
set_default_shell

echo "[✔] Clean Zsh environment installed and configured for $USERNAME."

