# Hi, I'm Dinesh Pathro! 👋


# Oh My Zsh Installation and Configuration Script

*This script automates the installation of Oh My Zsh and several useful plugins to enhance your Zsh experience.*

## Features
* Installs Oh My Zsh
* Sets Agnoster as the default theme
* Installs and configures the following plugins:
    * zsh-autosuggestions
    * zsh-syntax-highlighting
    * zsh-completions
    * zsh-history-substring-search
    * zsh-navigation-tools
    * zsh-autocomplete
    * zsh-you-should-use
    * zsh-dircolors-solarized
    * zsh-interactive-cd
* Configures ~/.zshrc automatically
* Sets Zsh as the default shell

## Installation
### Prerequisites

#### Ensure you have Git installed on your system before running the script. If Git is not installed, install it using:

#### Debian/Ubuntu:

```
sudo apt update && sudo apt install git -y
```
#### Arch Linux:
```
sudo pacman -Syu git --noconfirm
```
#### macOS (Homebrew):
```
brew install git
```
## Run the Script

### Clone this repository and execute the script:
```
git clone https://github.com/dineshpathro90/Ohmyzsh.git
cd ohmyzsh
chmod +x ohmyzsh.sh plugins.sh
./ohmyzsh.sh
```
### And
```
./plugins.sh
```
