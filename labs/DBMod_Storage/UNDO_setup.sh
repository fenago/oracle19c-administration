#!/bin/sh
# use bash shell
#


#
export ORACLE_SID=orclcdb
ORAENV_ASK="NO"
. oraenv
ORAENV_ASK=""

$ORACLE_HOME/bin/sqlplus -s /nolog  <<EOF

connect / as sysdba
ALTER DATABASE DATAFILE '/u01/app/oracle/oradata/ORCLCDB/undotbs01.dbf' AUTOEXTEND OFF;

EXIT
EOF

