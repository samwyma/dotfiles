#!/bin/bash

# profiler
#zmodload zsh/zprof

# To remove warnings
unset SPACESHIP_PYENV_SYMBOL
unset SPACESHIP_PYENV_COLOR

if [ -f ~/.sh_tokens ]; then
    source ~/.sh_tokens
fi

source /opt/homebrew/opt/antidote/share/antidote/antidote.zsh
source ~/.sh_settings
source $HOME/.reformrc

if [ -f "/opt/homebrew/bin/brew" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

### plugin manager
antidote bundle <~/.zsh_plugins.txt >~/.zsh_plugins

### oh-my-zsh plugins dependencies / requirements
export ZSH_CACHE_DIR=~/.zsh/cache
mkdir -p $ZSH_CACHE_DIR
autoload -Uz compinit
compinit

### hooks
autoload -U add-zsh-hook
add-zsh-hook chpwd node-version

# ### gpg / yubikey
# export GPG_TTY="$(tty)"
# export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
# gpgconf --launch gpg-agent

source ~/.sh_aliases
source ~/.sh_functions
source ~/.zsh_plugins
# source ~/.sh_work

### key bindings
bindkey "${terminfo[khome]}" beginning-of-line
bindkey "${terminfo[kend]}" end-of-line
bindkey "${terminfo[kdch1]}" delete-char
bindkey -v
bindkey '^R' history-incremental-search-backward

### history
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory
setopt share_history
setopt incappendhistory

### python
if [ -x "$(command -v pyenv)" ]; then
    eval "$(pyenv init -)"
fi

### lazy loading completions
kubectl() {
    if ! type __start_kubectl >/dev/null 2>&1; then
        source <(command kubectl completion zsh)
    fi

    command kubectl "$@"
}

kops() {
    if ! type __start_kops >/dev/null 2>&1; then
        source <(command kops completion zsh)
    fi

    command kops "$@"
}

node-version() {
    if [ -f "$(pwd)/.node-version" ]; then
        fnm use
    fi
    if [ -f "$(pwd)/.nvmrc" ]; then
        fnm use
    fi
}

### node
if [ -x "$(command -v fnm)" ]; then
    eval "$(fnm env)"
    node-version
fi

spaceship_graphite_trunk() {
    trunk=$(gt trunk --no-interactive || echo "")
    if [ -z "$trunk" ]; then
        return
    fi
    if [[ "$trunk" == *"ERROR: "* ]]; then
        return
    fi
    branch=$(git rev-parse --abbrev-ref HEAD)
    if [ "$branch" = "$trunk" ]; then
        return
    fi
    spaceship::section::v4 \
        --color "#32a852" \
        --prefix "$SPACESHIP_SECTION_PREFIX" \
        --suffix "$SPACESHIP_PROMPT_DEFAULT_SUFFIX" \
        --symbol "$SPACESHIP_SECTION_SYMBOL" \
        "-> $trunk"
}

### spaceship
export SPACESHIP_PROMPT_ORDER=(
    user      # Username section
    host      # Hostname section
    dir       # Current directory section
    git       # Git section (git_branch + git_status)
    graphite_trunk
    node      # Node.js section
    python    # Pyenv section
    aws       # Amazon Web Services section
    exec_time # Execution time
    line_sep  # Line break
    exit_code # Exit code section
    char      # Prompt character
)



# Autosuggest
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

# prompt
export SPACESHIP_CHAR_SYMBOL="❯"
export SPACESHIP_CHAR_SUFFIX=" "
export SPACESHIP_PROMPT_PREFIXES_SHOW=false

# symbols
export SPACESHIP_NODE_SYMBOL="node:"
export SPACESHIP_PYTHON_SYMBOL="python:"
export SPACESHIP_AWS_SYMBOL="aws:"

# git
export SPACESHIP_GIT_PREFIX=""
export SPACESHIP_GIT_SYMBOL=""
export SPACESHIP_GIT_BRANCH_PREFIX=""
export SPACESHIP_GIT_STATUS_PREFIX="["
export SPACESHIP_GIT_STATUS_SUFFIX="]"

# colours
export SPACESHIP_GIT_BRANCH_COLOR="#424242"
export SPACESHIP_GIT_STATUS_COLOR="#424242"
export SPACESHIP_NODE_COLOR="#424242"
export SPACESHIP_RUBY_COLOR="#424242"
export SPACESHIP_PYTHON_COLOR="#424242"
export SPACESHIP_AWS_COLOR=red

# profiler
#zprof

# Ensure the terminal isn't fucked
set -o emacs

setopt shwordsplit

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/samuelwyma/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/samuelwyma/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/samuelwyma/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/samuelwyma/google-cloud-sdk/completion.zsh.inc'; fi
