#!/usr/bin/env sh

my_dir="$(dirname "$0")"

if [ "_${PIENI_PROJECT}" = "_" ]; then
    echo "Need to set version with export PIENI_PROJECT"
    exit 1
fi

#-- switch to kib project
oc project ${PIENI_PROJECT}

#-- remove everything from kib
oc delete all -l app=pieni-poc-dev

unset PIENI_PROJECT