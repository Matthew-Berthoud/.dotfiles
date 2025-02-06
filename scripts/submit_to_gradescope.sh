#!/bin/bash

set -e

project="sget"
server="bg3"
project_folder="~/Distributed-System-Security/Projects/$project"
remote_command="cd $project_folder && make clean && zip -r $project.zip *"

ssh "$server" "$remote_command"
scp "$server:$project_folder.zip" ~/Downloads/

