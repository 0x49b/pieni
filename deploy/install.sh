#!/bin/bash

my_dir="$(dirname "$0")"

if [ "_${PIENI_PROJECT}" = "_" ]; then
    echo "Need to set version with export PIENI_PROJECT"
    exit 1
fi

if [ "_${PIENI_POC_VERSION}" = "_" ]; then
    echo "Need to set version with export PIENI_POC_VERSION"
    exit 1
fi

#-- Checks for Version ENV Var
if [[ "_${REDIS_VERSION}" = "_" ]]; then
    echo "Need to set version with export REDIS_VERSION"
    exit 1
fi


echo "Using PIENI ${PIENI_POC_VERSION}, using REDIS ${REDIS_VERSION}"


#-- switch to pieni project
oc project ${PIENI_PROJECT}


paramfile="./default/config.list"

#-- Installing REDIS
template="./template/redis-template.yml"
echo "STAGE=dev" > ${paramfile}
echo "REDIS_VERSION=${REDIS_VERSION}" >> ${paramfile}
echo "Install Template: ${template}"

#-- apply templates
# cat ${paramfile} | grep -Ew "$pat" | oc process -f ${template} --param-file=${paramfile} | oc apply -f -
oc process -f ${template} --param-file=${paramfile} | oc apply -f -
#-- new line separator
echo "";


#-- Installing PIENI
template="./template/pieni-template.yml"
echo "STAGE=dev" > ${paramfile}
echo "PIENI_POC_VERSION=${PIENI_POC_VERSION}" >> ${paramfile}
echo "Install Template: ${template}"

#-- apply templates
# cat ${paramfile} | grep -Ew "$pat" | oc process -f ${template} --param-file=${paramfile} | oc apply -f -
oc process -f ${template} --param-file=${paramfile} | oc apply -f -
#-- new line separator
echo "";




#-- remove PIENI_POC_VERSION from env
unset PIENI_POC_VERSION
unset PIENI_PROJECT
unset REDIS_VERSION