FROM python:latest

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

RUN git clone https://github.com/Matthew-Berthoud/.dotfiles.git

# Get rid of current bashrc so mine can come in with pretty colors!
RUN mv /home/mwberthoud/.bashrc /home/mwberthoud/.default-bashrc
RUN bash .dotfiles/scripts/install.sh

WORKDIR /workspace

CMD ["/bin/bash"]
