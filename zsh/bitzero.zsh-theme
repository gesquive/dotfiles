# bitzero.zsh-theme
# forked from af-magic
# https://github.com/andyfleming/oh-my-zsh/blob/master/themes/af-magic.zsh-theme

# color vars
eval sys_color='$FG[240]'
eval dirty_color='$FG[214]'
eval virt_color='$FG[023]'
eval git_color='$FG[064]'
eval prompt_color='$FG[032]'
eval sudo_prompt_color='$FG[196]'

if [ $UID -eq 0 ]; then
	eval ncolor='%{$sudo_prompt_color%}';
else
	eval ncolor='%{$prompt_color%}';
fi
local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

# primary prompt
PROMPT='%{$sys_color%}%n@%m%{$reset_color%}% $FG[237]%{$reset_color%}
%{$ncolor%}%~ %(!.#.»)%{$reset_color%} '
PROMPT2='%{$fg[red]%}\ %{$reset_color%}'
RPS1='${return_code}'

# right prompt
if type "virtualenv_prompt_info" > /dev/null; then
	RPROMPT='$(virtualenv_prompt_info)'
else
	RPROMPT=''
fi
RPROMPT+='$(git_prompt_info)'

# git settings
ZSH_THEME_GIT_PROMPT_PREFIX="%{$git_color%}[git:"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="%{$dirty_color%}*%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$git_color%}]%{$reset_color%}"

ZSH_THEME_VIRTUALENV_PREFIX="%{$virt_color%}["
ZSH_THEME_VIRTUALENV_SUFFIX="]%{$reset_color%}"
