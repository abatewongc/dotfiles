#!/bin/zsh

alias yo="nocorrect yo"

# standard list directory
alias ll='ls -lah --group-directories-first --color'
alias lll='ls -lhfG'
# some more ls aliases
alias la='ls -A'
alias l='ls -CF'

# quickly navigate and utilize .ssh
alias cdssh='cd ~/.ssh; cat config'
alias sshcd='cd ~/.ssh; cat config'
alias ssh='ssh -A'

# quickly edit this configuration
alias reloz='source ~/.zshrc'
alias editz='vim ~/.zshrc'
alias codez='code ~/.zshrc'

alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'
# TMUX
# kill all sessions
alias "tmux-kill-all"="tmux ls | grep : | cut -d. -f1 | awk '{print substr($1, 0, length($1)-1)}' | xargs kill"
alias @@='$($(fc -ln -1) |& tail -1)'

# remove key quickly
alias removekey="ssh-keygen -R"

alias yes="echo 'Don't type that."
alias tf="terraform"
alias tfw="terraform workspace"

alias getstatuscode="curl -s -o /dev/null -w "%{http_code}""
alias c="tput reset"

alias sp="spotify"
alias codeb="code ~/.bash_profile"
alias intellij='open -a "Intellij IDEA"'

alias mysqlserver='/usr/local/opt/mysql@5.7/bin/mysql.server'
alias update_hashicorp=~/Sync/Linux/update_hashicorp.sh

alias spotify=/usr/local/Cellar/node/11.4.0/bin/spotify
alias aes='java -jar ~/Workspace/misc/encryption/opstools-decrypter-master-SNAPSHOT.jar'
alias find='fd'
alias tf12='terraform0.12.20'
alias tf11='terraform0.11.14'
alias exit='exit 0'