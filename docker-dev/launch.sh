#!/bin/bash

set -e

DOTFILES="${DOTFILES:-$HOME/.dotfiles}"
BASE_DOCKERFILE="$DOTFILES/docker-dev/base.Dockerfile"
LANG_DOCKERFILE="$DOTFILES/docker-dev/$1.Dockerfile"

if [ $# -eq 0 ] || [ ! -f "$LANG_DOCKERFILE" ]; then
    echo "Usage: $0 <language>"
    echo "Error: Dockerfile not found for the specified language"
    exit 1
fi

tag="docker-dev-$1"

docker build -t docker-dev-base -f "$BASE_DOCKERFILE" "$DOTFILES"
docker build -t "$tag" -f "$LANG_DOCKERFILE" .
docker run -it --rm \
    --env CONTAINER_HOSTNAME="$1-container" \
    -v "$HOME/.ssh:/home/mwberthoud/.ssh" \
    -v "$HOME/repos:/repos" \
    -v "$1-go-folder:/go" \
    -P \
    "$tag"

