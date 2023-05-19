#!/usr/bin/env sh

echo " _     _                    _____             _ _       _    ";
echo "| |   (_)                  /  __ \           (_) |     | |   ";
echo "| |    _ _ __  _   ___  __ | /  \/ ___  _ __  _| | ___ | |_  ";
echo "| |   | | '_ \| | | \ \/ / | |    / _ \| '_ \| | |/ _ \| __| ";
echo "| |___| | | | | |_| |>  <  | \__/\ (_) | |_) | | | (_) | |_  ";
echo "\_____/_|_| |_|\__,_/_/\_\  \____/\___/| .__/|_|_|\___/ \__| ";
echo "                                       | |                   ";
echo "                                       |_|                   ";

echo -e "Leandro Roser, 2023\n\n"

if [ -n "$ZSH_VERSION" ]; then
    zsh -c '. base.sh'
elif [ -n "$BASH_VERSION" ]; then
    bash -c '. base.sh'
else
    echo "Unsupported default shell." >&2
    exit 1
fi