#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'

# Native git prompt for bash
if [ -f /usr/share/git/git-prompt.sh ]; then
	. /usr/share/git/git-prompt.sh
fi

# Colorized prompt
PS1='\u@\h \[\033[1;34m\]\W\[\033[0m\]$(__git_ps1 " (\[\033[1;33m\]%s\[\033[0m\])") \$ '

