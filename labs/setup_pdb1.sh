#!/bin/sh
# use bash shell
#
# Written by: Dominique.Jeunot@oracle.com
#

export ORACLE_HOME=/u01/app/oracle/product/18.0.0/dbhome_1
export ORACLE_SID=ORCL
PATH=$ORACLE_HOME/bin:$PATH; export PATH
mkdir -p /u01/app/oracle/oradata/ORCL/pdb1
$ORACLE_HOME/bin/sqlplus -s /nolog  <<EOF
conn sys/DBAdmin_1@pdb1 as sysdba 
create tablespace TBS_APP datafile '/u02/app/oracle/oradata/ORCL/PDB1/tbs_app01.dbf' size 800M;
drop user oe cascade;
create user oe identified by DBAdmin_1 default tablespace tbs_app;
grant create session, dba to oe;

create table oe.orders (
 ORDER_ID	  NUMBER(12),
 ORDER_DATE	  TIMESTAMP(6) WITH LOCAL TIME ZONE, 
 ORDER_MODE   VARCHAR2(8),
 CUSTOMER_ID  NUMBER(6),
 ORDER_STATUS NUMBER(2),
 ORDER_TOTAL  NUMBER(8,2),
 SALES_REP_ID NUMBER(6),
 PROMOTION_ID NUMBER(6)
 );
 
create table oe.order_items (
 ORDER_ID     NUMBER(12),
 LINE_ITEM_ID NUMBER(3),
 PRODUCT_ID   NUMBER(6),
 UNIT_PRICE   NUMBER(8,2),
 QUANTITY     NUMBER(8)
 );
 
@/home/oracle/labs/PERF_script_pdb1_orders.sql
@/home/oracle/labs/PERF_script_pdb1_order_items.sql

EXIT
EOF
