eval "$(direnv hook bash)"
eval "$(fasd --init auto)"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(ssh-agent -s)" > /dev/null

[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"