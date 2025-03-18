if [[ "$(uname)" == "Darwin" ]]; then

    # Annoying "zsh is the default shell now, switch to it" type warning
	export BASH_SILENCE_DEPRECATION_WARNING=1

    # Homebrew on path
    eval "$(/opt/homebrew/bin/brew shellenv)"

    # Go on path
    export PATH=$PATH:/usr/local/go/bin

fi

source ~/.bashrc
