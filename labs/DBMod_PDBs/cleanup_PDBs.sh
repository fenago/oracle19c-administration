#! /bin/bash

# drop_PDBs.sh
# drop including datafiles PDBs created in thie practice module.

#
export ORACLE_SID=orclcdb
ORAENV_ASK="NO"
. oraenv
ORAENV_ASK=""
#
sqlplus / as sysdba <<EOF
ALTER PLUGGABLE DATABASE orclpdb3 CLOSE;

DROP PLUGGABLE DATABASE orclpdb3 INCLUDING DATAFILES;

!rm -rf $ORACLE_BASE/oradata/ORCLCDB/orclpdb3

ALTER PLUGGABLE DATABASE pdb3_orcl CLOSE;

DROP PLUGGABLE DATABASE pdb3_orcl INCLUDING DATAFILES;

!rm -rf $ORACLE_BASE/oradata/ORCLCDB/pdb3_orcl

ALTER PLUGGABLE DATABASE pdb_source_for_hotclone CLOSE;

DROP PLUGGABLE DATABASE pdb_source_for_hotclone INCLUDING DATAFILES;

!rm -rf $ORACLE_BASE/oradata/ORCLCDB/pdb_source_for_hotclone
EOF
