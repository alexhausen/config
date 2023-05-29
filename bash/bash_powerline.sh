# Inspired by Oh-my-bash Agnoster theme
# see https://github.com/ohmybash/oh-my-bash/blob/master/themes/agnoster/agnoster.theme.sh

BG_BLACK='\001\e[40m\002'
BG_GREEN='\001\e[42m\002'
BG_YELLOW='\001\e[43m\002'
BG_BLUE='\001\e[48;5;33m\002'

FG_BLACK='\001\e[30m\002'
FG_GREEN='\001\e[32m\002'
FG_YELLOW='\001\e[33m\002'
FG_BLUE='\001\e[38;5;33m\002'

BG_GIT=$BG_GREEN
BG_GIT_DIRTY=$BG_YELLOW
BG_DIR=$BG_BLUE

FG_GIT=$FG_GREEN
FG_GIT_DIRTY=$FG_YELLOW
FG_DIR=$FG_BLUE

FG_COLOR=$FG_BLACK

RESET='\001\e[0m\002'

function prompt_dir {
    echo -ne "${RESET}${BG_DIR}${FG_COLOR}\w"
}

function git_ref {
  local ref=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
  [[ -n $ref ]] && echo $ref
}

function git_status_dirty {
  local dirty=$(command git status -s 2> /dev/null | tail -n 1)
  [[ -n $dirty ]] && echo "●"
}

function git_stash {
  local stash=$(command git stash list 2> /dev/null | tail -n 1)
  [[ -n $stash ]] && echo "⚑"
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
  local ref=$(git_ref)
  if [[ -n $ref ]]; then
    local dirty=$(git_status_dirty)
    local stash=$(git_stash)
    local ahead=$(git_ahead)
    local behind=$(git_behind)
    local bg_color=""
    local fg_transition=$FG_DIR
    [[ -n $dirty ]] && bg_color=$BG_GIT_DIRTY || bg_color=$BG_GIT
    echo -ne "${bg_color}${fg_transition}${FG_COLOR} ${ref} ${stash}${dirty}${ahead}${behind}"
  fi
}

function prompt_end {
  local fg_color=$FG_DIR
  local ref=$(git_ref)
  if [[ -n $ref ]]; then
    local dirty=$(git_status_dirty)
    [[ -n $dirty ]] && fg_color=$FG_GIT_DIRTY || fg_color=$FG_GIT
  fi
  echo -ne "${RESET}${fg_color}${RESET}"
}

PS1="$(prompt_dir) "$'$(prompt_git)$(prompt_end)'" "