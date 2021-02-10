#!/bin/zsh

skip_global_compinit=1

if [[ -v WSL_DISTRO_NAME ]] then
  WSL_HOME=/home/aleosiss
  WINDOWS_HOME=$HOME
  HOME=$WSL_HOME
fi


# Powerlevel10k Instant Prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


if [[ -v WSL_DISTRO_NAME ]] then
  export HOME=$WINDOWS_HOME
  HOME=$WINDOWS_HOME
fi


export DOT=$HOME/dotfiles
export DOT_ZSH=$DOT/zsh

source $DOT_ZSH/z4h.zsh
source $DOT_ZSH/zinit.zsh
source $DOT_ZSH/zsh.zsh
source $DOT_ZSH/function.zsh
source $DOT_ZSH/export.zsh
source $DOT_ZSH/alias.zsh
source $DOT_ZSH/eval.zsh
source $DOT_ZSH/keybindings.zsh

if [[ -v WSL_DISTRO_NAME ]] then
  source $DOT_ZSH/os/wsl/wsl.zsh
  source $DOT_ZSH/os/wsl/z4h.zsh
fi

CURRENT_OS=$(uname)
if [[ "$CURRENT_OS" == "Darwin" ]] then
  source $DOT_ZSH/os/osx/osx.zsh
fi

WORK_HOSTNAME="cwong-mbp"
if [[ "$HOSTNAME" == "$WORK_HOSTNAME" ]] then
  source $DOT_ZSH/work.zsh
fi
unset WORK_HOSTNAME

# To customize prompt, run `p10k configure` or edit $POWERLEVEL10K_SOURCE
export POWERLEVEL10K_SOURCE=$DOT_ZSH/.p10k.zsh
[[ ! -f $POWERLEVEL10K_SOURCE ]] || source $POWERLEVEL10K_SOURCE