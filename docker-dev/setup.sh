#!/bin/bash

# For setting up docker development environments
# Agnostic of which language container it is

cd $HOME

# Get rid of current bashrc so mine can come in with pretty colors!
mv .bashrc/.default-bashrc
mkdir .ssh && touch .ssh/known_hosts
git config --global user.email "mwberthoud@wm.edu"
git config --global user.name "Matthew Berthoud"

export SHELL="/bin/bash"
source .dotfiles/scripts/install.sh

