#!/bin/sh
# use bash shell
#

#
export ORACLE_SID=orclcdb
ORAENV_ASK="NO"
. oraenv
ORAENV_ASK=""
#
#echo $ORACLE_HOME
#
echo '' > $ORACLE_HOME/sqlplus/admin/glogin.sql
echo set pagesize 100 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo set linesize 132 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo set tab off >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo SET HISTORY ON >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo col CID format 999 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo col PDB_ID format 99999 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo col pdb_name format A18 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo col NAME format A15 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo col NETWORK_NAME format A15 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo col con_NAME format A15 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo col MEMBER format A40 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo col file_name format A55 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo col tablespace_name format A10 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo col file_id format 9999 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo col con_id  format 999 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo col username format A22 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo col PROPERTY_NAME format A18 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo col PROPERTY_value  format A14 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo col PROXY_PDB_SOURCE_PDB  format A26 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo col PROXY_PDB_DBLINK  format A28 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo col cdb\$name format a10 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo col con\$name format a15 >> $ORACLE_HOME/sqlplus/admin/glogin.sql

