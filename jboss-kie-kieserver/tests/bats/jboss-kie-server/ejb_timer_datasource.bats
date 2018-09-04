#!/usr/bin/env bats

load common

@test "EJB_TIMER_DS: No Datasources defined" {
    run configure_EJB_Timer_datasource

    [ "${lines[0]}" = "INFO EJB Timer will be auto configured if any datasource is configured via DB_SERVICE_PREFIX_MAPPING or DATASOURCES envs." ]
    [ -z $DATASOURCES ]
    [ -z $DB_SERVICE_PREFIX_MAPPING ]
}

@test "EJB_TIMER_DS: DATASOURCES - Mysql" {
    DATASOURCES="TEST"
    TEST_DRIVER="postgresql"

    run configure_EJB_Timer_datasource
echo $output > /tmp/test.out
echo $OH >> /tmp/test.out
    [ "$status" -eq 0 ]
    [ "${lines[0]}" = "INFO EJB Timer will be auto configured if any datasource is configured via DB_SERVICE_PREFIX_MAPPING or DATASOURCES envs." ]
    [ "${lines[1]}" = "INFO configuring EJB Timer Datasource based on DATASOURCES env" ]

    [ "$DATASOURCES" = "TEST" ]
    [ "$EJB_TIMER_DRIVER" = "$TEST_DRIVER" ]
}