# aliases

alias ls='ls --color=auto'
alias grep='grep --color=auto'

alias ll='ls -o --si'
alias la='ls -A'
alias l='ls -CF'
alias llsize='ll -S'

alias tmux='tmux -2'
alias minicom='minicom -c on -w'
alias file-manager='pcmanfm &> /dev/null'

if [[ -x /usr/bin/ncal ]]; then
  alias cal='ncal -b'
fi

alias wget='wget -c'
alias ..='cd ..'
alias ..1='cd ..'
alias ..2='cd ../..'
alias ..3='cd ../../..'
alias ..4='cd ../../../..'
alias ..5='cd ../../../../..'
alias ..6='cd ../../../../../'
alias mkdir='mkdir -pv'
alias rm='echo "rm is disabled, use del or /bin/rm instead."'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send "Alert" "$(history | tail -n1 ; [ $? = 0 ] && echo OK || echo Error)" --icon=dialog-warning'

alias flutter='TERM=xterm-256color flutter'

if [ -f ~/.bash_aliases_work ]; then
  . ~/.bash_aliases_work
fi
