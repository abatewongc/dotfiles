#!/bin/zsh

cd $1

echo "Updating $1..."
git stash
git pull
git stash pop
echo "Update complete."