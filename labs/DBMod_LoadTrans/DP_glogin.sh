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
mkdir -p /home/oracle/labs/DBMod_LoadTrans/DP
mkdir -p /home/oracle/labs/DBMod_LoadTrans/DP2
cp -p /home/oracle/labs/DBMod_LoadTrans/DP_sales_1998.dat /home/oracle/labs/DBMod_LoadTrans/DP/DP_sales_1998.dat
cp -p /home/oracle/labs/DBMod_LoadTrans/DP2_sales_1999.dat /home/oracle/labs/DBMod_LoadTrans/DP2/DP2_sales_1999.dat
cp -p /home/oracle/labs/DBMod_LoadTrans/DP2_sales_2000.dat /home/oracle/labs/DBMod_LoadTrans/DP2/DP2_sales_2000.dat
rm -f /home/oracle/labs/DBMod_LoadTrans/DP/orders.dmp
echo '' > $ORACLE_HOME/sqlplus/admin/glogin.sql
echo set pages 100 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo set lines 132 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo set tab off >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL TABLE_NAME FORMAT A16  >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL PARTITION_NAME FORMAT A14  >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL LOCATION FORMAT A18  >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL DIRECTORY_NAME FORMAT A15  >> $ORACLE_HOME/sqlplus/admin/glogin.sql
