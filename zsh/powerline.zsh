# Inspired by Oh-my-bash Agnoster theme
# see https://github.com/ohmybash/oh-my-bash/blob/master/themes/agnoster/agnoster.theme.sh
# ANSI colors: https://stackoverflow.com/questions/4842424/list-of-ansi-color-escape-sequences

# Enable substitution in the prompt
setopt prompt_subst

FG_DIR='%{$fg[blue]%}'
FG_GIT='%{\e[38;5;22m%}'
FG_GIT_DIRTY='%{$fg[magenta]%}'
BG_DIR='%{$bg[blue]%}'
BG_GIT='%{\e[48;5;22m%}'
BG_GIT_DIRTY='%{$bg[magenta]%}'

COLOR_STATUS_OK='%{\e[38;5;22m%}'
COLOR_STATUS_ERR='%{$fg[red]%}'

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
    local fg_color='%{$fg[white]%}'
    [[ -n $dirty ]] && bg_color=$BG_GIT_DIRTY
    echo -ne "${bg_color}${FG_DIR}${fg_color} ${vcs_info_msg_0_}${stash}${ahead}${behind}"
  fi
}

function prompt_end {
  local fg_color=$FG_DIR
  if [[ -n $vcs_info_msg_0_ ]]; then
    fg_color=$FG_GIT
    local dirty=$(git_status_dirty)
    [[ -n $dirty ]] && fg_color=${FG_GIT_DIRTY}
  fi
  echo -ne "%{$reset_color%}${fg_color}%{$reset_color%} "
}

function prompt_dir {
  echo -ne "%{$reset_color%}${BG_DIR}%~%{$reset_color%}"
}

function prompt_status {
  local fg_color=$COLOR_STATUS_OK
  [ $CMD_STATUS -ne 0 ] && fg_color=$COLOR_STATUS_ERR
  echo -ne "%{$reset_color%}${BG_DIR}${fg_color}%{$reset_color%}"
}

function build_prompt {
  echo -ne "$(prompt_status)$(prompt_dir)$(prompt_git)$(prompt_end)"
}

# enable vcs_info and style
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr '○'
zstyle ':vcs_info:*' stagedstr '●'
zstyle ':vcs_info:git:*' formats '%b %u%c'
zstyle ':vcs_info:git:*' actionformats '%b | %a%u%c'

autoload -U colors && colors

# runs before displaying the prompt
precmd () {
  CMD_STATUS=$?
  vcs_info
  PS1="$(build_prompt)"
}
