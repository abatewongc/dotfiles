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
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion