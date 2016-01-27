# Setup fzf
# ---------
FZF_HOME=$HOME/Software/fzf

if [[ ! "$PATH" == *$HOME/Software/fzf/bin* ]]; then
  export PATH="$PATH:$FZF_HOME/bin"
fi

# Man path
# --------
if [[ ! "$MANPATH" == */$HOME/Software/fzf/man* && -d "$FZF_HOME/fzf/man" ]]; then
  export MANPATH="$MANPATH:$FZF_HOME/man"
fi

FZF_CONFIG=~/projects/config/fzf

# Auto-completion
# ---------------
#ERROR: -bash: _xspecs: bad array subscript
#[[ $- == *i* ]] && source "$FZF_CONFIG/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "$FZF_CONFIG/key-bindings.bash"

