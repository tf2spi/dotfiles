# dotfiles
**Are You Tired of Debugging Your Configurations?**

**Have to Deal With Yet Another Trash Embedded System That Can't Handle Your Config?**

**Do Your Coworkers Hate You for Installing UINT_MAX Plugins on Their Computer?**

Worry not because my dotfiles have come to the rescue

dotfiles so simple, they fit on a page

## .exrc
```
set autoindent
set ignorecase
set number
set showmatch
set showmode
set wrapscan
```

## .vimrc
```
source ~/.exrc
```

## .tmux.conf
```
# I may or may not have protanopia so this makes the contrast higher while still looking green to me
set -g window-style bg=#000000,fg=#60e000
set -g status-style bg=#000000,fg=#60e000
set -g mouse on
set -g mode-keys vi
```

## .gdbinit
```
# I don't mind auto-load, surprisingly enough.
# If I start debugging, I've probably executed build scripts
# and/or intend to run the program itself locally anyways.
set auto-load safe-path /
set history save on
define hook-quit
save breakpoints .breakpoints
end
```

## .bashrc or similar
```
export PATH="$HOME/.local/bin:$PATH"
export LD_LIBRARY_PATH="$HOME/.local/lib:$LD_LIBRARY_PATH"

# This is equivalent to 'auto-load' but with '.breakpoints'
# Remove this as well if you don't like 'auto-load'
alias gdb="gdb-posix -ex 'source .breakpoints'"

# Debian comes with Wayland so this is what I use
# If you use X, then xclip is what you're looking for
alias tmux-copy="tmux show-buffer | wl-copy"
alias tmux-paste="wl-paste"
```

## gdb-posix
```
#!/bin/sh
# Producing coredumps on segfaults is usually what I want by default
if [ ! -f .breakpoints ] ; then echo '
catch signal SIGSEGV
commands
gcore core.latest
end
' >.breakpoints ; fi
gdb -ex 'source .breakpoints' "$@"
```

## .ssh config
```
Host github.com
	User git
	Hostname github.com
	PreferredAuthentications publickey
	IdentityFile ~/.ssh/id_file
```

## .gitignore

```
# Files produced by .gdbinit and friends
.breakpoints
.gdb_history
core*

# Scripts I use in git repos to automate certain niceties
*.i.sh
*.i.bat
*.i.mak

# Ruby version commit should be explicit with '-f'
.ruby-version

# Common executable formats I forget sometimes
*.so
*.dll
*.dylib
*.exe
*.bin
*.elf
*.out
```

## pre-commit
```
# Default pre-commit hook script by git
if git rev-parse --verify HEAD >/dev/null 2>&1
then
	against=HEAD
else
	against=$(git hash-object -t tree /dev/null)
fi
allownonascii=$(git config --type=bool hooks.allownonascii)
exec 1>&2
if [ "$allownonascii" != "true" ] &&
	test $(git diff --cached --name-only --diff-filter=A -z $against |
	  LC_ALL=C tr -d '[ -~]\0' | wc -c) != 0
then
	cat <<\EOF
Error: Attempt to add a non-ASCII file name.

This can cause problems if you want to work with people on other platforms.

To be portable it is advisable to rename the file.

If you know what you are doing you can disable this check using:

  git config hooks.allownonascii true
EOF
	exit 1
fi
exec git diff-index --check --cached $against --
```

## asvarsall.sh (Android Studio)
```sh
#!/bin/sh
if [ "$ANDROID_SDK_HOME" = "" ] ; then
	export ANDROID_SDK_HOME="$HOME"/Android/Sdk
fi
if [ "$ANDROID_NDK_HOME" = "" ] ; then
	cd "$ANDROID_SDK_HOME"/ndk
	export ANDROID_NDK_HOME="$PWD/$(ls -v | tr ' ' '\n' | head -1)"
	cd $OLDPWD
fi
PLATFORM_BIN="$ANDROID_SDK_HOME/platform-tools"
CMDLINE_BIN="$ANDROID_SDK_HOME/cmdline-tools/latest/bin"
LLVM_BIN="$(echo "$ANDROID_NDK_HOME"/toolchains/llvm/prebuilt/linux-*/bin)"
export PATH="$LLVM_BIN:$CMDLINE_BIN:$PLATFORM_BIN:$PATH"
"$SHELL"
```
