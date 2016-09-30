if [ -f /opt/local/etc/profile.d/bash_completion.sh ]; then
    . /opt/local/etc/profile.d/bash_completion.sh
fi

export PS1='\[\033[1;36m\][\u@\h\[\033[1;31m\]  \[\033[1;33m\]\w\[\033[1;36m\]]\[\033[1;31m\]$(__git_ps1) \n\[\033[1;35m\]☞ \[\033[1;32m\] '

if [ -f /Library/Developer/CommandLineTools/usr/share/git-core/git-prompt.sh ]; then
    . /Library/Developer/CommandLineTools/usr/share/git-core/git-prompt.sh
fi

PATH=${JAVA_HOME}/bin:$PATH
export PATH

export PATH="/Applications/MAMP/bin/php/php5.4.10/bin:$PATH"

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

source /Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash
if which rbenv > /dev/null; then
    export RBENV_ROOT="${HOME}/.rbenv"
    export PATH=${RBENV_ROOT}/shims:${PATH}
    eval "$(rbenv init -)";
fi

# RVM
[ -s ${HOME}/.rvm/scripts/rvm ] && source ${HOME}/.rvm/scripts/rvm

# ctrl + s
stty stop undef
stty start undef

# rbenv
export PATH="$HOME/.rbenv/shims:$PATH"
