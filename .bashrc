export PATH="$HOME/.local/bin:$PATH"
export LD_LIBRARY_PATH="$HOME/.local/lib:$LD_LIBRARY_PATH"

# This is equivalent to 'auto-load' but with '.breakpoints'
# if you look at the script. Remove this as well if you
# don't like 'auto-load'
alias gdb="gdb-posix"

# Debian comes with Wayland so this is what I use
# If you use X, then xclip is what you're looking for
alias tmux-copy="tmux show-buffer | wl-copy"
alias tmux-paste="wl-paste"
