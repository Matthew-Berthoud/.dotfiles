FROM golang:latest

RUN apt-get update && apt-get install -y \
    vim \
    screen \
    git \
    curl \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN useradd -ms /bin/bash mwberthoud
USER mwberthoud
WORKDIR /home/mwberthoud

ENV TERM=xterm-256color
ENV SHELL=/bin/bash
ENV GO111MODULE=on
ENV GOPATH=/go

RUN git clone https://github.com/Matthew-Berthoud/.dotfiles.git
RUN git config --global user.email "mwberthoud@wm.edu"
RUN git config --global user.name "Matthew Berthoud"

# Get rid of current bashrc so mine can come in with pretty colors!
RUN mv /home/mwberthoud/.bashrc /home/mwberthoud/.default-bashrc
RUN bash .dotfiles/scripts/install.sh
RUN mkdir .ssh
RUN touch .ssh/known_hosts

WORKDIR /workspace
