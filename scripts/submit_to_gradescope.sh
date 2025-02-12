#!/bin/bash

set -e

project="sget"
server="bg3"
project_folder="~/Distributed-System-Security/Projects/$project"

ssh "$server" "cd $project_folder && make clean && zip -r $project.zip *"
scp "$server:$project_folder/$project.zip" "$HOME/Downloads/$project.zip"
ssh "$server" "cd $project_folder && rm $project.zip"

