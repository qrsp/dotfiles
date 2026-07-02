# If not running interactively, don't do anything
if [[ ! -o interactive ]]; then
  return
fi

eval "$(starship init zsh)"

# 15.6 Parameters Used By The Shell
HISTFILE="$HOME/dotfiles/transfer/zsh/.zhistory"    # History filepath
HISTSIZE=10000                   # Maximum events for internal history
SAVEHIST=10000                   # Maximum events in history file
# The maximum size of the directory stack. This is useful with the AUTO_PUSHD option
DIRSTACKSIZE=10


# ---16 Options---

## 16.2.1 Changing Directories
setopt AUTOCD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS


## 16.2.2 Completion
# Complete from both ends of a word.
# setopt COMPLETE_IN_WORD
# When the current word has a glob pattern, do not insert all the words resulting from the expansion but generate matches as for completion and cycle through them like MENU_COMPLETE
setopt GLOB_COMPLETE
# Do not autoselect the first completion entry
# unsetopt MENU_COMPLETE
# make completion lists more densely packed
setopt LIST_PACKED

## 16.2.3 Expansion and Globbing
# Treat the ‘#’, ‘~’ and ‘^’ characters as part of patterns for filename generation
setopt EXTENDED_GLOB
# If numeric filenames are matched by a filename generation pattern, sort the filenames numerically rather than lexicographically.
setopt NUMERIC_GLOB_SORT


## 16.2.4 History
# Remove older command from the history if a duplicate is to be added.
setopt HIST_IGNORE_ALL_DUPS
# Remove command lines from the history list when the first character on the line is a space
setopt HIST_IGNORE_SPACE
# Share history between terminals in zsh
setopt SHARE_HISTORY


## 16.2.6 Input/Output
# Allow comments even in interactive shells
setopt INTERACTIVE_COMMENTS


## 16.2.7 Job Control
# Report the status of background jobs immediately, rather than waiting until just before printing a prompt
setopt NOTIFY


## 16.2.12 Zle
unsetopt beep


# ---18 Zsh Line Editor---

# Use `bindkey` find all keymap

# vim
bindkey -v
# Do history expansion on space.
bindkey -M viins ' ' magic-space
bindkey -M viins "jk" vi-cmd-mode
bindkey -M viins "kj" vi-cmd-mode
bindkey -M vicmd "Y" vi-yank-eol
bindkey -M vicmd "dd" kill-whole-line
# Fix ESC key delay in insert mode but broke arrow, home, end, etc keys.
# bindkey -rpM viins '^['

# Should be called before compinit.
# 22.7 The zsh/complist Module
zmodload zsh/complist

bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect '^h' accept-and-hold                # Hold
bindkey -M menuselect '^n' accept-and-infer-next-history  # Next
bindkey -M menuselect '^u' undo                           # Undo

# Fix backspace is not working in insert mode
bindkey "^?" backward-delete-char


# ---20 Completion System---

# Base on
# - https://github.com/sorin-ionescu/prezto/blob/master/modules/completion/init.zsh
# - https://github.com/Phantas0s/.dotfiles/blob/master/zsh/completion.zsh
# - https://github.com/wincent/wincent/blob/main/aspects/dotfiles/files/.zshrc

# Colorize completions using default `ls` colors.
zstyle ':completion:*:*:*:*:default' list-colors ${(s.:.)LS_COLORS}
# Completion lists that don’t fit on the screen can be scrolled, the value will be displayed after every screenful and the shell will prompt for a key press
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
# Use caching to make completion for commands such as dpkg and apt usable.
zstyle ':completion::complete:*' use-cache on

# Make completion:
# - Try exact (case-sensitive) match first.
# - Then fall back to case-insensitive.
# - Accept abbreviations after . or _ or - (ie. f.b -> foo.bar).
# - Substring complete (ie. bar -> foobar).
# zstyle ':completion:*' matcher-list '' '+m:{[:lower:]}={[:upper:]}' '+m:{[:upper:]}={[:lower:]}' '+m:{_-}={-_}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'm:{[:upper:]}={[:lower:]}' 'm:{_-}={-_}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Allow completion of ..<Tab> to ../ and beyond.
zstyle -e ':completion:*' special-dirs '[[ $PREFIX = (../)#(..) ]] && reply=(..)'

# Allow you to select in a menu
zstyle ':completion:*' menu select

# Group
# If the name given is the empty string the name of the tag for the matches will be used as the name of the group
zstyle ':completion:*' group-name ''

# Describe
zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
# zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'


