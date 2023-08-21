FROM ubuntu:22.04

ENV RUNNER_VERSION=2.308.0

RUN useradd -m actions

RUN apt-get update && \
    apt-get -y install apt-transport-https \
    ca-certificates \
    curl \
    tar \
    jq \
    build-essential \
    gnupg2 \
    iputils-ping \
    software-properties-common

##
# DOCKER
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable" && \
    apt-get update && \
    apt-get -y install docker-ce

##
# NODEJS
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash - && \
    sudo apt-get install -y nodejs

##
# GITHUB ACTIONS RUNNER
RUN \
  LABEL="$(curl -s -X GET 'https://api.github.com/repos/actions/runner/releases/latest' | jq -r '.tag_name')" \
  RUNNER_VERSION="$(echo ${latest_version_label:1})" \
  cd /home/actions && mkdir actions-runner && cd actions-runner \
    && wget https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz \
    && tar xzf ./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz

WORKDIR /home/actions/actions-runner

RUN chown -R actions ~actions && \
    /home/actions/actions-runner/bin/installdependencies.sh

ENV RUNNER_ALLOW_RUNASROOT=1
USER actions

COPY entrypoint.sh .
ENTRYPOINT ["./entrypoint.sh"]
