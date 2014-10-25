if [ -f /opt/local/etc/profile.d/bash_completion.sh ]; then
    . /opt/local/etc/profile.d/bash_completion.sh
fi

export PS1='\[\033[1;36m\][\u@\h\[\033[1;31m\]:\[\033[1;33m\]\w\[\033[1;36m\]]\[\033[1;31m\]$(__git_ps1) \n\[\033[1;35m\]m9(^0^) \[\033[1;32m\]$ '

if [ -f /usr/local/git/contrib/completion/git-prompt.sh ]; then
    . /usr/local/git/contrib/completion/git-prompt.sh
fi

JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.7.0_25.jdk/Contents/Home
export JAVA_HOME

PATH=${JAVA_HOME}/bin:$PATH 
export PATH

export PATH="/Applications/MAMP/bin/php/php5.4.10/bin:$PATH"

source /usr/local/git/contrib/completion/git-completion.bash
if which rbenv > /dev/null; then
    export RBENV_ROOT="${HOME}/.rbenv"
    export PATH=${RBENV_ROOT}/shims:${PATH}
    eval "$(rbenv init -)";
fi

# RVM
[ -s ${HOME}/.rvm/scripts/rvm ] && source ${HOME}/.rvm/scripts/rvm
