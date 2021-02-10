#!/bin/zsh

alias yo="nocorrect yo"

# optionals
command -v lsd > /dev/null && alias ls='lsd --group-dirs first'
command -v lsd > /dev/null && alias ls='lsd --tree'
command -v bashtop > /dev/null && alias top='bashtop'
command -v bat > /dev/null && alias cat='bat --pager=never'
command -v bat > /dev/null && alias bat='bat --theme=ansi-dark'

# colors
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias diff='diff --color=auto'

# standard list directory
alias ll='ls -lah --group-directories-first'
alias lll='ls -lhfG'
# some more ls aliases
alias la='ls -A'
alias l='ls -CF'

# quickly navigate and utilize .ssh
alias cdssh='cd ~/.ssh; cat config'
alias sshcd='cd ~/.ssh; cat config'
alias ssh='ssh -A'

# quickly edit this configuration
alias reloz='exec zsh'
alias editz='vim ~/.zshrc'
alias codez='code ~/.zshrc'

# TMUX
# kill all sessions
alias "tmux-kill-all"="tmux ls | grep : | cut -d. -f1 | awk '{print substr($1, 0, length($1)-1)}' | xargs kill"
alias @@='$($(fc -ln -1) |& tail -1)'

# remove key quickly
alias removekey="ssh-keygen -R"

alias tf="terraform"
alias tfw="terraform workspace"

alias getstatuscode="curl -s -o /dev/null -w "%{http_code}""
alias c="tput reset"

alias sp="spotify"

alias update_hashicorp=~/Sync/Linux/update_hashicorp.sh

#alias find='fd'
alias tf12='terraform0.12.20'
alias tf11='terraform0.11.14'
alias exit='exit 0'