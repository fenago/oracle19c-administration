#!/bin/sh
# use bash shell
#
# Written by: Darryl Balaski for 19c DBMod_PDBs 
#
export ORACLE_SID=orclcdb
ORAENV_ASK="NO"
. oraenv
ORAENV_ASK=""
#
cd $HOME/labs/DBMod_PDBs

# reset the tnsnames.ora

cp setup_tns.ora $ORACLE_HOME/network/admin/tnsnames.ora
