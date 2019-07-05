#!/usr/bin/env bash

#-- list all images
docker images

#-- set the tag
docker tag redis:latest pieni-poc.docker.bin.sbb.ch/pieni-poc/redis:latest

#-- list images again, just to be sure
docker images

#-- logging into artifact
docker login pieni-poc.docker.bin.sbb.ch

#-- push the new image to artifactory
docker push pieni-poc.docker.bin.sbb.ch/pieni-poc/redis:latest
