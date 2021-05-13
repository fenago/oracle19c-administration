#! /bin/bash

# disable unified auditing 
# unlink the unified audting 
# oraenv has been run in the environment and ORACLE_HOME and PATH are set.
#


export ORACLE_SID=orclcdb
ORAENV_ASK="NO"
. oraenv 
ORAENV_ASK=""

$ORACLE_HOME/bin/lsnrctl stop listener
$ORACLE_HOME/bin/lsnrctl stop listener2

$ORACLE_HOME/bin/sqlplus / as sysdba <<EOF

alter pluggable database ORCLPDB1 open;

alter session set container=ORCLPDB1;

noaudit policy JOBS_AUDIT_UPD;
drop audit policy JOBS_AUDIT_UPD;

alter session set container = CDB\$ROOT;

shutdown immediate
exit
EOF

cd $ORACLE_HOME/rdbms/lib
make -f ins_rdbms.mk uniaud_off ioracle

lsnrctl start listener
lsnrctl start listener2

sqlplus / as sysdba <<EOF
startup
exit
EOF


