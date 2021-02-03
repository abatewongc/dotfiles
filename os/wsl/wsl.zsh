alias ex=/mnt/c/Windows/explorer.exe
# Copy .ssh
upd_ssh(){
	rm -rf ~/.ssh
	/bin/cp -rf "/mnt/c/Users/$(whoami)/.ssh" ~/.ssh
	chmod 600 ~/.ssh/*
}
# Windows Path handling for performance
WIN_PATH=$(echo $PATH | tr ':' '\n' | grep '/mnt/c' | tr '\n' ':' | sed 's/.$//')
export PATH=$(echo $PATH | tr ':' '\n' | grep -v '/mnt/c' | tr '\n' ':' | sed 's/.$//')
zinit wait'3' lucid atinit'export PATH="$PATH:$WIN_PATH"' nocd for /dev/null