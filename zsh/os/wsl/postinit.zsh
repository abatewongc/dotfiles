#----------------------------------------------------------------------------------------------------------------
# WSL-specific startup
#----------------------------------------------------------------------------------------------------------------
# postinit
#----------------------------------------------------------------------------------------------------------------

# Keyboard type: 'mac' or 'pc'.
zstyle ':z4h:bindkey' keyboard 'pc'

# Define key bindings.
z4h bindkey z4h-backward-kill-word  Ctrl+Backspace Ctrl+H
z4h bindkey z4h-backward-kill-zword Ctrl+Alt+Backspace

z4h bindkey undo Ctrl+/  # undo the last command line change
z4h bindkey redo Alt+/   # redo the last undone command line change

z4h bindkey z4h-cd-back    Alt+Left   # cd into the previous directory
z4h bindkey z4h-cd-forward Alt+Right  # cd into the next directory
z4h bindkey z4h-cd-up      Alt+Up     # cd into the parent directory
z4h bindkey z4h-cd-down    Alt+Down   # cd into a child directory

alias ex='explorer'
function explorer () {
	explorer.exe `wslpath -w "$1"`
}

function cdw() {
  cd "$(wslpath -u $1)"
}

function intellij () {
	"/mnt/c/Program Files/JetBrains/IntelliJ IDEA 2023.1.2/bin/idea64.exe" `wslpath -w "$1"`
}

# Copy .ssh
upd_ssh(){
	rm -rf ~/.ssh
	/bin/cp -rf "/mnt/c/Users/$(whoami)/.ssh" ~/.ssh
	chmod 600 ~/.ssh/*
}

export PATH="$PATH:/mnt/c/Windows/"

export CARGO_HOME=$HOME/.cargo
export RUSTUP_HOME=$HOME/.rustup
export PATH="$PATH:$CARGO_HOME"
export PATH="$PATH:$HOME/go/bin"
export SYNC="/mnt/w/sync"

export PATH=$PATH:/home/aleosiss/workspace/pacmc/pacmc-0.4.2/bin
export MINECRAFT_DIR=/mnt/c/Users/Christian/AppData/Roaming/PrismLauncher/instances/fabric-1.15.1-build.6_yarn-0.7.2-build.175/.minecraft
export MINECRAFT_MOD_DIR=$MINECRAFT_DIR/mods

alias mhw='/mnt/h/SteamLibrary/steamapps/common/Monster\ Hunter\ World/mhwreshadeinjectorhelper.exe'
