#!/bin/sh
# use bash shell
#
# Written by:  Dominique Jeunot
# Modified by: James Spiller for 19c DBMod_PDBs

#
export ORACLE_SID=orclcdb
ORAENV_ASK="NO"
. oraenv
ORAENV_ASK=""
#
read -sp "Input the SYS user password: " passvar 
#
mkdir -p /u01/app/oracle/oradata/ORCLCDB/pdb_source_for_hotclone

cd $HOME/labs/DBMod_PDBs

$ORACLE_HOME/bin/sqlplus "/ as sysdba" @create_pdb_source_for_hotclone.sql
$ORACLE_HOME/bin/sqlplus "sys/$passvar@//localhost:1521/pdb_source_for_hotclone as sysdba" @create_source_user_bigtab.sql

export ORACLE_SID=CDBTEST
ORAENV_ASK="NO"
. oraenv
ORAENV_ASK=""
# create the CDBTEST database
#$HOME/labs/DBMod_PDBs/CrCDBTEST.sh

# ensure that hotclone PDB is non existent
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @drop_pdb_hotclone.sql

rm -rf /u01/app/oracle/oradata/CDBTEST/hotclone

# add pdb_source_for_hotclone to tnsnames.ora

cat hotclone_source.ora >> $ORACLE_HOME/network/admin/tnsnames.ora
