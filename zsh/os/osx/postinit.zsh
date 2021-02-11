#----------------------------------------------------------------------------------------------------------------
# OSX-specific startup
#----------------------------------------------------------------------------------------------------------------
# postinit
#----------------------------------------------------------------------------------------------------------------


# Keyboard type: 'mac' or 'pc'.
zstyle ':z4h:bindkey' keyboard 'mac'

# Define key bindings.
z4h bindkey undo Ctrl+/  # undo the last command line change
z4h bindkey redo Alt+/   # redo the last undone command line change

z4h bindkey z4h-cd-back    Shift+Left   # cd into the previous directory
z4h bindkey z4h-cd-forward Shift+Right  # cd into the next directory
z4h bindkey z4h-cd-up      Shift+Up     # cd into the parent directory
z4h bindkey z4h-cd-down    Shift+Down   # cd into a child directory

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
export PATH="/usr/local/sbin:$PATH"
