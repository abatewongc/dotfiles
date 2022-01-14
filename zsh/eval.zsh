eval "$(direnv hook bash)"
eval "$(fasd --init auto)"
command -v pyenv > /dev/null && eval "$(pyenv init --path)"
command -v pyenv > /dev/null && eval "$(pyenv init -)"
eval "$(ssh-agent -s)" > /dev/null

[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"