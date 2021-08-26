FROM ubuntu:21.04

# Versions of software introduced in this image
ENV GIT_VERSION=2.30.2
ENV NVM_VERSION=0.38.0
ENV NODE_VERSION=16.6.2

# Environment variables (and aliases/synonyms) that identify Agent capabilities
ENV Git=$GIT_VERSION
ENV Node=$NODE_VERSION
ENV NodeJS=$Node
ENV Nvm=$NVM_VERSION
ENV NodeVersionManager=$Nvm

# Metadata
LABEL author="Jolyon Direnko-Smith"
LABEL description="An Ubuntu 21.04 image providing a base for self-hosted Azure DevOps build agents."
LABEL version=$AGENT_VERSION

# Set shell for RUN commands
SHELL ["/bin/bash", "--login", "-c"]

# To make it easier for build and release pipelines to run apt-get,
# configure apt to not require confirmation (assume the -y argument by default)
ENV DEBIAN_FRONTEND=noninteractive
RUN echo "APT::Get::Assume-Yes \"true\";" > /etc/apt/apt.conf.d/90assumeyes

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    jq \
    git=1:$GIT_VERSION-1ubuntu1 \
    iputils-ping \
    libcurl4 \
    libicu67 \
    libunwind8 \
    netcat \
    libssl1.1 \
  && rm -rf /var/lib/apt/lists/*


# Install nvm (Node Version Manager)
#
# We use this to install and use specific versions of node to avoid vulnerabilities introduced
# in the version used by the build agent by default.
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v$NVM_VERSION/install.sh | bash


# Install the desired version of Node
RUN source ~/.nvm/nvm.sh \
     && nvm install $NODE_VERSION


# Install Azure Cli
RUN curl -LsS https://aka.ms/InstallAzureCLIDeb | bash \
     && rm -rf /var/lib/apt/lists/*