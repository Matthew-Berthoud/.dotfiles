FROM python:latest

RUN apt-get update && apt-get install -y \
    vim \
    screen \
    git \
    curl \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

ENV TERM=xterm-256color
ENV SHELL=/bin/bash

RUN useradd -ms /bin/bash mwberthoud
USER mwberthoud

WORKDIR /home/mwberthoud
RUN mv .bashrc .default-bashrc
RUN git clone https://github.com/Matthew-Berthoud/.dotfiles.git

WORKDIR /home/mwberthoud/.dotfiles
RUN bash scripts/install.sh
RUN git remote set-url origin git@github.com:Matthew-Berthoud/.dotfiles.git
RUN git config --global user.email "mwberthoud@wm.edu"
RUN git config --global user.name "Matthew Berthoud"

WORKDIR /workspace

CMD ["/bin/bash"]
