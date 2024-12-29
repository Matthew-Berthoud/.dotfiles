# bash_profile runs on login, bashrc runs when shell opened
os_name=$(uname -s)

if [ "$os_name" = "Darwin" ]; then
# Mac
    # rust
    . "$HOME/.cargo/env"

    # brew
    eval "$(/opt/homebrew/bin/brew shellenv)"

    # Added by Toolbox App
    export PATH="$PATH:/Users/matthewberthoud/Library/Application Support/JetBrains/Toolbox/scripts"

    # remove warning about default shell being zsh
    export BASH_SILENCE_DEPRECATION_WARNING=1

else
# Linux
    export PATH="$PATH:/home/bren/Software/sim/misc/yas"
    export PATH="$PATH:/home/bren/Software/sim/misc/yis"
    export PATH="$PATH:/home/bren/Software/sim/misc"
    export PATH="$PATH:/home/bren/Software/sim/pipe"
    export PATH="$PATH:/home/bren/Software/sim/seq"
fi

# Run this on startup obviously
source ~/.bashrc
export PATH

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Ruby stuff for jekyll
source /opt/homebrew/opt/chruby/share/chruby/chruby.sh
source /opt/homebrew/opt/chruby/share/chruby/auto.sh
chruby ruby-3.3.5

[[ -f ~/.bashrc ]] && . ~/.bashrc # ghcup-env
# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/matthewberthoud/google-cloud-sdk/path.bash.inc' ]; then . '/Users/matthewberthoud/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/matthewberthoud/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/matthewberthoud/google-cloud-sdk/completion.bash.inc'; fi



# >>> coursier install directory >>>
export PATH="$PATH:/Users/matthewberthoud/Library/Application Support/Coursier/bin"
# <<< coursier install directory <<<

# Created by `pipx` on 2024-12-15 02:36:27
export PATH="$PATH:/Users/matthewberthoud/.local/bin"

. "/usr/local/env"
