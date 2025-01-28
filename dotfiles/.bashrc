# ===================== ~/.bashrc Configuration =====================

# Exit early if the shell is not interactive
[[ $- != *i* ]] && return

# ===================== Aliases =====================
# Custom aliases to simplify common commands
alias ls='ls --color=auto'       # Add colors to 'ls' output for better readability
alias grep='grep --color=auto'   # Highlight matching patterns in 'grep' output

# ===================== Git Prompt =====================
# Enable native Git prompt for Bash if available
if [ -f /usr/share/git/git-prompt.sh ]; then
	. /usr/share/git/git-prompt.sh
fi

# ===================== Custom Prompt =====================
# Define a colorized Bash prompt with Git branch info
# - \u: Username
# - \h: Hostname
# - \W: Current working directory (basename only)
# - $(__git_ps1): Current Git branch (if inside a Git repository)
PS1='\u@\h \[\033[1;34m\]\W\[\033[0m\]$(__git_ps1 " (\[\033[1;33m\]%s\[\033[0m\])") \$ '

# ===================== Notes =====================
# - Customize the `PS1` variable as needed to include more/less information.
# - To test changes, you can run `source ~/.bashrc` or restart your terminal session.
# - Use `man bash` or `help prompt` for additional details on prompt customization.
