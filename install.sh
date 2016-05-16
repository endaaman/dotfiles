#!/bin/bash

CYAN='\033[0;34m'
NC='\033[0m'

cd

ln -fs ~/dotfiles/editorconfig ~/.editorconfig
ln -fs ~/dotfiles/gitconfig ~/.gitconfig
ln -fs ~/dotfiles/gitignore_global ~/.gitignore_global
ln -fs ~/dotfiles/zshrc ~/.zshrc


if [ ! -d '.nodebrew' ]; then
  printf "\n"
  printf "${CYAN}nodebew is not installed.${NC}\n"
  printf "${CYAN}Installing nodebrew...${NC}\n"
  curl -L git.io/nodebrew | perl - setup
  printf "${CYAN}Install node.js v4...${NC}\n"
  ~/.nodebrew/nodebrew install-binary 4
else
  printf "${CYAN}nodebrew is alreay installed${NC}\n"
fi

if [ ! -d '.pyenv' ]; then
  printf "\n"
  printf "${CYAN}pyenv is not installed.${NC}\n"
  printf "${CYAN}Installing pyenv...${NC}\n"
  git clone https://github.com/yyuu/pyenv.git ~/.pyenv
else
  printf "${CYAN}pyenv is alreay installed${NC}\n"
fi

if [ ! -d '.pyenv/plugins/pyenv-virtualenv' ]; then
  printf "\n"
  printf "${CYAN}pyenv-virtualenv is not installed.${NC}\n"
  printf "${CYAN}Installing pyenv-virtualenv...${NC}\n"
  git clone https://github.com/yyuu/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv
else
  printf "${CYAN}pyenv-virtualenv is alreay installed${NC}\n"
fi


if [ ! -d '.rbenv' ]; then
  printf "\n"
  printf "${CYAN}rbenv is not installed.${NC}\n"
  printf "${CYAN}Installing rbenv...${NC}\n"
  git clone https://github.com/rbenv/rbenv.git ~/.rbenv
  printf "${CYAN}Done${NC}\n\n"
else
  printf "${CYAN}rbenv is alreay installed${NC}\n"
fi

if [ ! -d '.rbenv/plugins/ruby-build' ]; then
  printf "\n"
  printf "${CYAN}ruby-build is not installed.${NC}\n"
  printf "${CYAN}Installing ruby-build...${NC}\n"
  git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
  printf "${CYAN}Done${NC}\n\n"
else
  printf "${CYAN}ruby-build is alreay installed${NC}\n"
fi

if [ ! -d '.git-prompt' ]; then
  printf "\n"
  printf "${CYAN}zsh-git-prompt is not installed.${NC}\n"
  printf "${CYAN}Installing zsh-git-prompt...${NC}\n"
  git clone https://github.com/olivierverdier/zsh-git-prompt.git ~/.git-prompt
  printf "${CYAN}Done${NC}\n"
else
  printf "${CYAN}git-prompt is alreay installed${NC}\n"
fi



printf "\n${CYAN}All has been done.${NC}\n"
