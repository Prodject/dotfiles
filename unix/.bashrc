#!/usr/bin/env bash
# Initialization file for non-login, interactive shell
# Maintainer: Faris Chugthai

# Don't run if not interactive: {{{
case $- in
    *i*);;
    *) return 0;;
esac
# }}}

# History: {{{
# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=50000
# TODO: What are the units on either of these?
HISTFILESIZE=50000
#https://unix.stackexchange.com/a/174902
HISTTIMEFORMAT="%F %T: "
# Ignore all the damn cds, ls's its a waste to have pollute the history
HISTIGNORE='exit:ls:cd:history:ll:la:gs'
# }}}

# Shopt: {{{
# Be notified of asynchronous jobs completing in the background
set -o notify
# Append to the history file, don't overwrite it
shopt -s histappend
# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize
# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
if [[ $BASH_VERSINFO -gt 3 ]]; then
    shopt -s globstar
fi

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

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob
set -o noclobber        # Still dont want to clobber things
shopt -s xpg_echo       # Allows echo to read backslashes like \n and \t
shopt -s dirspell       # Autocorrect the spelling if it can
shopt -s cdspell
# }}}

# Defaults in Ubuntu bashrcs: {{{
# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
# TODO: add rxvt case
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac
# }}}

# Prompt: {{{
# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.
    color_prompt=yes
    else
    color_prompt=
    fi
fi

# https://www.unix.com/shell-programming-and-scripting/207507-changing-ps1.html
# at some point you moved the \$\ back one [] on termux so i guess todo
if [ "$color_prompt" = yes ]; then
    TMP_PS1="\[\033[0;31m\]\342\224\214\342\224\200\$([[ \$? != 0 ]] && echo \"[\[\033[0;31m\]\342\234\227\[\033[0;37m\]]\342\224\200\")[$(if [[ ${EUID} == 0 ]]; then echo '\[\033[01;31m\]root\[\033[01;33m\]@\[\033[01;96m\]\h'; else echo '\[\033[0;39m\]\u\[\033[01;33m\]@\[\033[01;96m\]\h'; fi)\[\033[0;31m\]]\342\224\200[\[\033[0;32m\]\w\[\033[0;31m\]]\n\[\033[0;31m\]\342\224\224\342\224\200\342\224\200\342\225\274 \[\033[0m\]\\$\[\e[01;33m\]\[\e[0m\] "
else
    TMP_PS1='┌──[\u@\h]─[\w]\n└──╼ \$ '
fi

if [[ -f "$HOME/.bashrc.d/git-prompt.sh" ]]; then
    . "$HOME/.bashrc.d/git-prompt.sh";
    export GIT_PS1_SHOWDIRTYSTATE=1
    export GIT_PS1_SHOWCOLORHINTS=1
    export GIT_PS1_SHOWSTASHSTATE=1
    export GIT_PS1_SHOWUPSTREAM="auto"
    Color_Off="\[\033[0m\]"
    Yellow="\[\033[0;33m\]"
    PROMPT_COMMAND='__git_ps1 "${VIRTUAL_ENV:+[$Yellow`basename $VIRTUAL_ENV`$Color_Off]}" "$TMP_PS1" "[%s]"'
fi

# Set 'man' colors. TODO: Also set this up for less.
if [ "$color_prompt" = yes ]; then
    man() {
    env \
    LESS_TERMCAP_mb=$'\e[01;31m' \
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    man "$@"
    }
fi

unset color_prompt force_color_prompt
# }}}

# Vim: {{{
set -o vi
if [[ "$(command -v nvim)" ]]; then
    export VISUAL="nvim"
else
    export VISUAL="vim"
fi
export EDITOR="$VISUAL"
# }}}

# JavaScript: {{{
# Source npm completion if its installed
if [[ $(which npm) ]]; then
    source ~/.bashrc.d/npm-completion.bash
fi

# Export nvm if the directory exists
if [ -d "$HOME/.nvm" ]; then
    export NVM_DIR="$HOME/.nvm"
    # Load nvm and bash completion
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
fi
# }}}

# FZF: {{{
# Remember to keep this below set -o vi or else FZF won't inherit vim keybindings!
if [[ -f ~/.fzf.bash ]]; then
    . "$HOME/.fzf.bash"
fi

# spice fzf up with silversearcher
if [[ "$(command -v ag)" ]]; then
    export FZF_DEFAULT_COMMAND='ag  --hidden --smart-case --max-count 5 -g --'
    export FZF_DEFAULT_OPTS='--preview="cat {}" --preview-window=right:50%:wrap --cycle '
# edit your selected file in fzf with C-e. proba ly wrong syntax
# --bind -x "\C-e": nvim $(fzf);"

fi
# }}}

# Python: {{{
if [[ -d "$HOME/miniconda3/bin/" ]]; then
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
    __conda_setup="$('$HOME/miniconda3/bin/conda' shell.bash hook 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
            . "$HOME/miniconda3/etc/profile.d/conda.sh"
        else
            export PATH="$HOME/miniconda3/bin:$PATH"
        fi
    fi
    unset __conda_setup
    # <<< conda initialize <<<
fi

# If this env var isn't set it will equal 0. So also run a check that we have conda
if [[ $CONDA_SHLVL -eq 0 ]]; then
    if [[ -d "$HOME/miniconda3/etc/profile.d" ]]; then
        . "$HOME/miniconda3/etc/profile.d/conda.sh"
        conda activate base
    fi
elif [[ $CONDA_SHLVL -eq 1 ]]; then
    echo -e "Conda base environment successfully activated."
fi

# https://pip.pypa.io/en/stable/user_guide/#command-completion
eval "$(pip completion --bash)"
# }}}

# gcloud: {{{
# The next line updates PATH for the Google Cloud SDK.
if [[ -f ~/bin/google-cloud-sdk/path.bash.inc ]]; then source ~/bin/google-cloud-sdk/path.bash.inc; fi
# The next line enables shell command completion for gcloud.
if [[ -f ~/bin/google-cloud-sdk/completion.bash.inc ]]; then source ~/bin/google-cloud-sdk/completion.bash.inc; fi

if [[ -f "$PREFIX/google-cloud-sdk/path.bash.inc" ]]; then source "$PREFIX/google-cloud-sdk/path.bash.inc"; fi

if [ -f "$PREFIX/google-cloud-sdk/completion.bash.inc" ]; then source "$PREFIX/google-cloud-sdk/completion.bash.inc"; fi
# }}}

# Ruby: {{{
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
if [[ -d "$HOME/.rvm/bin" ]]; then
    export PATH="$PATH:$HOME/.rvm/bin"
fi
# }}}

# Sourced files: {{{
for config in ~/.bashrc.d/*.bash; do
    source "$config"
done
unset -v config

# For the secrets
if [[ -f "$HOME/.bashrc.local" ]]; then
    . "$HOME/.bashrc.local"
fi
# }}}
