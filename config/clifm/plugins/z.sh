#!/bin/sh

# CliFM plugin to cd via zoxide
# Dependencies: zoxide

# Written by Paul
# Lincese GPL3

if [ -n "$1" ] && { [ "$1" = "--help" ] || [ "$1" = "-h" ]; }; then
	name="${CLIFM_PLUGIN_NAME:-$(basename "$0")}"
	printf "Change directory via zoxide.\n"
	printf "Usage: %s dir\n" "$name"
	exit 0
fi

if ! type zoxide >/dev/null 2>&1; then
	printf "clifm: zoxide: Command not found\n" >&2
	exit 127
fi

printf "%s\n" "$(zoxide query $1)" > "$CLIFM_BUS"

exit 0
