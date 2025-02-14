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

RUN git clone https://github.com/Matthew-Berthoud/.dotfiles.git
RUN /bin/bash .dotfiles/docker-dev/container_setup.sh

WORKDIR /workspace

CMD ["/bin/bash"]
