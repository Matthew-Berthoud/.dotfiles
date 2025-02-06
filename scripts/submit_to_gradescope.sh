#!/bin/bash

set -e

project="sget"
server="bg3"
project_folder="~/Distributed-System-Security/Projects/$project"
make_zip="cd $project_folder && make clean && zip -r $project.zip *"
rm_zip="cd $project_folder && rm $project.zip"

ssh "$server" "$make_zip"
scp "$server:$project_folder.zip" ~/Downloads/
ssh "$server" "$rm_zip"

