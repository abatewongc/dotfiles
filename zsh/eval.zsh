command -v direnv > /dev/null && eval "$(direnv hook zsh)"
command -v fasd > /dev/null && eval "$(fasd --init auto)"
command -v pyenv > /dev/null && eval "$(pyenv init --path)"
command -v pyenv > /dev/null && eval "$(pyenv init -)"
eval "$(ssh-agent -s)" > /dev/null
command -v ferium > /dev/null && eval "$(ferium complete bash)" > /dev/null

[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

source ~/.zsh/zsh-magic-dashboard/magic_dashboard.zsh
eval "$(zoxide init --cmd cd zsh)"