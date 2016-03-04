# dotfiles
These dotfiles have been tested with Ubuntu and OS X. If you want to try them, I would fork this repo, review, and remove any code you don't want.

## Usage
### Install
To install, download and run.
```
wget https://git.io/v2QiA -O - | bash
```

### Update
Once installed you can force an update by running the alias
```
update_dotfiles
```
or run the command directly
```
~/.dotfiles/bootstrap_dotfiles.sh
```

By default the `check_for_upgrade.sh` script checks for an upgrade every 13 days.

If you want to enable silent upgrades just define the environment variable `DISABLE_UPDATE_PROMPT` and upgrades will occur every check.

### Local files

Server specific settings and aliases can be configured outside of this git repository and loaded automatically with the following locations:

 - bash: `~/.bash_local`
 - git: `~/.gitconfig_local`
 - tmux: `~/.tmux.local.conf`
