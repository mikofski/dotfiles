# BaSH RC (Run Commands) Configuration File

# VIRTUALENVWRAPPER VARIABLES
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Documents/Projects
export MSYS_HOME=$HOME/AppData/Local/Programs/Git/usr
source /c/Python27/Scripts/virtualenvwrapper.sh

# Mercurial
source $HOME/etc/mercurial/contrib/bash_completion

# ALIASES
alias ls='ls --classify --color'
alias la='ls -a'
alias ll='ls -l'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gl='git log --oneline -10'

# SSH-AGENT
source ssh-agent.sh
