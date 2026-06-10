# direnv: handled by z4h via zstyle ':z4h:direnv' enable 'yes' in zsh.zsh
# fasd: removed, using zoxide instead

# Lazy-load pyenv: only initializes when pyenv/python is first called
if command -v pyenv > /dev/null; then
  export PYENV_ROOT="$HOME/.pyenv"
  path=("$PYENV_ROOT/shims" "$PYENV_ROOT/bin" $path)
  function pyenv() {
    unfunction pyenv python python3 pip
    eval "$(command pyenv init --path)"
    eval "$(command pyenv init -)"
    pyenv "$@"
  }
  function python() { unfunction pyenv python python3 pip; eval "$(command pyenv init --path)"; eval "$(command pyenv init -)"; python "$@"; }
  function python3() { unfunction pyenv python python3 pip; eval "$(command pyenv init --path)"; eval "$(command pyenv init -)"; python3 "$@"; }
  function pip() { unfunction pyenv python python3 pip; eval "$(command pyenv init --path)"; eval "$(command pyenv init -)"; pip "$@"; }
fi

# Reuse existing ssh-agent instead of spawning a new one each shell
if [[ -z "$SSH_AUTH_SOCK" ]]; then
  eval "$(ssh-agent -s)" > /dev/null
fi

#command -v ferium > /dev/null && eval "$(ferium complete bash)" > /dev/null

# Lazy-load SDKMAN: only initializes when sdk/java/gradle/mvn is first called
if [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]]; then
  export SDKMAN_DIR="$HOME/.sdkman"
  function sdk() {
    unfunction sdk java gradle mvn
    source "$HOME/.sdkman/bin/sdkman-init.sh"
    sdk "$@"
  }
  function java() { unfunction sdk java gradle mvn; source "$HOME/.sdkman/bin/sdkman-init.sh"; java "$@"; }
  function gradle() { unfunction sdk java gradle mvn; source "$HOME/.sdkman/bin/sdkman-init.sh"; gradle "$@"; }
  function mvn() { unfunction sdk java gradle mvn; source "$HOME/.sdkman/bin/sdkman-init.sh"; mvn "$@"; }
fi

#source ~/.zsh/zsh-magic-dashboard/magic_dashboard.zsh
eval "$(zoxide init --cmd cd zsh)"
