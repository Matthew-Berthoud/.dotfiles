FROM node:current-bullseye

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

RUN git clone https://github.com/Matthew-Berthoud/.dotfiles.git

# Get rid of current bashrc so mine can come in with pretty colors!
RUN mv .bashrc .default-bashrc
RUN bash .dotfiles/scripts/install.sh
RUN mkdir .ssh
RUN touch .ssh/known_hosts

WORKDIR .dotfiles
RUN git remote set-url origin git@github.com:Matthew-Berthoud/.dotfiles.git
RUN git config --global user.email "matthewberthoud@gmail.com"
RUN git config --global user.name "Matthew Berthoud"

WORKDIR /workspace

EXPOSE 5173

CMD ["/bin/bash"]
