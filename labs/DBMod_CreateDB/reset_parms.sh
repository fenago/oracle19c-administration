#! /bin/bash

# reset_parms.sh
# reset any parameters set permenantly during the practice

export ORACLE_SID=orclcdb
ORAENV_ASK="NO"
. oraenv
ORAENV_ASK=""

sqlplus / as sysdba <<EOF

ALTER SYSTEM SET job_queue_processes = 40 SCOPE = BOTH;

EOF
