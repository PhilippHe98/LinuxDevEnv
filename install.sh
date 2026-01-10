#!/usr/bin/env bash
set -e

if [ "$EUID" -ne 0 ]; then
    SUDO='sudo'
else
    SUDO=''
fi

echo "Installing everything"
$SUDO apt update
$SUDO apt install -y software-properties-common
$SUDO add-apt-repository ppa:neovim-ppa/unstable -y
$SUDO apt install -y tmux git curl zsh make gcc ripgrep unzip xclip neovim zoxide fzf

LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": *"v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
install lazygit -D -t /usr/local/bin/
rm lazygit
rm lazygit.tar.gz
echo "done"

echo "Setting up Tmux..."
mkdir -p ~/.tmux
ln -sf ~/dotfiles/tmux/.tmux.conf ~/.tmux.conf
echo "done."

echo "Setting up neovim"
git clone https://github.com/PhilippHe98/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
echo "done"

echo "Installing and setting up oh-my-zsh"
RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
ZSH_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}

# Plugins installieren
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
git clone https://github.com/jeffreytse/zsh-vi-mode $ZSH_CUSTOM/plugins/zsh-vi-mode
# Theme installieren
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k

echo "Linking .zshrc"
ln -sf ~/dotfiles/zsh/.zshrc ~/.zshrc
echo "done"

chsh -s $(which zsh)
