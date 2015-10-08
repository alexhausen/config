# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='\t \[\e[01;32m\]\u@\h\[\e[00m\]:\[\e[01;34m\]\w \$\[\e[00m\] '
else
    PS1='\t \u@\h:\w \$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
#    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -lF --si'
alias la='ls -A'
alias l='ls -CF'
alias minicom='minicom -c on -w'
alias rdesktop_dektec='rdesktop ccd-7240.certi.org -u dektec -p dektec753 -g 1024x768 -T dektec'
alias rdesktop_cartola='rdesktop ccd-6071 -u CERTI\\cartola -p cartolafc2015 -g 1024x768 -T Cartola'
#alias bcaster='rdesktop -u bcaster -p bcaster753 ccd-5820.certi.org -g 1024x768 -T Bcaster'
#alias dektec_notebook='rdesktop -u dtv -p certidtv ccd-7834.certi.org -T notebook'
#alias dektec_simon='rdesktop -u dektec -p bolivar ccd-5717.certi.org -T simon'
#alias sifu='rdesktop -u instrument -p instrument rs_sfu.certi.org -T SFU'
alias mount_sshfs='sshfs -p 2245 CERTI\\alh@177.71.114.138:/home/likewise-open/CERTI/alh/Projects /home/alh/ProjectsRemote'
alias ssh_compile_server1='ssh -p 2245 -X alh@177.71.114.138'
alias ssh_compile_server2='ssh -p 2245 -X alh@177.71.114.147'
#alias ssh_intelbras_board='ssh -p 16022 root@192.168.250.82'
alias rdesktop_torio='rm -f ~/.rdesktop/licence.ccd-7835l; rdesktop -u CERTI\\alh -g 1360x740 -k pt-br torio.certi.org'
alias rdesktop_bcaster='rdesktop ccd-5820.certi.org -u bcaster -p bcaster753 -g 1024x768 -k pt-br -T Bcaster'
alias lock='xscreensaver-command -lock'
alias file-manager='pcmanfm &> /dev/null'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

EDITOR=ne
VISUAL=$EDITOR
export GIT_EDITOR=$EDITOR

export ANDROID_SDK=/opt/android_tools/android-sdk-linux
export ANDROID_HOME=$ANDROID_SDK
export PATH=${PATH}:${ANDROID_SDK}/tools:${ANDROID_SDK}/platform-tools

# Suppress warning about accessibility bus
# WARNING **: Couldn't connect to accessibility bus
export NO_AT_BRIDGE=1

# Wrong focus events with tiling window managers
export GDK_CORE_DEVICE_EVENTS=1

# Java
export AWT_TOOLKIT=MToolkit
export _JAVA_AWT_WM_NONREPARENTING=1
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=lcd -Dswing.aatext=true -Dsun.java2d.xrender=true'

# fuzzy finder: https://github.com/junegunn/fzf
[ -f ~/projects/config/fzf/_.fzf.bash ] && source ~/projects/config/fzf/_.fzf.bash
