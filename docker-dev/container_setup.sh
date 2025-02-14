#!/bin/bash

# For setting up docker development environments
# Agnostic of which language container it is

set -e

cd $HOME
mv .bashrc .default-bashrc
git config --global user.email "mwberthoud@wm.edu"
git config --global user.name "Matthew Berthoud"

cd $HOME/.dotfiles
source scripts/install.sh
git remote set-url origin git@github.com:Matthew-Berthoud/.dotfiles.git

