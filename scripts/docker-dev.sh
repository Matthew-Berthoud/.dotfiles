#!/bin/bash

set -e

DOTFILES="$HOME/.dotfiles"

if [ -z "$1" ]; then
  echo "Usage: $0 <language>"
  exit 1
fi

LANGUAGE=$1
DOCKERFILE_PATH="$DOTFILES/docker-dev/$LANGUAGE/Dockerfile"

if [ ! -f "$DOCKERFILE_PATH" ]; then
  echo "Error: Dockerfile not found at $DOCKERFILE_PATH"
  exit 1
fi

IMAGE_NAME="dev-$LANGUAGE-env"
docker build -t "$IMAGE_NAME" -f "$DOCKERFILE_PATH" .

# SSH keys are stored as a docker volume so I can access private repos from the dev container
docker run -it --rm \
    -v ~/.ssh/id_ed25519:/home/mwberthoud/.ssh/id_ed25519 \
    -v ~/.ssh/id_ed25519.pub:/home/mwberthoud/.ssh/id_ed25519.pub \
    -v "$LANGUAGE-workspace:/workspace" \
    "$IMAGE_NAME"

