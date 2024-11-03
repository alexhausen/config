# Inspired by Oh-my-bash Agnoster theme
# see https://github.com/ohmybash/oh-my-bash/blob/master/themes/agnoster/agnoster.theme.sh

# Enable substitution in the prompt
setopt prompt_subst

#https://stackoverflow.com/questions/4842424/list-of-ansi-color-escape-sequences
BG_BLACK='\001\e[40m\002'
BG_GREEN='\001\e[42m\002'
BG_YELLOW='\001\e[43m\002'
BG_LG_BLUE='\001\e[48;5;33m\002'

FG_BLACK='\001\e[30m\002'
FG_RED='\001\e[31m\002'
FG_GREEN='\001\e[32m\002'
FG_YELLOW='\001\e[33m\002'
FG_LG_BLUE='\001\e[38;5;33m\002'
FG_HI_PINK='\001\e[38;5;13m\002'
FG_HI_RED='\001\e[38;5;9m\002'
FG_HI_GREEN='\001\e[38;5;10m\002'

BG_GIT=$BG_GREEN
BG_GIT_DIRTY=$BG_YELLOW
BG_DIR=$BG_LG_BLUE

FG_GIT=$FG_GREEN
FG_GIT_DIRTY=$FG_YELLOW
FG_DIR=$FG_LG_BLUE

FG_STATUS_OK=$FG_GREEN
FG_STATUS_ERR=$FG_RED

FG_COLOR=$FG_BLACK

RESET='\001\e[0m\002'

function git_status_dirty {
  local dirty=$(command git status -s 2> /dev/null | tail -n 1)
  [[ -n $dirty ]] && echo "dirty"
}

function git_stash {
  local stash=$(command git stash list 2> /dev/null | tail -n 1)
  [[ -n $stash ]] && echo "□"
}

function git_ahead {
  # Your branch is ahead of 'origin/branch' by n commits.
  local ahead=$(git status -sb --ahead-behind --porcelain 2> /dev/null | tail -n 1 | sed -nE 's/.*(ahead ([0-9]+)).*/\2/p')
  [[ -n $ahead ]] && echo "↑"
}

function git_behind {
  # Your branch is behind of 'origin/branch' by n commits.
  local behind=$(git status -sb --ahead-behind --porcelain 2> /dev/null | tail -n 1 | sed -nE 's/.*(behind ([0-9]+)).*/\2/p')
  [[ -n $behind ]] && echo "↓"
}

function prompt_git {
  if [[ -n $vcs_info_msg_0_ ]]; then
    local dirty=$(git_status_dirty)
    local stash=$(git_stash)
    local ahead=$(git_ahead)
    local behind=$(git_behind)
    local bg_color=$BG_GIT
    local fg_transition=$FG_DIR
    [[ -n $dirty ]] && bg_color=$BG_GIT_DIRTY
    echo -ne "${bg_color}${fg_transition}${FG_COLOR} ${vcs_info_msg_0_}${stash}${ahead}${behind}"
  fi
}

function prompt_end {
  local fg_color=$FG_DIR
  if [[ -n $vcs_info_msg_0_ ]]; then
    fg_color=$FG_GIT
    local dirty=$(git_status_dirty)
    [[ -n $dirty ]] && fg_color=$FG_GIT_DIRTY || fg_color=$FG_GIT
  fi
  echo -ne "${RESET}${fg_color}${RESET}"
}

function prompt_dir {
  echo -ne "${RESET}${BG_DIR}${FG_COLOR}%~ ${RESET}"
}

function prompt_status {
  local fg_color=$FG_STATUS_OK
  [ $CMD_STATUS -ne 0 ] && fg_color=${FG_STATUS_ERR}
  echo -ne "${RESET}${BG_DIR}${fg_color} ${RESET}"
}

function build_prompt {
  echo -ne "$(prompt_status)$(prompt_dir)$(prompt_git)$(prompt_end) "
}

# enable vcs_info and style
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr '○'
zstyle ':vcs_info:*' stagedstr '●'
zstyle ':vcs_info:git:*' formats '%b %u%c'
zstyle ':vcs_info:git:*' actionformats '%b | %a%u%c'

# runs before displaying the prompt
precmd () {
  CMD_STATUS=$?
  vcs_info
  PS1="$(build_prompt)"
}
