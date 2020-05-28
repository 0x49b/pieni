#!/bin/bash

if [[ "_${PIENI_POC_VERSION}" = "_" ]]; then
    echo "Need to set version with export PIENI_POC_VERSION"
    exit 1
fi

docker build -t pieni-poc:latest .
#docker push docker.bin.sbb.ch/pieni-poc/pieni:0.0.1

./deploy/push_image.sh