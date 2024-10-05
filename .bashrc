function gdb-posix () {
	# Producing coredumps on segfaults is usually what I want by default
	if [ ! -f .breakpoints ] ; then echo '
catch signal SIGSEGV
commands
gcore core.latest
end
' >.breakpoints ; fi
	gdb "$@"
}
export PATH="$HOME/.local/bin:$PATH"
export LD_LIBRARY_PATH="$HOME/.local/lib:$LD_LIBRARY_PATH"

# This is equivalent to 'auto-load' but with '.breakpoints'
# Remove this as well if you don't like 'auto-load'
alias gdb="gdb-posix -ex 'source .breakpoints'"

# Debian comes with Wayland so this is what I use
# If you use X, then xclip is what you're looking for
alias tmux-copy="tmux show-buffer | wl-copy"
alias tmux-paste="wl-paste"
