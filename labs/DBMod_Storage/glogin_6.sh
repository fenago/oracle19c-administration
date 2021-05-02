#!/bin/sh
# use bash shell
#


#
export ORACLE_SID=orclcdb
ORAENV_ASK="NO"
. oraenv
ORAENV_ASK=""
#
echo '' > $ORACLE_HOME/sqlplus/admin/glogin.sql
echo set pages 100 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo set lines 132 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo set tab off >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo SET HISTORY ON >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo col CID format 999 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo col PDB_ID format 99999 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo col PDB_NAME format a10 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo col NAME format A15 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo col con_NAME format A14 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo col file_name format A50 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo col tablespace_name format A15 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo col file_id format 9999 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo col con_id  format 999 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo col username format A12 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo col PROPERTY_NAME format A28 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo col PROPERTY_value  format A14 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo col PROXY_PDB_SOURCE_PDB  format A26 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo col PROXY_PDB_DBLINK  format A28 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo col default_tablespace format A18 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo col temporary_tablespace format A20 >> $ORACLE_HOME/sqlplus/admin/glogin.sql

