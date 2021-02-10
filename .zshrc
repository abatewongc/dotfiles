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

if [[ -v WSL_DISTRO_NAME ]] then
  source $DOT/os/wsl/wsl.zsh

  # only installed z4h on my tower
  source $DOT/z4h.zsh
fi

CURRENT_OS=$(uname)
if [[ "$CURRENT_OS" == "Darwin" ]] then
  source $DOT/os/osx/osx.zsh

  # I broke zinit on my tower
  source $DOT/zinit.zsh
fi

WORK_HOSTNAME="cwong-mbp"
if [[ "$HOSTNAME" == "$WORK_HOSTNAME" ]] then
  source $DOT/work.zsh
fi
unset WORK_HOSTNAME

source $DOT/zsh.zsh
source $DOT/function.zsh
source $DOT/export.zsh
source $DOT/alias.zsh
source $DOT/eval.zsh
source $DOT/keybindings.zsh

# To customize prompt, run `p10k configure` or edit $POWERLEVEL10K_SOURCE
export POWERLEVEL10K_SOURCE=$DOT/.p10k.zsh
[[ ! -f $POWERLEVEL10K_SOURCE ]] || source $POWERLEVEL10K_SOURCE