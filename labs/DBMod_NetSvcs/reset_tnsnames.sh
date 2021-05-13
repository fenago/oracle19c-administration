#! /bin/bash
#REset TNSNAMES.ORA to original
export ORACLE_SID=orclcdb
ORAENV_ASK="NO"
. oraenv
ORAENV_ASK=""

cd /home/oracle/reset/DBMod_NetSvcs
rm $ORACLE_HOME/network/admin/tnsnames.*

cp tnsnames.ora $ORACLE_HOME/network/admin/tnsnames.ora

lsnrctl stop LISTENER2

cp listener.ora $ORACLE_HOME/network/admin/listener.ora
