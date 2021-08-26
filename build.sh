#!/bin/bash
# Base image (no agent, just OS, Git and Node)
docker build -t deltics/azdevops-buildagent:base _base

# Build agent base images (different versions)
docker build -t deltics/azdevops-buildagent:2.170.1 2.170.1
docker build -t deltics/azdevops-buildagent:2.190.0 2.190.0

# GoLang images
docker build -t deltics/azdevops-buildagent:2.170.1-docker20.10.8-dotnet5.0-gitversion5.6.6-go1.16.7-helm3.6.3-jdk11-jfrog2-maven3.8.2 2.170.1-wakatipu
docker build -t deltics/azdevops-buildagent:2.190.0-docker20.10.8-dotnet5.0-gitversion5.6.6-go1.16.7-helm3.6.3-jdk11-jfrog2-maven3.8.2 2.190.0-wakatipu

# Short/alternate tags
docker build -t deltics/azdevops-buildagent:2.170.1-wakatipu 2.170.1-wakatipu
docker build -t deltics/azdevops-buildagent:2.190.0-wakatipu 2.190.0-wakatipu