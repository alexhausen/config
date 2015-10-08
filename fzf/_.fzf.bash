# Setup fzf
# ---------
if [[ ! "$PATH" == */home/alh/Software/fzf/bin* ]]; then
  export PATH="$PATH:/home/alh/Software/fzf/bin"
fi

# Man path
# --------
if [[ ! "$MANPATH" == */home/alh/Software/fzf/man* && -d "/home/alh/Software/fzf/man" ]]; then
  export MANPATH="$MANPATH:/home/alh/Software/fzf/man"
fi

FZF_CONFIG=~/projects/config/fzf

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "$FZF_CONFIG/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "$FZF_CONFIG/key-bindings.bash"

