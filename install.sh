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

echo "Setting up zsh"
ln -sf ~/dotfiles/zsh/.zshrc ~/.zshrc
echo "done"

echo "Setting up neovim"
git clone https://github.com/PhilippHe98/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
echo "done"

chsh -s $(which zsh)
