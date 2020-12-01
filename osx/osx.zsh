#----------------------------------------------------------------------------------------------------------------
# OSX-specific startup
#----------------------------------------------------------------------------------------------------------------

alias yes="echo 'Don't type that."
alias intellij='open -a "Intellij IDEA"'

alias mysqlserver='/usr/local/opt/mysql@5.7/bin/mysql.server'
alias spotify=/usr/local/Cellar/node/11.4.0/bin/spotif

alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

export STEAM_HOME="/Users/cwong/Library/Application Support/Steam"
export PATH="$PATH:/user/sbin"
export PATH=$PATH:$HOME/Sync/scripts/custom_commands
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="/Users/cwong/.local/bin:$PATH"