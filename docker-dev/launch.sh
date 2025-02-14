#!/bin/bash

# Docker Dev, or ddev allows you to program in many languages without having them installed!

set -e

DOTFILES="$HOME/.dotfiles"

if [ -z "$1" ]; then
  echo "Usage: $0 <language> <host port (optional)> <container port (optional)>"
  exit 1
fi

CONTAINER_PORT="3000"
HOST_PORT="3000"
if [ -n "$2" ]; then
  HOST_PORT=$2
fi
if [ -n "$3" ]; then
  CONTAINER_PORT=$3
fi

LANGUAGE=$1
DOCKERFILE_PATH="$DOTFILES/docker/$LANGUAGE.Dockerfile"

if [ ! -f "$DOCKERFILE_PATH" ]; then
  echo "Error: Dockerfile not found at $DOCKERFILE_PATH"
  exit 1
fi

IMAGE_NAME="$LANGUAGE-ddev"
docker build -t "$IMAGE_NAME" -f "$DOCKERFILE_PATH" .

# SSH keys are stored as a docker volume so I can access private repos from the dev container
docker run -it --rm \
    -v ~/.ssh/id_ed25519:/home/mwberthoud/.ssh/id_ed25519 \
    -v ~/.ssh/id_ed25519.pub:/home/mwberthoud/.ssh/id_ed25519.pub \
    -v "$IMAGE_NAME-known_hosts:/home/mwberthoud/.ssh/known_hosts" \
    -v "$IMAGE_NAME-workspace:/workspace" \
    -p "$HOST_PORT":"$CONTAINER_PORT"\
    "$IMAGE_NAME"

