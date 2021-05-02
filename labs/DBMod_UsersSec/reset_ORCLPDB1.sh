#! /bin/bash

# reset_ORCLPDB1.sh
# This script drops ORCLPDB1 and recreates it from ORCLPDB2
# Assumptions:
# ORCLPDB2 exists and is pristine.
# PDB1 may also exist, and will be dropped.
#
#
export ORACLE_SID=orclcdb
ORAENV_ASK="NO"
. oraenv
ORAENV_ASK=""
#
$ORACLE_HOME/bin/sqlplus / as sysdba <<EOF
alter PLUGGABLE DATABASE PDB1 Close;
DROP PLUGGABLE DATABASE PDB1 including datafiles;

Alter PLUGGABLE DATABASE ORCLPDB1 Close;
DROP PLUGGABLE DATABASE ORCLPDB1 including datafiles;

Create pluggable database ORCLPDB1 FROM ORCLPDB2
FILE_NAME_CONVERT = ('orclpdb2', 'orclpdb1');

ALTER PLUGGABLE DATABASE ORCLPDB1 OPEN;
EOF
