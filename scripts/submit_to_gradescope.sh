#!/bin/bash

set -e

project="sget"
server="bg3"
project_folder="~/Distributed-System-Security/Projects/$project"
make_zip="cd $project_folder && make clean && zip -r $project.zip *"
rm_zip="cd $project_folder && rm $project.zip"
local_file="$HOME/Downloads/$project.zip"

ssh "$server" "$make_zip"
scp "$server:$project_folder/$project.zip" "$local_file"
ssh "$server" "$rm_zip"

