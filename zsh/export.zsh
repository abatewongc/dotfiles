#!/bin/zsh
export NODE_ENV="dev"

export HOSTNAME="$(hostname)"
export SHELL="$(which zsh)" 
export EDITOR="vi"
export AWS_PAGER=""
export AWS_DEFAULT_REGION="us-west-2"

export FUNCNEST=5000

# required to run py-installer
# pyenv will build python versions with this flag
export PYTHON_CONFIGURE_OPTS="--enable-shared"
# fix 2021.11.17 pyenv nonfunctional issue
export PATH="$HOME/.pyenv/shims:$PATH"

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"    # if `pyenv` is not already on PATH

export PATH="$PATH:~/.local/bin"
export SDKMAN_DIR="$HOME/.sdkman"

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
export PATH=$PATH:/home/aleosiss/workspace/pacmc/pacmc-0.4.2/bin
export MINECRAFT_DIR=/mnt/c/Users/Christian/AppData/Roaming/PrismLauncher/instances/fabric-1.15.1-build.6_yarn-0.7.2-build.175/.minecraft
export MINECRAFT_MOD_DIR=$MINECRAFT_DIR/mods

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH" # kubernetes krew
export PATH=/opt/homebrew/bin:/opt/homebrew/sbin:$PATH

export OOF_OUTPUT_DIR="~/workspace/oofgen/screenshots"
export OOF_TEXTURE="~/Downloads/red.png"
