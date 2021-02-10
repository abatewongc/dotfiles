alias explorer='explorer.exe `wslpath -w "$PWD"`'
alias ex='explorer'
# Copy .ssh
upd_ssh(){
	rm -rf ~/.ssh
	/bin/cp -rf "/mnt/c/Users/$(whoami)/.ssh" ~/.ssh
	chmod 600 ~/.ssh/*
}
# Windows Path handling for performance
WIN_PATH=$(echo $PATH | tr ':' '\n' | grep '/mnt/c' | tr '\n' ':' | sed 's/.$//')
export PATH=$(echo $PATH | tr ':' '\n' | grep -v '/mnt/c' | tr '\n' ':' | sed 's/.$//')
export PATH="$PATH:$WIN_PATH"
export PATH="$PATH:/mnt/c/Windows/"