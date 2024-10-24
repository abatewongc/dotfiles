#!/bin/zsh

alias yo="nocorrect yo"

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

# optionals
command -v eza > /dev/null || echo '[WARN] eza is missing.'
command -v eza > /dev/null && alias ll='eza --group-directories-first --all --long --icons -m --time-style long-iso  --color always'
command -v eza > /dev/null && alias lt='eza --tree'
command -v btm > /dev/null || echo '[WARN] btm is missing.'
command -v btm > /dev/null && alias top='btm'
command -v bat > /dev/null || echo '[WARN] bat is missing.'
command -v bat > /dev/null && alias cat='bat -P'
command -v rg > /dev/null || echo '[WARN] ripgrep is missing'
command -v rg > /dev/null && alias grep='rg'

# quickly navigate and utilize .ssh
alias cdssh='cd ~/.ssh; cat config'
alias sshcd='cd ~/.ssh; cat config'
alias ssh='ssh -A'

# quickly edit this configuration
alias reloz='exec zsh'
alias codez="code $DOT"

# TMUX
# kill all sessions
alias "tmux-kill-all"="tmux ls | grep : | cut -d. -f1 | awk '{print substr($1, 0, length($1)-1)}' | xargs kill"
alias @@='$($(fc -ln -1) |& tail -1)'
alias tmuxa='tmux attach -t'
alias tmuxn='tmux new -s'

# remove key quickly
alias removekey="ssh-keygen -R"

alias tf="terraform"
alias tfw="terraform workspace"

alias getstatuscode="curl -s -o /dev/null -w "%{http_code}""
alias c="tput reset"

alias sp="spotify"

alias update_hashicorp=$SYNC_HOME/Sync/Linux/update_hashicorp.sh

#alias find='fd'
alias tf12='terraform0.12.20'
alias tf11='terraform0.11.14'
alias exit='exit 0'

alias aws_account_id='aws sts get-caller-identity --query "Account" --output text'

alias kc='kubectl'

# use the correct pip
alias pip='python -m pip'
alias ytdl='youtube-dl'
alias say-locally="echo EMIT SAY"
alias notify_disc="$DOT/scripts/notify_disc.sh"
alias godot="/Applications/Godot.app/Contents/MacOS/Godot"
