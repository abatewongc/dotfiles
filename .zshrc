#!/bin/zsh

skip_global_compinit=1

module_path+=( "$HOME/.zinit/bin/zmodules/Src" )
zmodload zdharma/zplugin

# Powerlevel10k Instant Prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk

zinit wait lucid light-mode for \
  OMZ::lib/git.zsh \
  OMZ::lib/grep.zsh \
  OMZ::lib/spectrum.zsh \
  OMZ::plugins/git/git.plugin.zsh \
  OMZ::plugins/gnu-utils/gnu-utils.plugin.zsh

# load jenv, pyenv
zinit wait"!0" lucid light-mode svn for \
  OMZ::plugins/jenv \
  OMZ::plugins/pyenv

zinit wait lucid light-mode for \
  zsh-users/zsh-history-substring-search \
  atinit"zicompinit; zicdreplay" \
      zdharma/fast-syntax-highlighting \
  atload"_zsh_autosuggest_start" \
      zsh-users/zsh-autosuggestions
zinit wait lucid atload"zicompinit; zicdreplay" blockf for \
  zsh-users/zsh-completions \
  esc/conda-zsh-completion

zinit ice depth=1
zinit light romkatv/powerlevel10k

export DOT=$HOME/dot

source $DOT/zsh.zsh
source $DOT/function.zsh
source $DOT/export.zsh
source $DOT/alias.zsh
source $DOT/eval.zsh
source $DOT/keybindings.zsh

if [[ -v WSL_DISTRO_NAME ]] then
  source $DOT/wsl.zsh
fi

WORK_HOSTNAME="cwong-mbp"
if [[ $HOSTNAME -eq $WORK_HOSTNAME ]] then
  source $DOT/work.zsh
fi
unset WORK_HOSTNAME

# To customize prompt, run `p10k configure` or edit $POWERLEVEL10K_SOURCE
export POWERLEVEL10K_SOURCE=$DOT/.p10k.zsh
[[ ! -f $POWERLEVEL10K_SOURCE ]] || source $POWERLEVEL10K_SOURCE