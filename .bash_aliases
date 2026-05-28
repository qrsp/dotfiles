alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias ..='cd ..'         # Go up one directory
alias ...='cd ../..'     # Go up two directories
alias ....='cd ../../..' # Go up three directories
alias -- -='cd -'        # Go back

# Tree
if [ ! -x "$(which tree 2>/dev/null)" ]
then
  alias tree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"
fi


# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Pomodoro
alias bs='sleep 3 && xset dpms force off'
alias pomodoro='sleep 1500 && zenity --info --text="Job finished" > /dev/null 2>&1'
alias p='pomodoro &'
alias pt='ps -C sleep -o etime'

alias rm='rm -I'
alias reload='source ~/.bashrc'
alias py='python3'
alias cb='~/calibre-bin/calibre/calibre &'
alias open='xdg-open'
alias noti='notify-send "done"'
alias sss='shutdown now'
alias analogh='pactl set-sink-volume alsa_output.pci-0000_00_1f.3.analog-stereo 0.02; sleep 0.1; pactl set-sink-port alsa_output.pci-0000_00_1f.3.analog-stereo analog-output-headphones'
alias analogl='pactl set-sink-port alsa_output.pci-0000_00_1f.3.analog-stereo analog-output-headphones; pactl set-sink-port alsa_output.pci-0000_00_1f.3.analog-stereo analog-output-lineout'
alias ffmpeginstall='sudo wget https://johnvansickle.com/ffmpeg/builds/ffmpeg-git-amd64-static.tar.xz &&\
    sudo tar -xvf ffmpeg-git-amd64-static.tar.xz -C /usr/local/bin --wildcards "*ffmpeg" "*ffprobe" --strip-components 1 &&\
    rm -v ffmpeg-git-amd64-static.tar.xz'
alias v='nvim'

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

