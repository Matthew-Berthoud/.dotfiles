#!/bin/bash

# Docker Dev, or ddev allows you to program in many languages without having them installed!

set -e

if [ -z "$1" ]; then
  echo "Usage: $0 <language>"
  exit 1
fi
lang=$1

base_path="$DOTFILES/docker-dev/base.Dockerfile"
if [ ! -f "$base_path" ]; then
  echo "Error: Dockerfile not found at $base_path"
  exit 1
fi

path="$DOTFILES/docker-dev/$lang.Dockerfile"
if [ ! -f "$path" ]; then
  echo "Error: Dockerfile not found at $path"
  exit 1
fi

tag="docker-dev-$lang"

docker build -f "$base_path" "$DOTFILES"
docker build -t "$tag" -f "$path" .
docker run -it --rm \
    --env CONTAINER_HOSTNAME="$lang-container" \
    -v ~/.ssh:/home/mwberthoud/.ssh \
    -v ~/repos:/repos \
    -v "$lang-go-folder":/go \
    -P \
    "$tag"

