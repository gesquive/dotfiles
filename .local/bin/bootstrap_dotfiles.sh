#!/usr/bin/env bash

set -e

YADM=${HOME}/.local/bin/yadm

mkdir -p ./local/bin

# Download yadm
curl -fLo ${YADM} https://github.com/TheLocehiliosan/yadm/raw/master/yadm && chmod a+x ${YADM}

# have yadm grab the dotfiles and bootstrap
${YADM} clone -f --bootstrap git@github.com:gesquive/dotfiles.git
${YADM} status
