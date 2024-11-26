#!/bin/bash


# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# \e[x;ym : start color scheme, x = 0, y = 30-36
# \e[m : stop color scheme
# 0;36 : cyan
get_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
weekday() {
    date +%a
}
export PS1="\e[0;36m[\$(weekday) \t \u@\h:\w]\e[m\$(get_git_branch)\e[m\n$ "
export EDITOR=vim

alias s="source ~/.bashrc"
alias lt='ls -lrt'
alias ll='ls -al'
alias tf='tail -f'
alias gt='git status'
alias ga='git add'
alias gc='git commit -v'
alias gd='git diff'
alias gl='git log --oneline'
alias gb='git branch'
alias gl='git log'
alias pf='sudo perf stat -B -e cache-references,cache-misses,cycles,instructions,branches,branch-misses,page-faults,cpu-migrations,context-switches'
alias cmake_debug="cmake -DCMAKE_BUILD_TYPE=Debug"

if [ -e $HOME/functions.sh ]
then
    source $HOME/functions.sh
fi

# tail -f of the most recent file in the directory.
function ltf {
last_file=`ls -rt *.log | tail -n 1`
echo $ tail -f $last_file
tail -f $last_file
}
# <<< my settings <<<

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/jdlee/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/jdlee/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/jdlee/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/jdlee/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

