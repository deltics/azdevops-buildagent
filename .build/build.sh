#!/bin/bash

function setENV() {
    sed -i '' "s/$2_VERSION=.*/$2_VERSION=$3/" ../$1
}

function updateREADME() {
    sed -i '' "s/| $2 | .* |\(.*\)/| $2 | $3 |\1/" ../$1
}

# Installed in the "os" layer
_git=2.39.2
_nvm=0.39.5 #_nvm=0.39.3
_node=18.18.0 #_node=16.20.0

# ENV defined in the "env" layer, but installed in n.nnn.n agent layers
_docker=24.0.6 #_docker=20.10.24
_dotnet=6.0
_gcc=11
_gitversionTool=5.12.0
_go=1.21.1
_goswagger=0.30.5 #_goswagger=0.30.4
_helm=3.12.3 #_helm=3.12.0
_jfrogcli=2
_jdk=11.0.12.7.1
_kubectl=1.24.3 # _kubectl=1.22.15
_maven=3.9.4 #_maven=3.9.2

# for information only, binary is copied from wakatipu/.tools
_gojunit=2.0.0

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

# build the images
docker build -t deltics/azdevops-buildagent:ubuntu23.04          -f ../os/dockerfile        ../os
docker build -t deltics/azdevops-buildagent:ubuntu23.04-wakatipu -f ../wakatipu/dockerfile  ../wakatipu
for dockerfile in ../agent/dockerfile.*; do
    dockerfile=${dockerfile#../agent/*}
    tag=${dockerfile#*.}
    docker build -t deltics/azdevops-buildagent:$tag -f ../agent/$dockerfile ../agent
done