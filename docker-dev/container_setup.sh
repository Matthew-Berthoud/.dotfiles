#!/bin/bash

# For setting up docker development environments
# Agnostic of which language container it is

cd $HOME

mv .bashrc/.default-bashrc
git config --global user.email "mwberthoud@wm.edu"
git config --global user.name "Matthew Berthoud"

source .dotfiles/scripts/install.sh

