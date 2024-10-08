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

echo '    __               __   '
echo '   / /_  ____ ______/ /_  '
echo '  / __ \/ __ `/ ___/ __ \ '
echo ' / /_/ / /_/ (__  ) / / / '
echo '/_.___/\__,_/____/_/ /_/  '
