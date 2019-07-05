#!/usr/bin/env bash

if [[ "_${PIENI_PROJECT}" = "_" ]]; then
    echo "Need to set version with export PIENI_PROJECT"
    exit 1
fi

echo "Installing secret"

# switch to kib project
oc project ${PIENI_PROJECT}

# Auth in config.json with folowing pattern as base64 encoded string:
# <user>:<password>

# Secret erstellen
oc secrets new external-registry .dockerconfigjson=config.json
# Secrets dem Default Service-Account zuweisen
oc secrets add serviceaccount/default secrets/external-registry --for=pull

unset PIENI_PROJECT