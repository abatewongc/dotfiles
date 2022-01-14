#!/bin/zsh

skip_global_compinit=1

# Powerlevel10k Instant Prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#--- PRE-INIT BEGIN --------------------------------------------------------------------------------------
export DOT_HOME=".dot"
export DOT=$HOME/$DOT_HOME
export DOT_ZSH=$DOT/zsh

# update dotfiles
#detach $DOT/scripts/update_dot.sh $DOT > /dev/null 2>&1 &

if [[ -v WSL_DISTRO_NAME ]] then
  source $DOT_ZSH/os/wsl/preinit.zsh
fi

CURRENT_OS=$(uname)
if [[ "$CURRENT_OS" == "Darwin" ]] then
  source $DOT_ZSH/os/osx/preinit.zsh
fi
#--- PRE-INIT END -----------------------------------------------------------------------------------------------------

source $DOT_ZSH/z4h.zsh
#source $DOT_ZSH/zinit.zsh
source $DOT_ZSH/general.zsh $DOT
source $DOT_ZSH/zsh.zsh
source $DOT_ZSH/function.zsh
source $DOT_ZSH/export.zsh
source $DOT_ZSH/alias.zsh
source $DOT_ZSH/eval.zsh
source $DOT_ZSH/keybindings.zsh

#--- POST-INIT BEGIN --------------------------------------------------------------------------------------------------
if [[ -v WSL_DISTRO_NAME ]] then
  source $DOT_ZSH/os/wsl/postinit.zsh
fi

CURRENT_OS=$(uname)
if [[ "$CURRENT_OS" == "Darwin" ]] then
  source $DOT_ZSH/os/osx/postinit.zsh
fi

WORK_HOSTNAME="Macbook-Pro"
if [[ "$HOSTNAME" == "$WORK_HOSTNAME" ]] then
  source $DOT_ZSH/work.zsh
  source $DOT_ZSH/secrets.zsh
fi
unset WORK_HOSTNAME
#--- POST-INIT END ----------------------------------------------------------------------------------------------------

# To customize prompt, run `p10k configure` or edit $POWERLEVEL10K_SOURCE
export POWERLEVEL10K_SOURCE=$DOT_ZSH/.p10k.zsh
[[ ! -f $POWERLEVEL10K_SOURCE ]] || source $POWERLEVEL10K_SOURCE

#--- POST-PL10K BEGIN ---------------------------------------------------------------------------------------------------

if [[ -v WSL_DISTRO_NAME ]] then
  source $DOT_ZSH/os/wsl/post10k.zsh
fi

CURRENT_OS=$(uname)
if [[ "$CURRENT_OS" == "Darwin" ]] then
  source $DOT_ZSH/os/osx/post10k.zsh
fi
#--- POST-PL10K END -----------------------------------------------------------------------------------------------------

source $DOT_ZSH/final.zsh
