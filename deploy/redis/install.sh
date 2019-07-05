#!/bin/bash

my_dir="$(dirname "$0")"

if [[ "_${PIENI_PROJECT}" = "_" ]]; then
    echo "Need to set version with export PIENI_PROJECT"
    exit 1
fi

if [[ "_${PIENI_POC_VERSION}" = "_" ]]; then
    echo "Need to set version with export PIENI_POC_VERSION"
    exit 1
fi


#-- Checks for Version ENV Var
if [[ "_${REDIS_VERSION}" = "_" ]]; then
    echo "Need to set version with export REDIS_VERSION"
    exit 1
fi


echo "Using Version ${PIENI_POC_VERSION}, redis version ${REDIS_VERSION}"


#-- switch to pieni project
oc project ${PIENI_PROJECT}

#-- all teamplate files needed
templates=()
templates[1]="../template/redis-template.yml"
paramfile="../default/config.list"

#-- write new config to config.json
echo "STAGE=dev" > ${paramfile}
echo "PIENI_POC_VERSION=${PIENI_POC_VERSION}" >> ${paramfile}
echo "REDIS_VERSION=${REDIS_VERSION}" >> ${paramfile}

#-- run all template files
for template in ${templates[@]}; do
    echo "Install Template: ${template}"

    #-- read required parameters
    #requiredParams=$(oc process -f ${template} --parameters=true | tail -n +2 | awk '{ print $1 }')
    #pat=$(echo ${requiredParams[@]}|tr " " "|")

    #-- read values for required parameters
    #params=$(cat ${paramfile} | grep -Ew "$pat" |tr "\n" ", ")
    #echo "Parameters: ${params}"

    #-- apply templates
    # cat ${paramfile} | grep -Ew "$pat" | oc process -f ${template} --param-file=${paramfile} | oc apply -f -
    oc process -f ${template} --param-file=${paramfile} | oc apply -f -
    #-- new line separator
    echo "";
done

#-- remove PIENI_POC_VERSION from env
unset PIENI_POC_VERSION
unset PIENI_PROJECT
unset REDIS_VERSION