if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi
alias vim=/usr/local/bin/vim
alias vi=/usr/local/bin/vim

# MacPorts Installer addition on 2014-05-04_at_01:22:55: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH

# enable color support of ls and also add handy aliases
alias ls='ls -G'
alias ll='ls -alFG'
alias la='ls -AG'
alias l='ls -CFG'
GREP_OPTIONS="--color=always";export GREP_OPTIONS

# Add an "alert" alias for long running commands. Use like so:
# sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# MacPorts Installer addition on 2016-02-05_at_14:30:14: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"

# Ant
ANT_HOME=/usr/local/bin/apache-ant-1.9.6
PATH=$ANT_HOME/bin:$PATH

# MacPorts Installer addition on 2016-11-23_at_18:18:01: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.

