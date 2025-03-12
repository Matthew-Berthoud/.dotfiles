FROM debian:latest AS docker-dev-base

RUN apt-get update && apt-get install -y \
    vim \
    screen \
    git \
    curl \
    wget \
    tar \
    unzip \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

ENV TERM=xterm-256color
ENV SHELL=/bin/bash

RUN git config --global user.email "matthewberthoud@gmail.com"
RUN git config --global user.name "Matthew Berthoud"

RUN useradd -m mwberthoud
USER mwberthoud

WORKDIR /home/mwberthoud
COPY . .dotfiles
RUN mv .bashrc .default-bashrc
RUN bash .dotfiles/scripts/install.sh
RUN mkdir .ssh
RUN touch .ssh/known_hosts

WORKDIR /repos

