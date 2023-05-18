#!/usr/bin/env sh

if [ -n "$ZSH_VERSION" ]; then
    zsh -c '. base.sh'
elif [ -n "$BASH_VERSION" ]; then
    bash -c '. base.sh'
else
    echo "Unsupported default shell." >&2
    exit 1
fi