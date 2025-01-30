# zsh config path
ZSH_CONFIG=$HOME/config/zsh

if [[ -f "$HOME/.zsh_local" ]]; then
  source "$HOME/.zsh_local"
fi

if [[ -f "$HOME/.cargo/env" ]]; then
  source "$HOME/.cargo/env"
fi

DEVDIR="$HOME/develop"
DEVPATH="$DEVDIR/java/jdk/bin:$DEVDIR/flutter/bin:$DEVDIR/Android/Sdk/emulator:$DEVDIR/Android/Sdk/platform-tools:$DEVDIR/node/bin:/usr/local/go/bin:${GOPATH}/bin:${GOROOT}/bin"

if [[ ! -v PATH_EXPORTED_FROM_ZSHRC ]]; then
  export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$DEVPATH:$PATH
  export PATH_EXPORTED_FROM_ZSHRC=
fi

# ls colors
test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"

export WORDCHARS='_~*?'

# tip: use 'showkey -a' to display key code

# fix home/end keys
bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line

# fix ctrl-left/right arrows
bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word

# alt-f alt-b navigate words
bindkey "^[f" vi-forward-blank-word
bindkey "^[b" vi-backward-blank-word

# ctrl-h delete previous word
bindkey "^H" backward-kill-word

# ctrl-del delete next word
bindkey "^[[3;5~" kill-word

# unbind ctrl-w
bindkey -r "^W"

# unbind control-s
bindkey -r "^S"

# use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# disable suspend signal
stty stop undef

# disable terminal beep
setopt no_beep

setopt histignorealldups sharehistory

# keep 10000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

# disable partial line mark '%'
PROMPT_EOL_MARK=

# enable extended glob
setopt EXTENDED_GLOB

# enable '#' comments
setopt interactivecomments

# completion system
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

unsetopt CDABLE_VARS

export MANPATH="/usr/local/man:$MANPATH"

# language
# export LANG=en_US.UTF-8

export EDITOR='ne'
export VISUAL=$EDITOR
export GIT_EDITOR=$EDITOR

# alias
source $ZSH_CONFIG/aliases.zsh

# fancy prompt
source $ZSH_CONFIG/powerline.zsh

# set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# enable fzf on tmux
export FZF_TMUX=1

# set fd as the default source for fzf
export FZF_DEFAULT_COMMAND='fd --type f'

# use 'most' as pager for man pages
export PAGER=most
