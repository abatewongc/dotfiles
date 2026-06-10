

DOT=$1

# completions dir
[[ -d $DOT/.zsh_completions ]] || mkdir -p $DOT/.zsh_completions
fpath+=$DOT/.zsh_completions