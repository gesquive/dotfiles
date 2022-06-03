# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="bitzero"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(bower colored-man-pages colorize git golang node nvm pip python rvm sublime vagrant virtualenv zsh-autosuggestions zsh-syntax-highlighting)

if [[ $CURRENT_OS == 'OS X' ]]; then
	plugins+=(brew brew-cask osx)
elif [[ $CURRENT_OS == 'Linux' ]]; then
	plugins+=(command-not-found debian systemd)
elif [[ $CURRENT_OS == 'Cygwin' ]]; then
	plugins+=(cygwin)
fi

# User configuration
export PATH="$HOME/.local/bin:$HOME/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"
# export MANPATH="/usr/local/man:$MANPATH"

# Setup virtualenvwrapper
if [ -x "$(command -v virtualenvwrapper.sh)" -o -f "/etc/bash_completion.d/virtualenvwrapper" ]; then
	plugins+=(virtualenvwrapper)
fi

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

source $ZSH/oh-my-zsh.sh

if command -v starship >/dev/null; then
    eval "$(starship init zsh)"
fi
