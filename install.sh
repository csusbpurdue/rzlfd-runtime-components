#!/bin/bash
# Install dotfiles by linking them into the home directory
DIR="$(cd "$(dirname "$0")" && pwd)"
for f in .bashrc .zshrc .vimrc .gdbinit .gitconfig; do
  if [ -e "$HOME/$f" ] && [ ! -L "$HOME/$f" ]; then
    mv "$HOME/$f" "$HOME/$f.backup"
    echo "Backed up existing $f to $f.backup"
  fi
  ln -sf "$DIR/$f" "$HOME/$f"
  echo "Linked $f"
done

# Install cowsay into ~/.local (no root needed)
DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
git clone https://github.com/cowsay-org/cowsay.git
cd cowsay
make install prefix=$HOME/.local

# Add the train cow used by boilersay (site-cows is on cowsay's default path)
mkdir -p "$HOME/.local/share/cowsay/site-cows"
cp "$DOTFILES_DIR/train.cow" "$HOME/.local/share/cowsay/site-cows/"
