#!/bin/sh
set -e

# set installing work dir
workdir=$(mktemp -d)
echo "install workdir: $workdir"

# make user bin dir
mkdir -p $HOME/bin

# Prompto setting
if command -v brew >/dev/null 2>&1; then
    brew install starship
else
    wget https://starship.rs/install.sh -O $workdir/starship_install.sh
    sh $workdir/starship_install.sh -b $HOME/bin -y
fi
mkdir -p $HOME/.config && echo "command_timeout = 2000" > $HOME/.config/starship.toml
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
wget https://raw.githubusercontent.com/MasaYan24/zshrc/main/.zshrc -P $HOME/

# Developing tool
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O $workdir/miniconda.sh \
    && sh $workdir/miniconda.sh -b -p $HOME/.miniconda
$HOME/.miniconda/bin/conda --add channels conda-forge
$HOME/.miniconda/bin/conda --remove channels defaults
$HOME/.miniconda/bin/conda --show channels
grep -qxF 'export PATH=$HOME/.miniconda/bin:$PATH' $HOME/.zshrc || echo 'export PATH=$HOME/.miniconda/bin:$PATH' >> $HOME/.zshrc

# git setting
git config --global core.editor nano
git config --global mergetool.prompt false
git config --global credential.helper "cache --timeout 604800"
git config --global core.pager "LESSCHARSET=utf-8 less"