## 20.4 Control Functions
# Default: zstyle ':completion:*' completer _complete _ignored
#   - _expand_alias: If the word the cursor is on is an alias, it is expanded and no other completers are called.
#   - _complete: This completer generates all possible completions in a context-sensitive manner, i.e. using `compdef` function
#   - _approximate: Correct error spell.
zstyle ':completion:*' completer _expand_alias _complete _approximate
# That this completer may be quite expensive and annoying, so just allow 1 error
zstyle ':completion:*:approximate:*' max-errors 1 numeric

# Kill
# zstyle ':completion:*:*:*:*:processes' command 'ps -u $LOGNAME -o pid,user,command -w'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,tty,%cpu,cmd'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;36=0=01'


## ---fzf-tab---
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# preview directory's content with exa when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'lsd -1 --color=always $realpath'
# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'
zstyle ':fzf-tab:*' fzf-flags '--exact'
zstyle ':fzf-tab:*' fzf-bindings 'backward-eof:abort'

FZF_TAB_GROUP_COLORS=(
    $'\033[94m' $'\033[32m' $'\033[33m' $'\033[35m' $'\033[31m' $'\033[36m' \
    $'\033[38;5;80m' $'\033[92m' \
    $'\033[38;5;214m' $'\033[38;5;165m' $'\033[38;5;124m' $'\033[38;5;120m'
)
zstyle ':fzf-tab:*' group-colors $FZF_TAB_GROUP_COLORS
autoload -Uz compinit
compinit


# ---Zle functions---
# https://github.com/zsh-users/zsh/tree/master/Functions/Zle

autoload -U select-quoted
zle -N select-quoted
for m in visual viopp; do
  for c in {a,i}{\',\",\`}; do
    bindkey -M $m $c select-quoted
  done
done

autoload -U select-bracketed
zle -N select-bracketed
  for m in visual viopp; do
    for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
    bindkey -M $m $c select-bracketed
  done
done

autoload -Uz surround
zle -N delete-surround surround
zle -N add-surround surround
zle -N change-surround surround
bindkey -a cs change-surround
bindkey -a ds delete-surround
bindkey -a ys add-surround
bindkey -M visual S add-surround


# ---Plugin---

## ---fzf-tab---
source /usr/share/doc/fzf/examples/key-bindings.zsh
source $ZDOTDIR/plugins/fzf-tab/fzf-tab.plugin.zsh

## ---autosuggestions---
# use COLOR_13 in color theme
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=13"
source $ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^ ' autosuggest-execute

## ---fast-syntax-highlighting---
source $ZDOTDIR/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

## ---zsh-system-clipboard---
source $ZDOTDIR/plugins/zsh-system-clipboard/zsh-system-clipboard.plugin.zsh
bindkey -M viins "^v" zsh-system-clipboard-vicmd-vi-put-after

## ---zsh-notify---
if [[ $DESKTOP_SESSION == 'awesome' ]]
then
  source $ZDOTDIR/plugins/zsh-notify/notify.plugin.zsh
  zstyle ':notify:*' activate-terminal yes
fi

## ---command_not_found---
source /etc/zsh_command_not_found

# ---tools---

## ---zoxide---
eval "$(zoxide init zsh)"

## ---virtualenvs---
source /usr/share/virtualenvwrapper/virtualenvwrapper_lazy.sh
alias wk='workon'


# ---alias---

# Ignoring aliases: \ls

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias -- -='cd -'

alias rm='rm -I'
alias ts='trash-put'
alias ip='ip -color=auto'
alias py='python3'
alias open='xdg-open'

# system
alias sus='sudo systemctl suspend'
# Show open ports
alias openports='netstat -nape --inet'

# Pomodoro
alias bs='sleep 3 && xset dpms force off'
alias pomodoro='sleep 1500 && zenity --info --text="Job finished" > /dev/null 2>&1'
alias p='(pomodoro) &; date +%H:%M:%S'
alias pt='ps -C sleep -o etime'

# vim
alias v='nvim'
alias vd='v $(fd --type f --hidden . ~/dotfiles | fzf -e)'
alias vrf='v $(l | shuf -n 1)'

# tools
alias l='lsd --classify --almost-all'
alias ll='lsd --long --classify --almost-all --date "+%Y-%m-%d %X"'
alias tree='lsd --tree'

alias lg='lazygit'

alias dragon='dragon --and-exit --all --on-top --verbose'

# ---help function---

# displays your ip address, as seen by the Internet
myip ()
{
  list=("http://myip.dnsomatic.com/" "http://checkip.dyndns.com/" "http://checkip.dyndns.org/")
  for url in ${list[*]}
  do
    res=$(curl -fs "${url}")
    if [ $? -eq 0 ];then
      break;
    fi
  done
  res=$(echo "$res" | grep -Eo '[0-9\.]+')
  echo -e "Your public IP is: $res"
}

mkcd () {
  mkdir -p -v $1
  cd $1
}

# disk usage per directory, in Mac OS X and Linux
usage ()
{
  if [ -n "$1" ]; then
    du -h --max-depth=1 "$1"
  else
    du -h --max-depth=1
  fi
}

source /usr/share/clifm/functions/cd_on_quit.sh

gh_downloader(){
  local repo="$1"
  local pattern="$2"
  local filename="$3"

  local download_url=`curl -s https://api.github.com/repos/$repo/releases/latest | jq -r --arg pattern "$pattern" '.assets[] | select(.name|match($pattern)) | .browser_download_url'`
  curl -L $download_url -o $filename
}

extract() {
	for archive in "$@"; do
		if [ -f "$archive" ]; then
			case $archive in
			*.tar.bz2) tar xvjf $archive ;;
			*.tar.gz) tar xvzf $archive ;;
			*.bz2) bunzip2 $archive ;;
			*.rar) rar x $archive ;;
			*.gz) gunzip $archive ;;
			*.tar) tar xvf $archive ;;
			*.tbz2) tar xvjf $archive ;;
			*.tgz) tar xvzf $archive ;;
			*.zip) unzip $archive ;;
			*.Z) uncompress $archive ;;
			*.7z) 7z x $archive ;;
			*) echo "don't know how to extract '$archive'..." ;;
			esac
		else
			echo "'$archive' is not a valid file!"
		fi
	done
}

