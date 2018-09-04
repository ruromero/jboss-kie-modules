#!/bin/bash

# get_cct_module_file os-eap7-launch/added/launch/launch-common.sh $JBOSS_HOME/bin/launch
function get_cct_module_file() {
    local file=$1
    local target=$2
    local branch=${3:-master}

    if [ ! -f $target/${file##*/} ]; then
        curl -sf https://raw.githubusercontent.com/jboss-openshift/cct_module/$branch/$file -o $target/${file##*/}
    fi
}