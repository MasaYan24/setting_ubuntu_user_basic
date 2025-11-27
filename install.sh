#!/bin/sh
set -e

# set installing work dir
workdir=$(mktemp -d)
echo "install workdir: $workdir"

# make user bin dir
mkdir -p $HOME/bin

# FORCE to use original .zshrc
wget https://raw.githubusercontent.com/MasaYan24/zshrc/main/.zshrc -P $HOME/

# Prompto setting
if command -v brew >/dev/null 2>&1; then
    brew install starship
else
    wget https://starship.rs/install.sh -O $workdir/starship_install.sh
    sh $workdir/starship_install.sh -b $HOME/bin -y
fi
mkdir -p $HOME/.config && echo "command_timeout = 2000" > $HOME/.config/starship.toml
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions

# miniforge install
installer=$workdir/miniforge_install.sh
install_dir=$HOME/.miniconda
wget "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh" -O $installer \
    && bash $installer -b -p $install_dir
$install_dir/bin/conda config --set auto_activate False
$install_dir/bin/conda config --show channels
# grep -qxF 'export PATH=$install_dir/bin:$PATH' $HOME/.zshrc || echo 'export PATH=$install_dir/bin:$PATH' >> $HOME/.zshrc
$install_dir/bin/conda init zsh

# git setting
git config --global core.editor nano
git config --global mergetool.prompt false
git config --global credential.helper "cache --timeout 604800"
git config --global core.pager "LESSCHARSET=utf-8 less"
