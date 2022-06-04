export ADOTDIR=$HOME/.local/share/antigen
source "${HOME}/.local/share/antigen.zsh"

# Select theme
antigen theme denysdovhan/spaceship-prompt

# Load the oh-my-zsh library
antigen use oh-my-zsh
# Install oh-my-zsh plugins
antigen bundle colored-man-pages
antigen bundle command-not-found
antigen bundle docker
antigen bundle docker-compose
antigen bundle gitfast
antigen bundle kubectl
antigen bundle pip
antigen bundle ripgrep

antigen bundle zsh-users/zsh-history-substring-search #./zsh-history-substring-search.zsh
antigen bundle zsh-users/zsh-autosuggestions #./zsh-autosuggestions.zsh
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-syntax-highlighting

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
