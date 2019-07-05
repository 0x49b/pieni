#!/usr/bin/env bash

my_dir="$(dirname "$0")"
PIENI_POC_VERSION=0.0.12

<<<<<<< HEAD
if [ "_${PIENI_PROJECT}" = "_" ]; then
    echo "Need to set version with export PIENI_PROJECT"
    exit 1
fi

if [ "_${PIENI_POC_VERSION}" = "_" ]; then
    echo "Need to set version with export PIENI_POC_VERSION"
    exit 1
fi

echo "Using Version ${PIENI_POC_VERSION}"
=======
echo "Using Version 0.0.12"
>>>>>>> aaf827a9cde5cdde31772a57c2b9dbb171c4165f


#-- switch to pieni project
oc project ${PIENI_PROJECT}

#-- all teamplate files needed
templates=()
templates[1]="./template/pieni-template.yml"

#-- write new config to config.json
echo "STAGE=dev" > ./default/config.list
echo "PIENI_POC_VERSION=${PIENI_POC_VERSION}" >> ./default/config.list

#-- run all template files
for template in ${templates[@]}; do
    echo "Install Template: ${template}"

    #-- read required parameters
    requiredParams=$(oc process -f ${template} --parameters=true | tail -n +2 | awk '{ print $1 }')
    pat=$(echo ${requiredParams[@]}|tr " " "|")

    #-- read values for required parameters
    params=$(cat ./default/config.list | grep -Ew "$pat" |tr "\n" ", ")
    echo "Parameters: ${params}"

    #-- apply templates
    cat ./default/config.list | grep -Ew "$pat" | oc process -f ${template} --param-file=- | oc apply -f -



    #-- new line separator
    echo "";
done

#-- remove PIENI_POC_VERSION from env
unset PIENI_POC_VERSION
unset PIENI_PROJECT