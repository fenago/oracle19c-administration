#! /bin/bash

#Reset_com_users.sh   
# Reset common users removing any common users created by this module.
#  Assumptions . oraenv has already been run so ORACLE_HOME and PATH are set.

#
export ORACLE_SID=orclcdb
ORAENV_ASK="NO"
. oraenv
ORAENV_ASK=""
#
$ORACLE_HOME/bin/sqlplus / as sysdba <<EOF

DROP USER C##CDB_ADMIN1 CASCADE;

DROP USER C##AUDVWR CASCADE;

DROP USER C##AUDMGR CASCADE;

DROP USER C##U CASCADE;

EOF
 
