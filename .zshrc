# CodeWhisperer pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.pre.zsh"
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#!/usr/bin/env bash

# mkdir -p ~/.fig/bin > /dev/null
# 
# pathadd() {
#   if [[ -d "$1" ]] && [[ ":$PATH:" != *":$1:"* ]]; then
#     PATH="${PATH:+"$PATH:"}$1"
#   fi
# }
# 
# pathadd ~/.fig/bin
# pathadd ~/.local/bin
# 
# if [[ -n "${FIG_NEW_SESSION}" ]]; then
#   unset FIGTERM_SESSION_ID
#   unset FIG_TERM
#   unset FIG_NEW_SESSION
# fi
# 
# if [[ -z "${FIG_SET_PARENT_CHECK}" ]]; then
#   # Load parent from env variables
#   if [[ "$FIG_SET_PARENT" = "" && "$LC_FIG_SET_PARENT" != "" ]]; then
#     export FIG_SET_PARENT=$LC_FIG_SET_PARENT
#     unset -v LC_FIG_SET_PARENT
#   fi
#   if [[ "$FIG_PARENT" = "" && "$FIG_SET_PARENT" != "" ]]; then
#     export FIG_PARENT=$FIG_SET_PARENT
#     unset -v FIG_SET_PARENT
#   fi
#   export FIG_SET_PARENT_CHECK=1
# fi
# 
# # 0 = Yes, 1 = No, 2 = Fallback to FIG_TERM
# fig _ should-figterm-launch 1>/dev/null 2>&1
# SHOULD_FIGTERM_LAUNCH=$?

# Only launch figterm if current session is not already inside PTY and command exists.
# PWSH var is set when launched by `pwsh -Login`, in which case we don't want to init.
# It is not necessary in Fish.
# if   [[ ! "${TERM_PROGRAM}" = WarpTerminal ]] \
#   && [[ -z "${__PWSH_LOGIN_CHECKED}" ]] \
#   && [[ -z "${INSIDE_EMACS}" ]] \
#   && [[ "${__CFBundleIdentifier:=}" != "com.vandyke.SecureCRT" ]] \
#   && [[ -t 1 ]] \
#   && [[ -z "${PROCESS_LAUNCHED_BY_FIG}" ]] \
#   && [[ -z "${FIG_PTY}" ]] \
#   && command -v figterm 1>/dev/null 2>&1 \
#   && [[ ("${SHOULD_FIGTERM_LAUNCH}" -eq 0) || (("${SHOULD_FIGTERM_LAUNCH}" -eq 2) && (-z "${FIG_TERM}" || (-z "${FIG_TERM_TMUX}" && -n "${TMUX}"))) ]]
# then
#   # Pty module sets FIG_TERM or FIG_TERM_TMUX to avoid running twice.
#   FIG_SHELL=$(fig _ get-shell)
#   FIG_IS_LOGIN_SHELL="${FIG_IS_LOGIN_SHELL:='0'}"
# 
#   # shellcheck disable=SC2030
#   if ([[ -n "$BASH" ]] && shopt -q login_shell) \
#     || [[ -n "$ZSH_NAME" && -o login ]]; then
#     FIG_IS_LOGIN_SHELL=1
#   fi
# 
#   # Do not launch figterm in non-interactive shells (like VSCode Tasks)
#   if [[ $- == *i* ]]; then
#     FIG_TERM_NAME="$(basename "${FIG_SHELL}") (figterm)"
#     if [[ -x "${HOME}/.fig/bin/${FIG_TERM_NAME}" ]]; then
#       FIG_TERM_PATH="${HOME}/.fig/bin/${FIG_TERM_NAME}"
#     else
#       FIG_TERM_PATH="$(command -v figterm || echo "${HOME}/.fig/bin/figterm")"
#     fi
# 
#     FIG_EXECUTION_STRING="${BASH_EXECUTION_STRING:=$ZSH_EXECUTION_STRING}"
# 
#     # Get initial text.
#     INITIAL_TEXT=""
#     # shellcheck disable=SC2031
#     if [[ -z "${BASH}" || "${BASH_VERSINFO[0]}" -gt "3" ]]; then
#       while read -rt 0; do
#         if [[ -n "${BASH}" ]]; then
#           read -r
#         fi
#         INITIAL_TEXT="${INITIAL_TEXT}${REPLY}\n"
#       done
#     fi
#     FIG_EXECUTION_STRING="${FIG_EXECUTION_STRING}" FIG_START_TEXT="$(printf "%b" "${INITIAL_TEXT}")" FIG_SHELL="${FIG_SHELL}" FIG_IS_LOGIN_SHELL="${FIG_IS_LOGIN_SHELL}" exec -a "${FIG_TERM_NAME}" "${FIG_TERM_PATH}"
#   fi
# # else
# #   FIG_DID_NOT_EXEC_FIGTERM=1
# fi

## exa
# if [[ $(command -v exa) ]]; then
#   alias ll='exa --icons -la'
#   alias l='exa --icons -l'
#   alias ls='exa --icons -F'
# else
#   alias ll='ls -la'
#   alias l1='ls -1'
#   alias lt='tree -I "node_modules|.git|.cache|vendor|tmp"'
#   alias ltl='lt | less -r'
# fi

# zsh history
setopt hist_ignore_dups
setopt hist_save_no_dups
setopt hist_ignore_all_dups

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/ogiwarakeisuke/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/ogiwarakeisuke/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/ogiwarakeisuke/opt/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/ogiwarakeisuke/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export PATH=/opt/homebrew/bin:$PATH


[[ -f "$HOME/fig-export/dotfiles/dotfile.zsh" ]] && builtin source "$HOME/fig-export/dotfiles/dotfile.zsh"

# CodeWhisperer post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.post.zsh"

if [[ $__INTELLIJ_COMMAND_HISTFILE__ ]]; then
          ZSH_THEME="robbyrussell"
  else
            ZSH_THEME="powerlevel10k/powerlevel10k"
fi

alias la='ls -la'
source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme
