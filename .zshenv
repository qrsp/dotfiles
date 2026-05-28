# If not running interactively, don't do anything
# if [[ ! -o interactive ]]; then
#   return
# fi

# Skip the not really helping Ubuntu global compinit to speed up startup
# global compinit in /etc/zsh/zshrc
skip_global_compinit=1

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

export EDITOR="nvim"
export VISUAL="nvim"

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"


# ---
# colorize man pages
# ---
# https://unix.stackexchange.com/questions/108699/documentation-on-less-termcap-variables
# export LESS_TERMCAP_md=$(tput bold; tput setaf 214)
# export LESS_TERMCAP_me=$(tput sgr0)
# export LESS_TERMCAP_so=$(tput bold; tput setaf 39)
# export LESS_TERMCAP_se=$(tput sgr0)
# export LESS_TERMCAP_us=$(tput bold; tput setaf 148)
# export LESS_TERMCAP_ue=$(tput sgr0)

# colorize man pages by bat
export MANPAGER="sh -c 'col -bx | batcat -l man -p'"
export MANROFFOPT="-c"


# ---
# colorize man pages
export LS_COLORS="$(vivid generate one-dark)"


# ---
# ripgrep
# ---
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep.conf"


# ---
# fzf
# ---
export FZF_DEFAULT_COMMAND="fd --hidden"
export FZF_ALT_C_COMMAND="fd --type directory --hidden"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export FZF_DEFAULT_OPTS="--exact --height=100%"


# ---
# virtualenvs
# ---
export WORKON_HOME=$HOME/.virtualenvs

export PATH="$HOME/.cargo/bin:$HOME/.deno/bin:$PATH:/usr/sbin"
