#!/bin/zsh
export NODE_ENV="dev"

export HOSTNAME="$(hostname)"
export SHELL="$(which zsh)" 
export EDITOR="vi"
export AWS_PAGER=""
export AWS_DEFAULT_REGION="us-east-1"


export FUNCNEST=5000

# required to run py-installer
# pyenv will build python versions with this flag
export PYTHON_CONFIGURE_OPTS="--enable-shared"
# fix 2021.11.17 pyenv nonfunctional issue
export PATH="$HOME/.pyenv/shims:$PATH"

export PATH="$PATH:~/.local/bin"
export SDKMAN_DIR="$HOME/.sdkman"