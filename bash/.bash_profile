# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin directories
export PATH="$HOME/bin:$HOME/.local/bin:$HOME/.npm-global/bin:$PATH"

# Include ./.aws/aws_profile if it exists
if [[ -f /home/rob/.aws/aws_profile ]]; then
    source /home/rob/.aws/aws_profile
fi
