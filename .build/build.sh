#!/bin/bash

function setENV() {
    sed -i '' "s/$2_VERSION=.*/$2_VERSION=$3/" ../$1
}

function updateREADME() {
    sed -i '' "s/| $2 | .* |\(.*\)/| $2 | $3 |\1/" ../$1
}

function doBuild() {
    local context="$1"
    local tag="$2"
    local dockerfile="$3"

    if [ -z "$context" ]; then 
        echo "A context (folder) must be specified"
        exit -1
    fi

    if [ -z "$tag" ]; then
        tag="$context"
        dockerfile="dockerfile"
    elif [ -z "$dockerfile" ]; then
        dockerfile="dockerfile.$tag"
    fi

    docker build -t deltics/azdevops-buildagent:$tag -f ../$context/$dockerfile ../$context
}

# Installed in the "os" layer
_git=2.34.1
_nvm=0.39.1
_node=16.11.1

# ENV defined in the "env" layer, but installed in n.nnn.n agent layers
_docker=20.10.18
_dotnet=6.0
_gcc=11
_gitversionTool=5.10.3
_go=1.19.1
_gojunit=0.9.1
_goswagger=0.30.3
_helm=3.10.0
_jfrogcli=2
_jdk=11.0.12.7.1
_kubectl=1.22.15
_maven=3.8.6

# Update dockerfile(s)
setENV  os/dockerfile  GIT   $_git
setENV  os/dockerfile  NVM   $_nvm
setENV  os/dockerfile  NODE  $_node

setENV  wakatipu/dockerfile  DOCKER          $_docker
setENV  wakatipu/dockerfile  DOTNET          $_dotnet
setENV  wakatipu/dockerfile  GCC             $_gcc
setENV  wakatipu/dockerfile  GITVERSIONTOOL  $_gitversionTool
setENV  wakatipu/dockerfile  GO              $_go
setENV  wakatipu/dockerfile  GOSWAGGER       $_goswagger
setENV  wakatipu/dockerfile  HELM            $_helm
setENV  wakatipu/dockerfile  JFROGCLI        $_jfrogcli
setENV  wakatipu/dockerfile  JDK             $_jdk
setENV  wakatipu/dockerfile  KUBECTL         $_kubectl
setENV  wakatipu/dockerfile  MAVEN           $_maven

# Update README(s)
updateREADME  README.md  git   $_git
updateREADME  README.md  nvm   $_nvm
updateREADME  README.md  node  $_node

updateREADME  README-wakatipu.md  Docker            $_docker
updateREADME  README-wakatipu.md  DotNet            $_dotnet
updateREADME  README-wakatipu.md  gcc               $_gcc
updateREADME  README-wakatipu.md  GitVersion        $_gitversionTool
updateREADME  README-wakatipu.md  GoLang            $_go
updateREADME  README-wakatipu.md  GoSwagger         $_goswagger
updateREADME  README-wakatipu.md  Helm              $_helm
updateREADME  README-wakatipu.md  JDK               $_jdk
updateREADME  README-wakatipu.md  JFrog             $_jfrogcli
updateREADME  README-wakatipu.md  kubectl           $_kubectl
updateREADME  README-wakatipu.md  Maven             $_maven
updateREADME  README-wakatipu.md  go-junit-report   $_gojunit

# Build base OS and wakatipu images.
#  OS adds layers to Ubuntu for git, node and nvm.
#  Wakatipu adds layers for all golang tooling, but no agent.
doBuild os
doBuild wakatipu

# Build agent images

#  These images are built for bare agents (no tooling) which may be used as the base
#  for more specific agent images.
doBuild agent 2.170.1
doBuild agent 2.181.2
doBuild agent 2.190.0

#  These images add specific versions of the agent to the wakatipu tooling.
doBuild agent 2.170.1-wakatipu
doBuild agent 2.181.2-wakatipu
doBuild agent 2.190.0-wakatipu