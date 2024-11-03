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
