# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# Get git branch name of current directory
git_branch() {
  local _gb=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
  if [ ! -z "$_gb" ]; then
    echo " ${_gb}"
  fi
}

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth:erasedups

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=-1
HISTFILESIZE=-1

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

TERM='xterm-color'

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
  *color) color_prompt=yes;;
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

[ -f ~/.name ] && PSHOST=$(<~/.name) || PSHOST='\h'
if [ "$color_prompt" = yes ]; then
    #see examples/bash/fmt-colors.sh
    GREEN=$'\e[0;49;92m'
    BLUE=$'\e[0;49;94m'
    YELLOW=$'\e[0;49;93m'
    NONE=$'\e[00m'
    LAMBDA=$'\u3bb'
    PS1=$'\[${GREEN}\]\u@\h\[${NONE}\]:\[${BLUE}\]\w\[${NONE}\]\[${YELLOW}\]$(git_branch "(%s)") \[${NONE}\]${LAMBDA} '
else
    PS1='$? \u@\h:\w$ '
fi
unset color_prompt force_color_prompt

# enable color support of ls
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

if [ -f ~/.bash_special ]; then
    . ~/.bash_special
fi

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

# Suppress warning about accessibility bus: "WARNING **: Couldn't connect to accessibility bus"
export NO_AT_BRIDGE=1

# Wrong focus events with tiling window managers
export GDK_CORE_DEVICE_EVENTS=1

# Java
#export AWT_TOOLKIT=MToolkit
#export _JAVA_AWT_WM_NONREPARENTING=1
#export JAVA_OPTS='-XX:+IgnoreUnrecognizedVMOptions --add-modules java.se.ee'
#export JAVA_TOOL_OPTIONS='-Dawt.useSystemAAFontSettings=lcd -Dswing.aatext=true -Dsun.java2d.xrender=true'
#export CLASSPATH=.:~/path_to/file.jar

# Calculator function
function calc () {
  bc <<< "scale=2; $*"
}

# fuzzy finder: https://github.com/junegunn/fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# set fd as the default source for fzf
export FZF_DEFAULT_COMMAND='fd --type f'

# enable fzf on tmux
export FZF_TMUX=1

stty stop undef

# update DISPLAY when connected to a remote host via tmux
update_display() {
  GOOD_DISPLAY=$(netstat -an | /bin/grep 0\ [0-9,:,.]*:60..\  | awk '{print $4}' | tail -n 1)
  GOOD_DISPLAY=${GOOD_DISPLAY: -2}
  if [ "$GOOD_DISPLAY" != "" ]; then
    export DISPLAY=localhost:${GOOD_DISPLAY}.0
  fi
}

if [ ! -v PATH_EXPORTED_FROM_BASHRC ]; then
  if [ -d "$HOME/bin" ] ; then
      PATH="$HOME/bin:$PATH"
  fi
  if [ -d "$HOME/.local/bin" ] ; then
      PATH="$HOME/.local/bin:$PATH"
  fi
  if [ -d "$HOME/develop" ] ; then
      DEVDIR="$HOME/develop"
      PATH="$DEVDIR/java/jdk/bin:$DEVDIR/flutter/bin:$DEVDIR/Android/Sdk/emulator:$DEVDIR/Android/Sdk/platform-tools:$DEVDIR/node/bin:$PATH"
  fi
  if [ -f "$HOME/.cargo/env" ]; then
      source "$HOME/.cargo/env"
  fi
  export PATH_EXPORTED_FROM_BASHRC=
fi

# python virtualenv
#export WORKON_HOME=$HOME/.virtualenvs
#export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python
#source /usr/local/bin/virtualenvwrapper.sh

if [ -f ~/.bash_local ]; then
  . ~/.bash_local
fi
