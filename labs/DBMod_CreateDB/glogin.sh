#!/bin/sh
# use bash shell
#

#
export ORACLE_SID=orclcdb
ORAENV_ASK="NO"
. oraenv
ORAENV_ASK=""
#
#
echo '' > $ORACLE_HOME/sqlplus/admin/glogin.sql
echo set pagesize 50 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo set linesize 132 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo set tab off >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL TABLE_NAME FORMAT A16  >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL LOCATION FORMAT A18  >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL DIRECTORY_NAME FORMAT A20  >> $ORACLE_HOME/sqlplus/admin/glogin.sql
