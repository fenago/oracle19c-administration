#! /bin/bash

# drop_PDBs.sh
# drop including datafiles PDBs created in thie practice module.

export ORACLE_SID=orclcdb
ORAENV_ASK="NO"
. oraenv
ORAENV_ASK=""

sqlplus / as sysdba <<EOF
ALTER PLUGGABLE DATABASE orclpdb3 CLOSE;

DROP PLUGGABLE DATABASE orclpdb3 INCLUDING DATAFILES;

EOF
