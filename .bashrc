# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# when exit shell, check jobs
shopt -s checkjobs

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

set -o vi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# colorize man pages for better readability
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

# ---virtualenv---
export PATH=$PATH:$HOME/.local/bin
export WORKON_HOME=~/virtualenvs
export VIRTUALENVWRAPPER_PYTHON=$HOME/.local/pipx/venvs/virtualenvwrapper/bin/python3
source /usr/share/virtualenvwrapper/virtualenvwrapper_lazy.sh

# ---dotfiles---
PATH="$HOME/dotfiles/bin:$PATH"

# ---history---
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTFILESIZE=10000
export HISTSIZE=${HISTFILESIZE}

# Set the Bash history to show a timestamp for your command history
HISTTIMEFORMAT="%F %T "

HISTIGNORE="pwd:l:ls:ll:[bf]g:clear:exit:"

# ---.inputrc---
# enable option to expand & edit a command before running it by entering a [space]
bind Space:magic-space

# jj to normal mode
# bind '"jj":vi-movement-mode'

# display completions using different colors to indicate their file types
bind 'set colored-stats On'
# short the common prefix
# set completion-prefix-display-length 3
# Make Tab autocompletion case-insensitive (cd ~/dow<Tab> => cd ~/Downloads/).
bind 'set completion-ignore-case On'
# List all matches in case multiple possible completions are possible
bind 'set show-all-if-ambiguous on'
# Immediately add a trailing slash when autocompleting symlinks to directories
bind 'set mark-symlinked-directories on'
# Be more intelligent when autocompleting by also looking at the text after
# the cursor. For example, when the current line is "cd ~/src/mozil", and
# the cursor is on the "z", pressing Tab will not autocomplete it to "cd
# ~/src/mozillail", but to "cd ~/src/mozilla". (This is supported by the
# Readline used by Bash 4.)
bind 'set skip-completed-text on'

# Neither sound a beep nor flash the screen when trying to ring the bell.
bind 'set bell-style none'

# ---completion---
# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
. "$HOME/.cargo/env"
