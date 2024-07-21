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

# Setting PATH for Python 3.12
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.12/bin:${PATH}"
export PATH
