# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[[ -z "$PS1" ]] && return

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
shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[[ -x /usr/bin/lesspipe ]] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [[ -z "$debian_chroot" ]] && [[ -r /etc/debian_chroot ]]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

# don't set TERM on bashrc
# TERM='xterm-256color'

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
  *color)
    color_prompt=yes
    export COLORTERM=truecolor
    ;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
# force_color_prompt=yes

if [[ -n "$force_color_prompt" ]]; then
  if [[ -x /usr/bin/tput ]] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
  else
    color_prompt=
  fi
fi

if [[ "$color_prompt" = yes ]]; then
    PROMPT_THEME=${HOME}/config/bash/bash_powerline.sh
    [[ -f $PROMPT_THEME ]] && source $PROMPT_THEME
fi
unset color_prompt force_color_prompt

# show exit status on failure
test -n "$PROMPT_COMMAND" &&
  PROMPT_COMMAND="__prompt_command;$PROMPT_COMMAND" ||
  PROMPT_COMMAND="__prompt_command"

EMPTY_COMMAND=1
__prompt_command() {
    # see colors at examples/bash/fmt-colors.sh
    local exit_code="$?"
    if [[ $exit_code -ne 0 ]] && [[ $EMPTY_COMMAND -eq 0 ]]; then
      echo -e "\e[95mError code: $exit_code\e[0m"
    fi
    EMPTY_COMMAND=1
}

__on_command() {
  if [[ "$BASH_COMMAND" != __prompt_command ]]; then
    EMPTY_COMMAND=0
  fi
}

trap __on_command debug

# enable color support of ls
if [[ -x /usr/bin/dircolors ]]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [[ -f ~/.bash_aliases ]]; then
    source ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [[ -f /etc/bash_completion ]] && ! shopt -oq posix; then
    source /etc/bash_completion
fi

EDITOR=ne
VISUAL=$EDITOR
export GIT_EDITOR=$EDITOR

# Suppress warning about accessibility bus: "WARNING **: Couldn't connect to accessibility bus"
export NO_AT_BRIDGE=1

# Wrong focus events with tiling window managers
export GDK_CORE_DEVICE_EVENTS=1

# Calculator function
function calc () {
  bc <<< "scale=2; $*"
}

# fuzzy finder key bindings (fzf)
[ -f ~/.fzf.bash ] && FZF_KB=~/.fzf.bash || FZF_KB=/usr/share/doc/fzf/examples/key-bindings.bash
[[ -f $FZF_KB ]] && source $FZF_KB

# enable fzf on tmux
export FZF_TMUX=1

# set fd as the default source for fzf
export FZF_DEFAULT_COMMAND='fd --type f'

# use 'most' as pager for man pages
export PAGER=most

stty stop undef

if [[ ! -v PATH_EXPORTED_FROM_BASHRC ]]; then
  [[ -d "$HOME/bin" ]] && PATH="$HOME/bin:$PATH"
  [[ -d "$HOME/.local/bin" ]] && PATH="$HOME/.local/bin:$PATH"
  if [[ -d "$HOME/develop" ]]; then
      DEVDIR="$HOME/develop"
      PATH="$DEVDIR/java/jdk/bin:$DEVDIR/flutter/bin:$DEVDIR/Android/Sdk/emulator:$DEVDIR/Android/Sdk/platform-tools:$DEVDIR/node/bin:$PATH"
  fi
  if [[ -f "$HOME/.cargo/env" ]]; then
      source "$HOME/.cargo/env"
  fi
  export PATH_EXPORTED_FROM_BASHRC=
fi

if [[ -f ~/.bash_local ]]; then
  source ~/.bash_local
fi
