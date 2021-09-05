
FROM deltics/azdevops-buildagent:2.170.1

LABEL author="Jolyon Direnko-Smith"
LABEL description="Adds Docker binaries, dotnet sdk, GitVersion, GoLang, Helm, JDK, JFrog Cli, Maven"
LABEL version="1.0"

# Software versions installed
ENV DOCKER_VERSION=20.10.8
ENV DOTNET_VERSION=5.0
ENV GCC_VERSION=11
ENV GITVERSIONTOOL_VERSION=5.6.6
ENV GO_VERSION=1.16.7
ENV HELM_VERSION=3.6.3
ENV JFROGCLI_VERSION=2
ENV JDK_VERSION=11.0.12.7.1
ENV JRE_VERSION=${JDK_VERSION}
ENV MAVEN_VERSION=3.8.2

# Agent capabilities (and aliases)
ENV Docker=${DOCKER_VERSION}
ENV DotNet=${DOTNET_VERSION}
ENV DotNetSdk=${DOTNET_VERSION}
ENV DotNetCore=${DOTNET_VERSION}
ENV DotNetCoreSdk=${DOTNET_VERSION}
ENV DotNetFramework=${DOTNET_VERSION}
ENV DotNetFrameworkSdk=${DOTNET_VERSION}
ENV Gcc=${GCC_VERSION}
ENV GnuC=${GCC_VERSION}
ENV GitVersion=${GITVERSIONTOOL_VERSION}
ENV Go=${GO_VERSION}
ENV GoLang=${GO_VERSION}
ENV Helm=${HELM_VERSION}
ENV JFrogCli=${JFROGCLI_VERSION}
ENV Java=${JRE_VERSION}
ENV JavaRuntimeEnvironment=${JRE_VERSION}
ENV Jdk=${JDK_VERSION}
ENV Jre=${JRE_VERSION}
ENV Maven=${MAVEN_VERSION}
ENV Mvn=${MAVEN_VERSION}


# To make it easier for build and release pipelines to run apt-get,
# configure apt to not require confirmation (assume the -y argument by default)
ENV DEBIAN_FRONTEND=noninteractive
RUN echo "APT::Get::Assume-Yes \"true\";" > /etc/apt/apt.conf.d/90assumeyes

# Add Microsoft package signing key to trusted keys (to allow installation of .net sdk)
RUN curl -o packages-microsoft-prod.deb -L https://packages.microsoft.com/config/debian/10/packages-microsoft-prod.deb \
     && dpkg -i packages-microsoft-prod.deb \
     && rm packages-microsoft-prod.deb

# Install dotnet 5.0
RUN apt-get update && apt-get install -y --no-install-recommends \
    apt-transport-https \
    dotnet-sdk-$DOTNET_VERSION

# Add dotnet tools to path
ENV PATH=$PATH:~/.dotnet/tools


# Install GitVersion (using dotnet tool install)
RUN dotnet tool install --global --version $GITVERSIONTOOL_VERSION GitVersion.Tool


# Download Docker binaries
RUN curl -o docker.tgz -L https://download.docker.com/linux/static/stable/x86_64/docker-$DOCKER_VERSION.tgz \
     && tar -zxvf docker.tgz --directory /usr/local \
     && rm docker.tgz
ENV PATH=$PATH:/usr/local/docker


# Install GoLang
RUN curl -o go.tgz -L https://golang.org/dl/go$GO_VERSION.linux-amd64.tar.gz \
     && tar xzvf go.tgz --directory /usr/local \
     && rm go.tgz
ENV PATH=$PATH:/usr/local/go/bin


# Install Helm
RUN curl -o helm.tar.gz -LsS https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz \
    && tar -zxvf helm.tar.gz \
    && mv linux-amd64/helm /usr/local/bin/helm \
    && rm -f -R linux-amd64 \
    && rm helm.tar.gz


# Install JDK
RUN curl -o jdk.tar.gz -LO https://corretto.aws/downloads/resources/${JDK_VERSION}/amazon-corretto-${JDK_VERSION}-linux-x64.tar.gz \ 
     && tar -zxvf jdk.tar.gz \
     && mv amazon-corretto-${JDK_VERSION}-linux-x64 jdk \
     && mkdir /usr/local/bin/jdk \
     && mv jdk /usr/local/bin/jdk/11.0.12.7.1 \
     && rm jdk.tar.gz
ENV JAVA_HOME=/usr/local/bin/jdk/11.0.12.7.1


# Install JFrog Cli
RUN JFROGDIR=${Agent_ToolsDirectory}/_jfrog/current; \
     mkdir -p $JFROGDIR; \
     curl -fLsS https://getcli.jfrog.io | bash -s v2; \
     mv jfrog $JFROGDIR


# Install Maven
RUN curl -o maven.tar.gz -LO https://apache.inspire.net.nz/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz \
     && tar -zxvf maven.tar.gz \
     && mkdir /usr/local/maven \
     && mv apache-maven-${MAVEN_VERSION} /usr/local/maven/${MAVEN_VERSION} \
     && rm maven.tar.gz
ENV PATH=$PATH:/usr/local/maven/${MAVEN_VERSION}/bin


# Install gcc (and rename gcc-11 as gcc)
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc-$GCC_VERSION
RUN mv /usr/bin/gcc-11 /usr/bin/gcc
RUN gcc --version
