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

# Setup Golang
export GOROOT="/usr/local/go"
export GOPATH="$HOME/gowork"
# [[ -d $GOPATH ]] || mkdir -p $GOPATH
export PATH="$PATH:$GOROOT/bin:$GOPATH/bin"

# Setup GVM
[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"

# Setup Java
if [[ -d /usr/lib/jvm/java-7-oracle/ ]]; then
	export PATH="$PATH:/usr/lib/jvm/java-7-oracle/bin:/usr/lib/jvm/java-7-oracle/db/bin:/usr/lib/jvm/java-7-oracle/jre/bin"
fi

# Setup python virtualenvs/pipenv
export WORKON_HOME=$HOME/.local/share/virtualenvs
export PROJECT_HOME=$HOME/gitroot

# Setup pyenv
export PYENV_ROOT=$HOME/.local/share/pyenv
export PATH=$PYENV_ROOT/bin:$PATH

# Setup pipsi
export PIPSI_HOME=$HOME/.local/share/virtualenvs
export PIPSI_BIN_DIR=$HOME/.local/bin

# Setup pipx
export PIPX_HOME=$HOME/.local/share/pipx
export PIPX_BIN_DIR=$HOME/.local/bin

# You may need to manually set your language environment
export LANG=en_US.UTF-8

export TERM=xterm-256color
export EDITOR vim

setopt HIST_IGNORE_SPACE

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Save the command for logging purposes
save_prompt() {
	[[ -d ~/.logs ]] || mkdir ~/.logs
	if [ "$(id -u)" -ne 0 ]; then
		LAST_CMD=$(history $((HISTCMD-1)) | tail -n1 | cut -d ' ' -f 3-)
		echo "$(date "+%Y-%m-%d.%H:%M:%S") $(pwd) ${LAST_CMD}" >> ~/.logs/shell-history-$(date "+%Y-%m-%d").log;
	fi
}

# export PROMPT_COMMAND=save_prompt
# precmd() { save_prompt; }

if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi
if [ -f ~/.zsh_local ]; then
    source ~/.zsh_local
fi

source $ZSH/oh-my-zsh.sh

eval "$(starship init zsh)"