screenshot() {
    local SAVE_DIR="$HOME/Pictures/Screenshots"
    mkdir -p "$SAVE_DIR"

    # Open the oldest file
    if [[ "$1" == "-o" || "$1" == "--open" ]]; then
        # Find the oldest .png file in the directory
        local OLDEST_FILE=$(find "$SAVE_DIR" -maxdepth 1 -name "*.png" -type f -printf '%T+ %p\n' 2>/dev/null | sort | head -n 1 | cut -d' ' -f2-)

        if [[ -n "$OLDEST_FILE" && -f "$OLDEST_FILE" ]]; then
            echo "Opening oldest screenshot: $OLDEST_FILE"
            xdg-open "$OLDEST_FILE" # Uses your system's default image viewer
        else
            echo "No screenshots found in $SAVE_DIR"
        fi
        return 0
    fi

    # Delete all PNG files
    if [[ "$1" == "-d" || "$1" == "--delete" ]]; then
        # Count PNG files first
        local FILE_COUNT=$(find "$SAVE_DIR" -maxdepth 1 -name "*.png" -type f | wc -l)

        if [ "$FILE_COUNT" -gt 0 ]; then
            rm -f "$SAVE_DIR"/*.png
            echo "Deleted $FILE_COUNT screenshot(s) from $SAVE_DIR"
        else
            echo "No PNG files found to delete in $SAVE_DIR"
        fi
        return 0
    fi

    # Infinite loop taking screenshots
    echo "Starting automated screenshot capture... (Press Ctrl+C to stop)"
    while true; do
        local TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
        local FILE_PATH="$SAVE_DIR/screenshot_$TIMESTAMP.png"

        flameshot full -r > "$FILE_PATH"
        echo "Screenshot saved: $FILE_PATH"

        sleep 2
    done
}

set_default_app() {
    # 1. Select a file in the current directory (including hidden files, excluding . and ..)
    local file
    file=$(find . -maxdepth 1 -type f -not -name '.*' -o -name '.*' | sed 's|^\./||' | fzf --header="Select a file to configure:")

    [ -z "$file" ] && echo "No file selected. Exiting." && return 1

    # Get the MIME type of the selected file
    local mime_type
    mime_type=$(xdg-mime query filetype "$file")
    echo "Selected file: $file (MIME type: $mime_type)"

    # 2. Select an installed application desktop file
    local desktop_file
    desktop_file=$(query_desktop_files | fzf --header="Select default application for $mime_type:")

    [ -z "$desktop_file" ] && echo "No application selected. Exiting." && return 1

    # 3. Set the default application using xdg-mime
    echo "Setting $desktop_file as default for $mime_type..."
    xdg-mime default "$desktop_file" "$mime_type"

    # Verification
    local new_default
    new_default=$(xdg-mime query default "$mime_type")
    echo "Success! New default for $mime_type is: $new_default"
}

# Helper function to find and clean up desktop file names
query_desktop_files() {
    # Common directories where .desktop files are stored
    local dirs=("/usr/share/applications" "$HOME/.local/share/applications")
    for dir in "${dirs[@]}"; do
        if [ -d "$dir" ]; then
            find "$dir" -name "*.desktop" -exec basename {} \;
        fi
    done | sort -u
}
