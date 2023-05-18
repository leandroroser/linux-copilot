#!/usr/bin/env sh

if [ -n "$ZSH_VERSION" ]; then
    exec zsh -c ". base.sh && eval_loop"
elif [ -n "$BASH_VERSION" ]; then
    exec bash -c ". base.sh && eval_loop"
else
    echo "Unsupported default shell." >&2
    exit 1
fi