FROM docker-dev-base AS go-builder

ENV GO_VERSION=1.24.1
ENV GO111MODULE=on
ENV GOPATH=/go
ENV PATH=$PATH:/usr/local/go/bin:$GOPATH/bin

USER root
RUN wget https://golang.org/dl/go${GO_VERSION}.linux-amd64.tar.gz \
    && tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz \
    && rm go${GO_VERSION}.linux-amd64.tar.gz

USER mwberthoud
WORKDIR /repos
