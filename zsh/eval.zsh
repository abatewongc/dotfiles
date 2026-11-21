# direnv: handled by z4h via zstyle ':z4h:direnv' enable 'yes' in zsh.zsh
# fasd: removed, using zoxide instead

# Reuse existing ssh-agent instead of spawning a new one each shell
if [[ -z "$SSH_AUTH_SOCK" ]]; then
  eval "$(ssh-agent -s)" > /dev/null
fi

#command -v ferium > /dev/null && eval "$(ferium complete bash)" > /dev/null

#source ~/.zsh/zsh-magic-dashboard/magic_dashboard.zsh
eval "$(zoxide init --cmd cd zsh)"
eval "$($HOME/.local/bin/mise activate zsh)"