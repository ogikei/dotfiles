# export
export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

# starship
eval "$(starship init zsh)"

# exa
if [[ $(command -v exa) ]]; then
  alias e='exa --icons --git'
  alias l=e
  alias ls=e
  alias ea='exa -a --icons --git'
  alias la=ea
  alias ee='exa -aahl --icons --git'
  alias ll=ee
  alias et='exa -T -L 3 -a -I "node_modules|.git|.cache" --icons'
  alias lt=et
  alias eta='exa -T -a -I "node_modules|.git|.cache" --color=always --icons | less -r'
  alias lta=eta
  alias l='clear && ls'
fi

# zstyle
autoload -U compinit
compinit

zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
zstyle ':completion:*:default' menu select=1

stty -ixon

# history
zplug "zsh-users/zsh-history-substring-search"
function peco-select-history() {
  BUFFER=$(\history -n -r 1 | peco --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history
HISTFILE=~/.zsh_history_test
HISTSIZE=10000
SAVEHIST=10000
setopt auto_list
setopt auto_menu
setopt append_history
setopt share_history
setopt hist_ignore_all_dups


zplug "zsh-users/zsh-autosuggestions"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=250'

zplug "zsh-users/zsh-syntax-highlighting"

zplug load --verbose

# python
export PYENV_ROOT="$HOME/.anyenv/envs/pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# php
export PHPENV_ROOT="$HOME/.anyenv/envs/phpenv"
export PATH="$PHPENV_ROOT/bin:$PATH"
eval "$(phpenv init -)"
if command -v phpenv 1>/dev/null 2>&1; then
  eval "$(phpenv init -)"
fi

# go
export GOENV_ROOT="$HOME/.goenv"
export PATH="$GOENV_ROOT/bin:$PATH"
export GOPATH="$HOME/go"
eval "$(goenv init -)"
export PATH="$GOROOT/bin:$PATH"
export PATH="$PATH:$GOPATH/bin"
export GO111MODULE=on

# rust
export PATH="$HOME/.cargo/bin:$PATH"

# scala
export PATH="/usr/local/opt/scala@2.12/bin:$PATH"
