# Aliases for a more functional bash environment
# Maintainer: Faris Chugthai

# Make navigation easier
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias cd..='cd ..'

# maybe this is obnoxious. idk.
alias cd...="cd ../.."
alias cd....="cd ../../.."
alias cd.....="cd ../../../.."
alias cd......="cd ../../../../.."

# some more ls aliases. pulled a few from ipython so not all were
# written by me. as a result let me quick go over the flags
# -A all except implied . and ..
# -c sort by ctime.
# -F classifies. indicators for symlinks and dirs are provided
# -o is similar to -l but don't print group
# -p means append / indicator to directoreis
# ngl the greps still don't make sense to me. dir file, link, executable but how?
alias l='ls -F'
alias la='ls -AF'
alias ldir='ls -po | grep /$'
alias lf='ls -Fo | grep ^-'
alias lk='ls -Fo | grep ^l'
alias ll='ls -AlF'
alias ls='ls -F'
alias lt='ls -Altcr'
alias lx='ls -Fo | grep ^-..x'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# lets not clobber other files as we go. bash's namespace? clobber everything
alias cp='cp -iv'
alias mv='mv -iv'
alias mkdir='mkdir -pv'
alias rmdir='rmdir -pv'
alias rm='rm -v'

# Print each PATH entry on a separate line
alias path='echo -e ${PATH//:/\\n}'

# Options i use every time i run these commands
alias du='du -d 1 -h'
alias df='df -ah --total'
alias free='free -mt'
alias echo='echo -e'
alias head='head -n 30'
alias tail='tail -n 30'

# Termux command with odd default of view not send
alias termux-share="termux-share -a send"
# termux-open gets an option for a default file handler! Dropbox integration
alias termux-open="termux-open --send"

alias info="info --vi-keys"

# Git aliases. for complicated git log calls funcs are better
alias ga='git add'
alias gb='git blame'
alias gcl='git clone'
alias gcls='git clone --depth 1'
alias gch='git checkout'
alias gco='git commit'
alias gd='git diff'
alias gds='git diff --staged'
alias gdt='git difftool'
alias glo='git log'
alias gls='git ls-tree'
alias gs='git status'
alias gst='git diff --stat'
# Not gonna lie I really don't like the inconsistency of gst.
# But is gds2 too much?? Like at what point are the alias more complicated than just running the command?

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls -F --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# I'll give you a second shot at it kid
alias redo='fc -s'
# And even a few ways to do it if you want
alias r='fc -s'
# wait could we do C-r like in vim?
