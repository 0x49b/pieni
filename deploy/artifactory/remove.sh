#!/usr/bin/env bash

if [[ "_${PIENI_PROJECT}" = "_" ]]; then
    echo "Need to set version with export PIENI_PROJECT"
    exit 1
fi

echo "remove secret"

# switch to kib project
oc project ${PIENI_PROJECT}

# delete pull secret
oc delete secret external-registry

unset PIENI_PROJECT