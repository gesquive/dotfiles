export ADOTDIR=$HOME/.local/share/antigen
ANTIGEN=~/.local/share/antigen.zsh
source "${ANTIGEN}"

# Load Antigen configurations
# antigen init ~/.config/antigenrc
# Select theme
antigen theme denysdovhan/spaceship-prompt

# Load the oh-my-zsh's library.
antigen use oh-my-zsh
antigen bundle colored-man-pages
antigen bundle command-not-found
antigen bundle docker
antigen bundle docker-compose
antigen bundle gitfast
# antigen bundle golang
antigen bundle kubectl
# antigen bundle node
# antigen bundle nvm
antigen bundle pip
# antigen bundle pipenv
# antigen bundle python
antigen bundle ripgrep
# antigen bundle sublime
# antigen bundle terraform
# antigen bundle tmux
# antigen bundle vagrant
# antigen bundle virtualenv

# antigen bundle history-substring-search

#bindkey -v
#bindkey '^R' history-incremental-search-backward

CURRENT_OS=$(uname)
if [[ $CURRENT_OS == 'Darwin' ]]; then
	# plugins+=(brew brew-cask osx)
	# antigen bundle brew
	# antigen bundle brew-cask
	# antigen bundle macos
elif [[ $CURRENT_OS == 'Linux' ]]; then
	# plugins+=(command-not-found debian systemd)
	# antigen bundle debian
	# antigen bundle systemd
fi

antigen bundle zsh-users/zsh-history-substring-search #./zsh-history-substring-search.zsh
antigen bundle zsh-users/zsh-autosuggestions #./zsh-autosuggestions.zsh
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-syntax-highlighting

# Setup virtualenvwrapper
# if [ -x "$(command -v virtualenvwrapper.sh)" -o -f "/etc/bash_completion.d/virtualenvwrapper" ]; then
# 	# plugins+=(virtualenvwrapper)
# 	antigen bundle virtualenvwrapper
# fi

antigen apply

setopt HIST_IGNORE_SPACE

# source common definitions
if [ -f ~/.config/shell_env ]; then
    . ~/.config/shell_env
fi
if [ -f ~/.config/shell_common ]; then
    source ~/.config/shell_common
fi
if [ -f ~/.config/shell_aliases ]; then
    source ~/.config/shell_aliases
fi
if [ -f ~/.zsh_local ]; then
    source ~/.zsh_local
fi

if command -v starship >/dev/null; then
    eval "$(starship init zsh)"
fi
