#!/bin/bash

# If not running interactively, don't do anything!
[[ $- != *i* ]] && return

# colours
if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
  PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
  PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi

# If this is an xterm set the title to user@host:dir
case "$TERM" in xterm*|rxvt*)
  PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
  ;;
*)
  ;;
esac

# bash prompt title
case ${TERM} in
  xterm*|rxvt*|Eterm|aterm|kterm|gnome*)
    PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/~}"'
  ;;
  screen)
    PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033_%s@%s:%s\033\\" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/~}"'
  ;;
esac

# history
export HISTSIZE=1000
export HISTFILESIZE=2000
export HISTCONTROL=ignoreboth
export HISTIGNORE='&:ls:[bf]g:exit'
export HISTTIMEFORMAT='%b %d %H:%M:%S: '
set cmdhist

# options
shopt -s cdspell                 # Correct cd typos
shopt -s checkwinsize            # Update windows size on command
shopt -s histappend              # Append History instead of overwriting file
shopt -s cmdhist         
shopt -s extglob                 # Extended pattern
shopt -s no_empty_cmd_completion # No empty completion

# bash completion
complete -cf sudo
[ -r /usr/share/bash-completion/bash_completion ] && source /usr/share/bash-completion/bash_completion

source "$HOME/.sh_aliases"
source "$HOME/.sh_functions"
source "$HOME/.sh_settings"

[ -r "$HOME/.homesick/repos/homeshick/homeshick.sh" ] && source "$HOME/.homesick/repos/homeshick/homeshick.sh"

# # ssh via gpg
# export GPG_TTY="$(tty)"
# export SSH_AUTH_SOCK="/run/user/$UID/gnupg/S.gpg-agent.ssh"
# gpg-connect-agent updatestartuptty /bye > /dev/null

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
