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

RUN git clone https://github.com/Matthew-Berthoud/.dotfiles.git
RUN bash .dotfiles/docker-dev/setup.sh

WORKDIR /workspace

CMD ["/bin/bash"]
