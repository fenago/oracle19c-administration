#! /bin/bash
#REset TNSNAMES.ORA to original
export ORACLE_SID=orclcdb
ORAENV_ASK="NO"
. oraenv
ORAENV_ASK=""

cp /home/oracle/labs/DBMod_CreateDB/tnsnames.ora $ORACLE_HOME/network/admin/tnsnames.ora
