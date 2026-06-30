#!/bin/zsh
#export NODE_ENV="dev"

export HOSTNAME=$HOST
export SHELL="$(which zsh)"
export EDITOR="vi"
export AWS_PAGER=""
export AWS_DEFAULT_REGION="us-west-2"

export FUNCNEST=5000

# required to run py-installer
# pyenv will build python versions with this flag
export PYTHON_CONFIGURE_OPTS="--enable-shared"
# pyenv PATH is set in eval.zsh lazy-loader

# SDKMAN_DIR is set in eval.zsh lazy-loader

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH" # kubernetes krew

export OOF_OUTPUT_DIR="~/workspace/oofgen/screenshots"
export OOF_TEXTURE="~/Downloads/red.png"

path+=("$DOT/scripts")

# Lazy-load NVM: only initializes when nvm/node/npm/npx is first called
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
if [[ -s "$NVM_DIR/nvm.sh" ]]; then
  function nvm() {
    unfunction nvm node npm npx
    \. "$NVM_DIR/nvm.sh"
    [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
    nvm "$@"
  }
  function node() { unfunction nvm node npm npx; \. "$NVM_DIR/nvm.sh"; node "$@"; }
  function npm() { unfunction nvm node npm npx; \. "$NVM_DIR/nvm.sh"; npm "$@"; }
  function npx() { unfunction nvm node npm npx; \. "$NVM_DIR/nvm.sh"; npx "$@"; }
fi
