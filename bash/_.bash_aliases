# aliases

alias ls='ls --color=auto'
alias grep='grep --color=auto'

alias ll='ls -o --si'
alias la='ls -A'
alias l='ls -CF'
alias llsize='ll -S'

alias tmux='tmux -2'
#alias file-manager='pcmanfm &> /dev/null'

command -v ncal > /dev/null && alias cal='ncal -b'
command -v bpytop > /dev/null && alias top='bpytop'


alias wget='wget -c'
alias ..='cd ..'
alias ..1='cd ..'
alias ..2='cd ../..'
alias ..3='cd ../../..'
alias ..4='cd ../../../..'
alias ..5='cd ../../../../..'
alias ..6='cd ../../../../../..'
alias mkdir='mkdir -pv'
alias rm='echo "rm is disabled, use del or /bin/rm instead."'
alias del='trash-put'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send "Alert" "$(history | tail -n1 ; [ $? = 0 ] && echo OK || echo Error)" --icon=dialog-warning'

alias flutter='TERM=xterm-256color flutter'
