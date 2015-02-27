# Alias definitions.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

export EDITOR vim

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto -h'
    alias dir='ls --color=auto --format=vertical'
    alias vdir='ls --color=auto --format=long'
    alias l.='ls -dF .[a-zA-Z0-9]* --color=tty'
    alias ll.='ls -dlF .[a-zA-Z0-9]* --color=tty'
    alias grep='grep --color=auto'
    alias less='less --raw-control-chars'
fi

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias lla='ls -lA'
alias ld='ls -al -d * | egrep "^d"' # only subdirectories
alias lt='ls -alt | head -20' # recently changed files

# directory tree - http://www.shell-fu.org/lister.php?id=209  
alias tdir='find . -type d | sed -e "s/[^-][^\/]*\//  |/g" -e "s/|\([^ ]\)/|-\1/"'

# display file sizes
alias du="du -h"
alias df="df -h"

# common aliases
alias cd..='cd ..'
alias cls='clear'
alias del='rm -R'
alias reboot='sudo shutdown --reboot now'
alias g='gnome-open'
alias web_own='sudo chown www-data:www-data'

alias list_zombies='ps -el | grep 'Z''

# installation alias
#alias apt-install="sudo aptitude install"
#alias apt-remove="sudo aptitude purge"
alias apt-search="sudo aptitude search"
alias apt-install="sudo apt-get install"
alias apt-remove="sudo apt-get autoremove"
alias apt-clean="sudo apt-get autoclean"

# bash history alias
alias top_commands="history | awk '{print $2}' | sort | uniq -c | sort -rn | head -10"
alias hide_me='history -d $((HISTCMD-1))'
alias hide_prev='history -d $((HISTCMD-2)) && history -d $((HISTCMD-1))'

# file config edits
alias edit_aliases='vim ~/.bash_aliases && . ~/.bash_aliases'
alias edit_vnc_config='sudo vim /etc/xinetd.d/x11vnc'
#ceryx only
#alias edit_ftp_config='sudo $EDITOR /etc/proftpd/proftpd.conf'
#alias edit_server_config='sudo $EDITOR /etc/apache2/sites-available/default'
#alias edit_proxy_config='sudo $EDITOR /etc/squid/squid.conf'
#alias edit_moblock_config='sudo $EDITOR /etc/blockcontrol/blockcontrol.conf'

#alias ftp_server='sudo /etc/init.d/proftpd'
alias vnc_server='sudo /etc/init.d/xinetd'
#alias prx_server='sudo /etc/init.d/squid'
#alias moblock='sudo /etc/init.d/blockcontrol'

# program logs - ceryx only
#alias ftp_log='tail -n 20 /var/log/proftpd/xferlog'
#alias p2p_log='tail /var/log/moblock.log'

alias anon_fire='history -d $((HISTCMD-1)) && firefox -P Anon -no-remote &'

# wireless connection
#alias net_up='sudo ifup ra0'
#alias net_down='sudo ifdown ra0'
alias wifi_strength="iwconfig wlan0 | sed 's/  /\n/g' | grep Quality | sed 's/Link Quality://' | sed 's/Link Quality=//' | sed 's/ //g'"

alias netports='sudo lsof -i -P'

alias hulu-dl='get_flash_videos --quality high --subtitles'
alias youtube-dl='youtube-dl -t'


################################### shell-fu ###################################

mkcd() {
    dir="$*";
    mkdir -p "$dir" && cd "$dir";
}

# convert permissions to octal - http://www.shell-fu.org/lister.php?id=205  
alias lo='ls -l | sed -e 's/--x/1/g' -e 's/-w-/2/g' -e 's/-wx/3/g' -e 's/r--/4/g' -e 's/r-x/5/g' -e 's/rw-/6/g' -e 's/rwx/7/g' -e 's/---/0/g'' 

function cdl { cd $1; ls; }

# echo and execute
ee() {
    echo "$@"
    $1 "$2"
}

# bash function to decompress archives - http://www.shell-fu.org/lister.php?id=375
extract () {
    for x in "$@"; do
        if [ -f $x ] ; then
            case "$x" in
                *.tar.bz2)  ee "tar xvjf" "$x"      ;;  
                *.tar.gz)   ee "tar xvzf" "$x"      ;;  
                *.bz2)      ee "bunzip2" "$x"       ;;  
                *.rar)      ee "unrar x" "$x"       ;;  
                *.gz)       ee "gunzip" "$x"        ;;  
                *.tar)      ee "tar xvf" "$x"       ;;  
                *.tbz2)     ee "tar xvjf" "$x"      ;;  
                *.tgz)      ee "tar xvzf" "$x"      ;;  
                *.zip)      ee "unzip" "$x"         ;;  
                *.Z)        ee "uncompress" "$x"    ;;  
                *.7z)       ee "7z x" "$x"          ;;  
                *)          echo "'$x' cannot be extracted via >extract<" ;;  
            esac
        fi
    done
}  

function swap()         
{
    local TMPFILE=tmp.$$
    mv "$1" $TMPFILE && mv "$2" "$1" && mv $TMPFILE "$2"
}
