#!/bin/bash

# For setting up docker development environments
# Agnostic of which language container it is

set -e

cd $HOME/.dotfiles
bash scripts/install.sh
git remote set-url origin git@github.com:Matthew-Berthoud/.dotfiles.git

git config --global user.email "mwberthoud@wm.edu"
git config --global user.name "Matthew Berthoud"


