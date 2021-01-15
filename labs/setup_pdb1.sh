#!/bin/sh
# use bash shell
#

export ORACLE_HOME=/u01/app/oracle/product/19.3.0/dbhome_1
export ORACLE_SID=fenagodb
PATH=$ORACLE_HOME/bin:$PATH; export PATH
mkdir -p /u01/app/oracle/oradata/FENAGODB/fenagodb1
$ORACLE_HOME/bin/sqlplus -s /nolog  <<EOF
conn sys/fenago@fenagodb1 as sysdba 
create tablespace TBS_APP datafile '/u02/oradata/FENAGODB/fenagodb1/tbs_app01.dbf' size 800M;
drop user oe cascade;
create user oe identified by fenago default tablespace tbs_app;
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
 
@/home/oracle/labs/PERF_script_fenagodb1_orders.sql
@/home/oracle/labs/PERF_script_fenagodb1_order_items.sql

EXIT
EOF
