#!/bin/sh
# use bash shell
#

export ORACLE_HOME=/u01/app/oracle/product/19.3.0/dbhome_1
export ORACLE_SID=fenagodb
PATH=$ORACLE_HOME/bin:$PATH; export PATH

$ORACLE_HOME/bin/sqlplus -s /nolog  <<EOF

connect / as sysdba
ALTER DATABASE DATAFILE '/u02/oradata/FENAGODB1/undotbs01.dbf' AUTOEXTEND OFF;

EXIT
EOF

