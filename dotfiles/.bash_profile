# ===================== ~/.bash_profile Configuration =====================

# Source ~/.bashrc if it exists
# - Ensures that all configurations and aliases from .bashrc are loaded.
# - This allows you to maintain configurations in one file for convenience.
[[ -f ~/.bashrc ]] && . ~/.bashrc

# ===================== Notes =====================
# - The `.bash_profile` is executed for login shells, whereas `.bashrc` is executed for interactive non-login shells.
# - By sourcing `.bashrc` here, you unify the configuration across both login and non-login sessions.
# - To test changes, log out and log back in, or restart your terminal.
