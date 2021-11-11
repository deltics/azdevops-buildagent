#!/bin/bash
# Base image (no agent, just OS, Git and Node)
docker push deltics/azdevops-buildagent:base

# Build agent base images (different versions)
docker push deltics/azdevops-buildagent:2.170.1
docker push deltics/azdevops-buildagent:2.181.2
docker push deltics/azdevops-buildagent:2.190.0

# GoLang images
contentTag="docker20.10.8-dotnet5.0-gcc11-gitversion5.6.6-go1.16.7-helm3.6.3-jdk11-jfrog2-maven3.8.3"

docker push deltics/azdevops-buildagent:2.170.1-docker20.10.8-$contentTag
docker push deltics/azdevops-buildagent:2.181.2-docker20.10.8-$contentTag
docker push deltics/azdevops-buildagent:2.190.0-docker20.10.8-$contentTag

# Short/alternate tags
docker push deltics/azdevops-buildagent:2.170.1-wakatipu
docker push deltics/azdevops-buildagent:2.181.2-wakatipu
docker push deltics/azdevops-buildagent:2.190.0-wakatipu