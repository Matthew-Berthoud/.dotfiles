FROM docker-dev-base

USER root
RUN apt-get update && apt-get install -y \
    python3 \
    python-is-python3 \
    make \
    g++ \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

USER mwberthoud

