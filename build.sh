#!/bin/bash
# Base image (no agent, just OS, Git and Node)
docker build -t deltics/azdevops-buildagent:base _base

# Build agent base images (different versions)
docker build -t deltics/azdevops-buildagent:2.170.1 2.170.1
docker build -t deltics/azdevops-buildagent:2.181.2 2.181.2
docker build -t deltics/azdevops-buildagent:2.190.0 2.190.0

# GoLang images
contentTag="docker20.10.8-dotnet5.0-gcc11-gitversion5.6.6-go1.16.7-helm3.6.3-jdk11-jfrog2-maven3.8.3"

docker build -t deltics/azdevops-buildagent:2.170.1-$contentTag 2.170.1-wakatipu
docker build -t deltics/azdevops-buildagent:2.181.2-$contentTag 2.181.2-wakatipu
docker build -t deltics/azdevops-buildagent:2.190.0-$contentTag 2.190.0-wakatipu

# Short/alternate tags
docker build -t deltics/azdevops-buildagent:2.170.1-wakatipu 2.170.1-wakatipu
docker build -t deltics/azdevops-buildagent:2.181.2-wakatipu 2.181.2-wakatipu
docker build -t deltics/azdevops-buildagent:2.190.0-wakatipu 2.190.0-wakatipu