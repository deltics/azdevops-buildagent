#!/bin/bash

# Base images
docker push deltics/azdevops-buildagent:os
docker push deltics/azdevops-buildagent:wakatipu

# "Empty" Build agent images (no tooling)
docker push deltics/azdevops-buildagent:2.170.1
docker push deltics/azdevops-buildagent:2.181.2
docker push deltics/azdevops-buildagent:2.190.0

# Wakatipu build agent images
docker push deltics/azdevops-buildagent:2.170.1-wakatipu
docker push deltics/azdevops-buildagent:2.181.2-wakatipu
docker push deltics/azdevops-buildagent:2.190.0-wakatipu