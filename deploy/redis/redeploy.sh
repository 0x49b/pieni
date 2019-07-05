#!/bin/bash

#-- File to redeploy in Openshift with a full cleanup. Don't forget to set the PIENI_POC_VERSION
echo "PIENI redeploy started"

echo "start removing components"
source "remove.sh"

echo "start installing components"
source "install.sh"

