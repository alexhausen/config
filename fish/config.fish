if status is-interactive
  # Commands to run in interactive sessions can go here

  # Disable the greeting message
  set -g fish_greeting
end

# control-backspace
bind \b backward-kill-path-component

# control-delete
bind \e\[3\;5~ kill-word

# unbind alt-s
bind \es ''

# Set your preferred editor
set -gx EDITOR ne

# Add custom paths
fish_add_path ~/bin
