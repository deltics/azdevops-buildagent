#!/bin/bash

# Base images
docker push deltics/azdevops-buildagent:ubuntu23.04
docker push deltics/azdevops-buildagent:ubuntu23.04-wakatipu

# "Empty" Build agent images (no tooling)
docker push deltics/azdevops-buildagent:2.190.0-ubuntu23.04
docker push deltics/azdevops-buildagent:3.225.0-ubuntu23.04

# Wakatipu build agent images
docker push deltics/azdevops-buildagent:2.190.0-ubuntu23.04-wakatipu
docker push deltics/azdevops-buildagent:3.225.0-ubuntu23.04-wakatipu