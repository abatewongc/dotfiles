#!/bin/zsh

export DOT_NAME=.dot
export DOT=$HOME/$DOT_NAME
export DOT_ZSH=$DOT/zsh

git clone https://github.com/abatewongc/dotfiles.git $DOT

# z4h
if command -v curl >/dev/null 2>&1; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/romkatv/zsh4humans/v5/install)"
else
  sh -c "$(wget -O- https://raw.githubusercontent.com/romkatv/zsh4humans/v5/install)"
fi
echo '' > ~/.zshrc
echo '# source universal dotfiles repository' >> $HOME/.zshrc
echo 'source "$HOME/'$DOT_NAME'/zsh/.zshrc"' >> $HOME/.zshrc

# os-specific installation steps
apt get update
apt get install -y build-essential zip unzip curl wget

# misc
cp $DOT/other/.tmux.conf $HOME/.tmux.conf

# rust
curl https://sh.rustup.rs -sSf | sh
source $HOME/.cargo/env
cargo install cargo-quickinstall
cargo quickinstall ripgrep bat tokei fd-find procs eza tealdeer bottom

# sdkman
curl -s "https://get.sdkman.io" | bash

# python
(
  git clone https://github.com/pyenv/pyenv.git $HOME/.pyenv
  cd ~/.pyenv && src/configure && make -C src
)

echo '' > ~/.zshrc
echo '# source universal dotfiles repository' >> $HOME/.zshrc
echo 'source "$HOME/'$DOT_NAME'/zsh/.zshrc"' >> $HOME/.zshrc

# finally
exec zsh
