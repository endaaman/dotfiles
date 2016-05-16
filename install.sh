#!/bin/bash

RED='\033[0;34m'
NC='\033[0m'

cd

printf "${RED}link .editorconfig${NC}\n"
ln -fs dotfiles/editorconfig ./.editorconfig
printf "${RED}link .gitconfig${NC}\n"
ln -fs dotfiles/gitconfig ./.gitconfig
printf "${RED}link .gitignore_global${NC}\n"
ln -fs dotfiles/gitignore_global ./.gitignore_global

printf "${RED}link .pyenv${NC}\n"
ln -fs dotfiles/pyenv ./.pyenv
printf "${RED}link .rbenv${NC}\n"
ln -fs dotfiles/rbenv ./.rbenv
printf "${RED}link .git-prompt${NC}\n"
ln -fs dotfiles/zsh-git-prompt ./.git-prompt

printf "${RED}link .zshrc${NC}\n"
ln -fs dotfiles/zshrc ./.zshrc


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
