#!/bin/bash

# Scan only the most fully equipped images - any vulnerabilities in base layers
#  will be identified as such, if present.

docker scout cves deltics/azdevops-buildagent:2.190.0-ubuntu23.04-wakatipu
docker scout cves deltics/azdevops-buildagent:3.225.0-ubuntu23.04-wakatipu