#!/usr/bin/env bash
# Heavily borrowed from:
#   https://github.com/robbyrussell/oh-my-zsh/blob/ef031df/tools/check_for_upgrade.sh

DOTFILES_DIR="${HOME}/.dotfiles"

CURRENT_EPOCH=$(( $(date +%s) / 86400 ))

function _update_last_prompt_time() {
  echo "LAST_EPOCH=${CURRENT_EPOCH}" > "${HOME}/.dotfiles-update"
}

function _upgrade_dotfiles() {
  ${DOTFILES_DIR}/bootstrap_dotfiles.sh
  # update the dotfiles file
  _update_last_prompt_time
}

update_days=13

# Cancel upgrade if the current user doesn't have write permissions for the
# dotfiles directory.
[[ -w "$DOTFILES_DIR" ]] || return 0

# Cancel upgrade if git is unavailable on the system
which git >/dev/null || return 0

if [ -f ~/.dotfiles-update ]; then
  source ~/.dotfiles-update

  if [[ -z "$LAST_EPOCH" ]]; then
    _update_last_prompt_time && return 0;
  fi

  epoch_diff=$(( ${CURRENT_EPOCH} - $LAST_EPOCH ))
  if [ $epoch_diff -gt $update_days ]
  then
    if [ "$DISABLE_UPDATE_PROMPT" = "true" ]
    then
      _upgrade_dotfiles
    else
      echo -n "[dotfiles] Would you like to check for updates? [Y/n]: "
      read -n 1 ans
      echo ""
      if [[ "$ans" == Y* ]] || [[ "$ans" == y* ]] || [ -z "$ans" ]; then
        _upgrade_dotfiles
      else
        _update_last_prompt_time
      fi
    fi
  fi
else
  # create the dotfiles file
  _update_last_prompt_time
fi
