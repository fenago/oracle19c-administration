#!/bin/sh
# use bash shell
#
# Written by: Dominique.Jeunot@oracle.com
#

export ORACLE_HOME=/u01/app/oracle/product/12.2.0/dbhome_1
mkdir /home/oracle/labs/DP
mkdir /home/oracle/labs/DP2
mv /home/oracle/labs/DP_sales_1998.dat /home/oracle/labs/DP/DP_sales_1998.dat
mv /home/oracle/labs/DP2_sales_1999.dat /home/oracle/labs/DP2/DP2_sales_1999.dat
mv /home/oracle/labs/DP2_sales_2000.dat /home/oracle/labs/DP2/DP2_sales_2000.dat
rm /home/oracle/labs/DP/orders.dmp
echo '' > /u01/app/oracle/product/12.2.0/dbhome_1/sqlplus/admin/glogin.sql
echo set pages 100 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo set lines 68 >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo set tab off >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL TABLE_NAME FORMAT A16  >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL PARTITION_NAME FORMAT A14  >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL LOCATION FORMAT A18  >> $ORACLE_HOME/sqlplus/admin/glogin.sql
echo COL DIRECTORY_NAME FORMAT A12  >> $ORACLE_HOME/sqlplus/admin/glogin.sql
