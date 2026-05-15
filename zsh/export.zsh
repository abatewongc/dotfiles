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
# pyenv PATH is set in eval.zsh lazy-loader

export PATH="$PATH:~/.local/bin"
# SDKMAN_DIR is set in eval.zsh lazy-loader
export PATH=$PATH:/home/aleosiss/workspace/pacmc/pacmc-0.4.2/bin
export MINECRAFT_DIR=/mnt/c/Users/Christian/AppData/Roaming/PrismLauncher/instances/fabric-1.15.1-build.6_yarn-0.7.2-build.175/.minecraft
export MINECRAFT_MOD_DIR=$MINECRAFT_DIR/mods

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH" # kubernetes krew
export PATH=/opt/homebrew/bin:/opt/homebrew/sbin:$PATH

export OOF_OUTPUT_DIR="~/workspace/oofgen/screenshots"
export OOF_TEXTURE="~/Downloads/red.png"

path+=("~/$DOT/scripts")                                                                                                      

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
