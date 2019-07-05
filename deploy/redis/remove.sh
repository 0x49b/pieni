#!/bin/bash

my_dir="$(dirname "$0")"

if [[ "_${PIENI_PROJECT}" = "_" ]]; then
    echo "Need to set version with export PIENI_PROJECT"
    exit 1
fi

#-- switch to kib project
oc project ${PIENI_PROJECT}

#-- remove redis
echo "removing redis"
oc delete all -l app=redis