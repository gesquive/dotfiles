#!/usr/bin/env bash

DOTFILES_SRC="https://github.com/gesquive/dotfiles"
DOTFILES_DIR="${HOME}/.dotfiles"

# Use colors, but only if connected to a terminal, and that terminal
# supports them.
if which tput >/dev/null 2>&1; then
    ncolors=$(tput colors)
fi
if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then
  RED="$(tput setaf 1)"
  GREEN="$(tput setaf 2)"
  YELLOW="$(tput setaf 3)"
  BLUE="$(tput setaf 4)"
  MAGENTA="$(tput setaf 5)"
  DARKCYAN="$(tput setaf 6)"
  BOLD="$(tput bold)"
  NORMAL="$(tput sgr0)"
else
  RED=""
  GREEN=""
  YELLOW=""
  BLUE=""
  MAGENTA=""
  DARKCYAN=""
  BOLD=""
  NORMAL=""
fi

which git >& /dev/null

if [ $? -eq 1 ]; then
	printf "${RED}%s${NORMAL}\n" "Git not found! Make sure it is installed."
	exit 1;
fi

if [ -d "${DOTFILES_DIR}" ]; then
    printf "${DARKCYAN}%s${NORMAL}\n" "Dotfiles already installed. Updating."

	cd ${DOTFILES_DIR}
	if [[ -n "$(git status --porcelain)" ]]; then
		git stash
	fi
	if git pull --rebase
	then
    	printf "${BLUE}%s${NORMAL}\n" "dotfiles have been updated and/or is at the current version."
	else
	  	printf "${RED}%s${NORMAL}\n" "There was an error updating. Try again later?"
  	fi
else
    printf "${DARKCYAN}%s${NORMAL}\n" "Installing dotfiles"

    git clone ${DOTFILES_SRC} ${DOTFILES_DIR}
fi
${DOTFILES_DIR}/install
