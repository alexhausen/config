# aliases

alias ls='ls --color=auto'
alias grep='grep --color=auto'

alias ll='ls -o --si'
alias la='ls -A'
alias l='ls -CF'
alias llsize='ll -S'

alias thunderbird='thunderbird &> /dev/null'

alias tmux='tmux -2'
alias clear='/usr/bin/clear;tmux clear-history'
alias minicom='minicom -c on -w'

alias rdesktop_cartola1="rdesktop ccd-6711.certi.org -d certi -u cartola -p ${CARTOLA_PASSWORD} -g 1024x768 -T Cartola1"
alias rdesktop_cartola2="rdesktop ccd-5717.certi.org -d certi -u cartola -p ${CARTOLA_PASSWORD} -g 1024x768 -T Cartola2"
alias rdesktop_torio='rm -f ~/.rdesktop/licence.ccd-7835l; rdesktop -u CERTI\\alh -g 1360x740 -k pt-br torio'

alias mount_sshfs1='sshfs -p 2245 alh@177.71.114.138:/home/likewise-open/CERTI/alh/Projects ~/Projects1'
alias mount_sshfs2='sshfs -p 2245 alh@177.71.114.147:/home/likewise-open/CERTI/alh/Projects ~/Projects2'
alias mount_sshfs3='sshfs -p 2245 alh@177.71.114.148:/home/alh/Projects ~/Projects3'
alias mount_sshfs='mount_sshfs1; mount_sshfs3'
alias server1='ssh -p 2245 -X alh@177.71.114.138'
alias server2='ssh -p 2245 -Y alh@177.71.114.147'
alias server3='ssh -p 2245 -Y alh@177.71.114.148'

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

alias beep='paplay /usr/share/sounds/ubuntu/stereo/phone-incoming-call.ogg'
