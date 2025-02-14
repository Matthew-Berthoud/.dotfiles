#!/bin/bash

# For setting up docker development environments
# Agnostic of which language container it is

set -e

mv /home/mwberthoud/.bashrc /home/mwberthoud/.default-bashrc
source $HOME/.dotfiles/scripts/install.sh

cd $HOME/.dotfiles
git remote set-url origin git@github.com:Matthew-Berthoud/.dotfiles.git

git config --global user.email "mwberthoud@wm.edu"
git config --global user.name "Matthew Berthoud"


