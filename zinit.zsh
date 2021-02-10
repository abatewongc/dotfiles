module_path+=( "/mnt/c/Users/cblue_000/.zinit/bin/zmodules/Src" )

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

zinit ice depth=1
zinit light romkatv/powerlevel10k