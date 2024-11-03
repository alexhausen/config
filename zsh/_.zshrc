# If you come from bash you might have to change your $PATH.
DEVDIR="$HOME/develop"
DEVPATH="$DEVDIR/java/jdk/bin:$DEVDIR/flutter/bin:$DEVDIR/Android/Sdk/emulator:$DEVDIR/Android/Sdk/platform-tools:$DEVDIR/node/bin:/usr/local/go/bin:${GOPATH}/bin:${GOROOT}/bin"
BASEPATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/snap/bin"
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$DEVPATH:$BASEPATH

if [[ -f "$HOME/.cargo/env" ]]; then
  source "$HOME/.cargo/env"
fi

# ls colors
test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"

# use emacs keybindings even if our EDITOR is set to vi
bindkey -e

setopt histignorealldups sharehistory

# Keep 10000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

unsetopt CDABLE_VARS

# Use modern completion system
# autoload -Uz compinit
# compinit

# zstyle ':completion:*' auto-description 'specify: %d'
# zstyle ':completion:*' completer _expand _complete _correct _approximate
# zstyle ':completion:*' format 'Completing %d'
# zstyle ':completion:*' group-name ''
# zstyle ':completion:*' menu select=2
# zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
# zstyle ':completion:*' list-colors ''
# zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
# zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
# zstyle ':completion:*' menu select=long
# zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
# zstyle ':completion:*' use-compctl false
# zstyle ':completion:*' verbose true
# zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
# zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# Would you like to use another custom folder than $ZSH
ZSH=$HOME/config/zsh

export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

export EDITOR='ne'
VISUAL=$EDITOR
export GIT_EDITOR=$EDITOR

# alias
source $ZSH/aliases.zsh

# PS1
source $ZSH/powerline.zsh

# set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# enable fzf on tmux
export FZF_TMUX=1

# set fd as the default source for fzf
export FZF_DEFAULT_COMMAND='fd --type f'

# use 'most' as pager for man pages
export PAGER=most
