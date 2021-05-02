#!/bin/sh
# use bash shell
#

# mod by James.Spiller@oracle.com

#
export ORACLE_SID=orclcdb
ORAENV_ASK="NO"
. oraenv
ORAENV_ASK=""
#
mkdir -p /u01/app/oracle/oradata/ORCLCDB/orclpdb3
cd /home/oracle/labs/DBMod_CreateDB
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @create_pdb3.sql
# add pdb3 to tnsnames.ora
cat orclpdb3.ora >> $ORACLE_HOME/network/admin/tnsnames.ora 
$ORACLE_HOME/bin/sqlplus "system/fenago@pdb3" @cr_user_test.sql

