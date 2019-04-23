#! /usr/bin/env bash

pushd () {
    command pushd "$@" > /dev/null
}

popd () {
    command popd "$@" > /dev/null
}

if [ ! -d "${HOME}/.oh-my-zsh" ]; then
    # install zsh
    sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
fi

# install plugins
dest="${HOME}/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
if [ ! -d "${dest}" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions.git "${dest}"
else
    pushd "${dest}"
    git pull origin master
    popd
fi

dest="${HOME}/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"
if [ ! -d "${dest}" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${dest}"
else
    pushd "${dest}"
    git pull origin master
    popd
fi
