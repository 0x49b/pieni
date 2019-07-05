#!/bin/bash

#-- Checks for Version ENV Var
if [[ "_${REDIS_VERSION}" = "_" ]]; then
    echo "Need to set version with export REDIS_VERSION"
    exit 1
fi


#-- list all images
docker images

#-- set the tag
docker tag redis:latest pieni-poc.docker.bin.sbb.ch/pieni-poc/redis:${REDIS_VERSION}

#-- list images again, just to be sure
docker images

#-- logging into artifact
docker login pieni-poc.docker.bin.sbb.ch

#-- push the new image to artifactory
docker push pieni-poc.docker.bin.sbb.ch/pieni-poc/redis:${REDIS_VERSION}
