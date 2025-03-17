FROM debian:latest AS docker-dev-base

RUN apt-get update && apt-get install -y \
    curl git make screen tar tmux unzip vim wget \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

ENV TERM=xterm-256color SHELL=/bin/bash

RUN useradd -m mwberthoud && \
    git config --global user.email "matthewberthoud@gmail.com" && \
    git config --global user.name "Matthew Berthoud"

USER mwberthoud
WORKDIR /home/mwberthoud

COPY . .dotfiles
RUN mv .bashrc .default-bashrc && \
    bash .dotfiles/scripts/install.sh && \
    mkdir .ssh && touch .ssh/known_hosts

WORKDIR /repos

