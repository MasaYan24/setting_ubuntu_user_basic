# Ubuntu settings for basic local user

## Execution
Download repository:
```sh
git clone https://github.com/MasaYan24/setting_ubuntu_user_basic.git
cd setting_ubuntu_user_basic
sh install.sh
```

### Note
If your computer is under a proxy, execute the following before executing the setup script.
```sh
# modify the IP and port number
export http_proxy="http://your/proxy/IP:PortNumber"
export https_proxy="http://your/proxy/IP:PortNumber"
export ftp_proxy="http://your/proxy/IP:PortNumber"
```
The above commands have to be executed every time you restart the shell.

Or execute the following steps one by one.

## Manual installation

### use template .zshrc
```sh
wget https://raw.githubusercontent.com/MasaYan24/zshrc/main/.zshrc -P $HOME/
```

### setup shell prompt
```sh
if command -v brew >/dev/null 2>&1; then
    brew install starship
else
    wget https://starship.rs/install.sh -O $workdir/starship_install.sh
    sh $workdir/starship_install.sh -b $HOME/bin -y
fi
mkdir -p $HOME/.config && echo "command_timeout = 2000" > $HOME/.config/starship.toml
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
```

### environment tool
```sh
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    -O /tmp/miniconda.sh && sh /tmp/miniconda.sh -b -p $HOME/miniconda
$HOME/.miniconda/bin/conda --add channels conda-forge
$HOME/.miniconda/bin/conda --remove channels defaults
$HOME/.miniconda/bin/conda --show channels
```
Add path to it.
```sh
echo 'export PATH=$HOME/.miniconda/bin:$PATH' >> $HOME/.zshrc
```

### git setting
```sh
git config --global core.editor vi
git config --global merge.tool vimdiff
git config --global merge.conflictstyle diff3
git config --global mergetool.prompt false
git config --global credential.helper "cache --timeout 604800"
git config --global core.pager "LESSCHARSET=utf-8 less"
```
