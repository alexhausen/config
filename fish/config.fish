if status is-interactive
  # Disable the greeting message
  set -g fish_greeting
end

# control-backspace
bind \b backward-kill-path-component

# control-delete
bind \e\[3\;5~ kill-word

# unbind alt-s
bind \es ''

# set your preferred editor
set -gx EDITOR ne

# set java font anti-alias
set -gx _JAVA_OPTIONS '-Dawt.useSystemAAFontSettings=lcd'

# Add custom paths
fish_add_path ~/bin
