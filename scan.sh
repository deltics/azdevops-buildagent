#!/bin/bash

# Scan only the most fully equipped images - any vulnerabilities in base layers
#  will be identified as such, if present.

docker scan deltics/azdevops-buildagent:2.170.1-wakatipu
docker scan deltics/azdevops-buildagent:2.190.0-wakatipu