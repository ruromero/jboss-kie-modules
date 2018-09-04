#!/bin/bash

load $BATS_TEST_DIRNAME/../../../../tests/bats/common/cct_module.bash

export JBOSS_HOME=$BATS_TMPDIR/jboss_home
export CONFIG_FILE=$JBOSS_HOME/standalone/configuration/standalone-openshift.xml

mkdir -p $JBOSS_HOME/bin/launch

# Fetch remote cct_module dependencies
get_cct_module_file os-eap71-openshift/added/standalone-openshift.xml $JBOSS_HOME
get_cct_module_file os-eap7-launch/added/launch/launch-common.sh $JBOSS_HOME/bin/launch
get_cct_module_file os-eap7-launch/added/launch/tx-datasource.sh $JBOSS_HOME/bin/launch
get_cct_module_file os-eap7-launch/added/launch/datasource.sh $JBOSS_HOME/bin/launch
get_cct_module_file os-logging/added/launch/logging.sh $JBOSS_HOME/bin/launch
get_cct_module_file os-eap-launch/added/launch/datasource-common.sh $JBOSS_HOME/bin/launch
get_cct_module_file os-eap-node-name/added/launch/openshift-node-name.sh $JBOSS_HOME/bin/launch
# Copy local dependencies
cp $BATS_TEST_DIRNAME/../../../added/launch/jboss-kie-kieserver.sh $JBOSS_HOME/bin/launch
cp $BATS_TEST_DIRNAME/../../../../jboss-kie-common/added/launch/jboss-kie-security.sh $JBOSS_HOME/bin/launch

mkdir -p $JBOSS_HOME/standalone/configuration
source $JBOSS_HOME/bin/launch/datasource.sh
source $JBOSS_HOME/bin/launch/jboss-kie-kieserver.sh

function setup() {
  cp $JBOSS_HOME/standalone-openshift.xml $JBOSS_HOME/standalone/configuration
}

function assert_datasources() {
  local expected=$1
  local xpath="//*[local-name()='datasources']"
  assert_xml $JBOSS_HOME/standalone/configuration/standalone-openshift.xml "$xpath" $BATS_TEST_DIRNAME/expectations/$expected
}
