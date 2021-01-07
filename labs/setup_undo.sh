#!/bin/sh
# use bash shell
#
# Written by: Dominique.Jeunot@oracle.com
#

export ORACLE_HOME=/u01/app/oracle/product/12.2.0/dbhome_1
export ORACLE_SID=ORCL
PATH=$ORACLE_HOME/bin:$PATH; export PATH

echo '' > /u01/app/oracle/product/12.2.0/dbhome_1/sqlplus/admin/glogin.sql
echo set pages 100 >> /u01/app/oracle/product/12.2.0/dbhome_1/sqlplus/admin/glogin.sql
echo set tab off >> /u01/app/oracle/product/12.2.0/dbhome_1/sqlplus/admin/glogin.sql
echo set lines 68 >> /u01/app/oracle/product/12.2.0/dbhome_1/sqlplus/admin/glogin.sql
echo col pdb_name format A12 >> /u01/app/oracle/product/12.2.0/dbhome_1/sqlplus/admin/glogin.sql
echo col PROPERTY_NAME format A18 >> /u01/app/oracle/product/12.2.0/dbhome_1/sqlplus/admin/glogin.sql
echo col PROPERTY_value  format A14 >> /u01/app/oracle/product/12.2.0/dbhome_1/sqlplus/admin/glogin.sql

$ORACLE_HOME/bin/sqlplus -s /nolog  <<EOF

connect / as sysdba
shutdown immediate
STARTUP UPGRADE
alter database local undo OFF;
shutdown immediate
startup
alter pluggable database all open;

EXIT
EOF

