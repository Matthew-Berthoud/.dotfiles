# bash_profile runs on login, bashrc runs when shell opened

# # >>> conda initialize >>>
# # !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/Users/matthewberthoud/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/Users/matthewberthoud/anaconda3/etc/profile.d/conda.sh" ]; then
#         . "/Users/matthewberthoud/anaconda3/etc/profile.d/conda.sh"
#     else
#         export PATH="/Users/matthewberthoud/anaconda3/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# # <<< conda initialize <<<


# rust
. "$HOME/.cargo/env"

# brew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Added by Toolbox App
export PATH="$PATH:/Users/matthewberthoud/Library/Application Support/JetBrains/Toolbox/scripts"

# remove warning about default shell being zsh
export BASH_SILENCE_DEPRECATION_WARNING=1

# Run this on startup obviously
source ~/.bashrc
