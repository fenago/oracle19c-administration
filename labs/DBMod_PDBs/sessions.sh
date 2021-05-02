#!/bin/sh
# use bash shell
#
# Written by:  Dominique Jeunot
# modified by  darryl.balaski@oracle.com
#
export ORACLE_SID=orclcdb
ORAENV_ASK="NO"
. oraenv
ORAENV_ASK=""
#
cd $HOME/labs/DBMod_PDBs

read -sp "Input the SYSTEM user password: " passvar
$ORACLE_HOME/bin/sqlplus "system/$passvar@pdb3" @test_bigtab.sql

