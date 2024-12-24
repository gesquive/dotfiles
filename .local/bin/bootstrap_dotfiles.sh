#!/usr/bin/env sh

set -e

YADM=${HOME}/.local/bin/yadm

# Check required dependencies
readonly DEPENDENCIES="tput git curl"
for dependency in ${DEPENDENCIES}; do
  if ! command -v "${dependency}" > /dev/null 2>&1; then
    echo "ERROR: command '${dependency}' not found" >&2
    exit 2
  fi
done

# BOLD="$(tput bold 2>/dev/null || printf '')"
# GREY="$(tput setaf 0 2>/dev/null || printf '')"
# UNDERLINE="$(tput smul 2>/dev/null || printf '')"
# RED="$(tput setaf 1 2>/dev/null || printf '')"
# GREEN="$(tput setaf 2 2>/dev/null || printf '')"
# YELLOW="$(tput setaf 3 2>/dev/null || printf '')"
# BLUE="$(tput setaf 4 2>/dev/null || printf '')"
# MAGENTA="$(tput setaf 5 2>/dev/null || printf '')"
NO_COLOR="$(tput sgr0 2>/dev/null || printf '')"


info() {
    BOLD="$(tput bold 2>/dev/null || printf '')"
    GREY="$(tput setaf 0 2>/dev/null || printf '')"
    printf '%s\n' "${BOLD}${GREY}>${NO_COLOR} $*"
}

warn() {
    YELLOW="$(tput setaf 3 2>/dev/null || printf '')"
    printf '%s\n' "${YELLOW}! $*${NO_COLOR}"
}

error() {
    RED="$(tput setaf 1 2>/dev/null || printf '')"
    printf '%s\n' "${RED}x $*${NO_COLOR}" >&2
}

completed() {
    GREEN="$(tput setaf 2 2>/dev/null || printf '')"
    printf '%s\n' "${GREEN}✓${NO_COLOR} $*"
}

has() {
  command -v "$1" 1>/dev/null 2>&1
}

if ! has yadm; then # install yadm
    mkdir -p "$(dirname "${YADM}")"
    curl -sSfLo "${YADM}" https://github.com/TheLocehiliosan/yadm/raw/master/yadm
    chmod a+x "${YADM}"
fi

if [ -z "${REPO}" ]; then
    REPO=https://github.com/gesquive/dotfiles.git
    if ssh -o StrictHostKeyChecking=accept-new -q git@github.com; [ $? -eq 1 ]; then
        REPO=git@github.com:gesquive/dotfiles.git
    fi
fi
info "repo: ${REPO}"

# have yadm grab the dotfiles and bootstrap
export PATH=$HOME/.local/bin:$PATH
${YADM} clone -f --bootstrap ${REPO}
${YADM} status
