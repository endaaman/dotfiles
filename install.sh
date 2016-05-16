#!/bin/bash

RED='\033[0;34m'
NC='\033[0m'

cd

ln -fs "$HOME/dotfiles/editorconfig" "$HOME/.editorconfig"
ln -fs "$HOME/dotfiles/gitconfig" "$HOME/.gitconfig"
ln -fs "$HOME/dotfiles/gitignore_global" "$HOME/.gitignore_global"

ln -fs "$HOME/dotfiles/pyenv" "$HOME/.pyenv"
ln -fs "$HOME/dotfiles/pyenv-virtualenv" "$HOME/.pyenv/plugins"
ln -fs "$HOME/dotfiles/rbenv" "$HOME/.rbenv"
ln -fs "$HOME/dotfiles/zsh-git-prompt" "$HOME/.git-prompt"

ln -fs "dotfiles/zshrc" "$HOME/.zshrc"


if [ ! -d '.nodebrew' ]; then
  printf "${RED}nodebew is not installed.${NC}\n"
  printf "${RED}Installing nodebrew...${NC}\n"
  curl -L git.io/nodebrew | perl - setup
  printf "${RED}Install node.js v4...${NC}\n"
  ~/.nodebrew/nodebrew install-binary 4
else
  printf "${RED}nodebrew is alreay installed${NC}\n"
fi

printf "\n${RED}Done${NC}\n"
