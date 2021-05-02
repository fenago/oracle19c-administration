#!/bin/sh
# use bash shell
#
# Written by:  Dominique Jeunot
# modified by darrl.balaski@oracle.com
#
#Set the oraenv to ORCLCDB prior to execution
export ORACLE_SID=orclcdb
ORAENV_ASK="NO"
. oraenv
ORAENV_ASK=""
#
cd $HOME/labs/DBMod_PDBs
echo "************************* "
echo "In  ORCLCDB "
echo "************************* "
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @drop_pdb_source_for_hotclone.sql

echo "************************* "
echo "In  CDBTEST "
echo "************************* "
#Set the oraenv to ORCLCDB prior to execution
export ORACLE_SID=CDBTEST
ORAENV_ASK="NO"
. oraenv
ORAENV_ASK=""
#
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @drop_pdb_hotclone.sql

