FROM docker-dev-base

USER root
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash -
RUN apt-get update && apt-get install -y \
    nodejs \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

USER mwberthoud

EXPOSE 5173

