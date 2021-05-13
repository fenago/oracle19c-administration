#!/bin/sh
# use bash shell
#

# Modified by: Darryl.Balaski@oracle.com
#
export ORACLE_SID=orclcdb
ORAENV_ASK="NO"
. oraenv
ORAENV_ASK=""
#
$ORACLE_HOME/bin/sqlplus / as sysdba <<EOF
alter pluggable database all open;
alter pluggable database all save state;
EOF
#
$ORACLE_HOME/bin/sqlplus "sys/fenago@orclpdb1 as sysdba" <<EOF
drop tablespace TBS_APP including contents and datafiles; 
create tablespace TBS_APP datafile '/u01/app/oracle/oradata/ORCLCDB/orclpdb1/tbs_app01.dbf' size 800M autoextend on next 25M maxsize 1100M;
drop tablespace TBS_APP2 including contents and datafiles;
create tablespace TBS_APP2 datafile '/u01/app/oracle/oradata/ORCLCDB/orclpdb1/tbs_app02.dbf' size 100M autoextend on next 25M maxsize 300M;
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
 ) tablespace tbs_app2;
 
CREATE SEQUENCE oe.orders_seq START WITH 10 MAXVALUE 999999999999;
ALTER TABLE oe.orders ADD primary key (order_id);

CREATE INDEX oe.i_order_items ON oe.order_items(ORDER_ID);
ALTER TABLE "OE"."ORDERS" MODIFY ( "ORDER_TOTAL" NUMBER(12, 2) );

@/home/oracle/labs/DBMod_LoadTrans/PERF_script_orclpdb1_orders.sql
@/home/oracle/labs/DBMod_LoadTrans/PERF_script_orclpdb1_order_items.sql

REM added 6-26

drop user sh cascade;
create user sh identified by fenago default tablespace tbs_app;
grant create session, dba to sh;

create table sh.inventories (
  PRODUCT_ID     NUMBER(6),
  WAREHOUSE_ID   NUMBER(3) ,
  QUANTITY_ON_HAND NUMBER(8),
  CONSTRAINT ck_warehouse_id CHECK (WAREHOUSE_ID between 500 and 520)
 );
alter table sh.inventories disable CONSTRAINT ck_warehouse_id;

create table sh.products ( PRODUCT_ID NUMBER(6), COUNTRY  CHAR(3), LABEL VARCHAR(10), DETAILED_LABEL VARCHAR(20) );

@/home/oracle/labs/DBMod_LoadTrans/DP_script_products.sql
@/home/oracle/labs/DBMod_LoadTrans/RMAN_script_pdb2_inventories.sql
REM Done


conn sys/fenago@orclpdb2 as sysdba
drop tablespace TBS_APP including contents and datafiles; 
create tablespace TBS_APP datafile '/u01/app/oracle/oradata/ORCLCDB/orclpdb2/tbs_app01.dbf' size 800M autoextend on next 25M maxsize 1100M;
drop user sh cascade;
create user sh identified by fenago default tablespace tbs_app;
grant create session, dba to sh;

create table sh.inventories (
  PRODUCT_ID     NUMBER(6),
  WAREHOUSE_ID	 NUMBER(3) ,
  QUANTITY_ON_HAND NUMBER(8),
  CONSTRAINT ck_warehouse_id CHECK (WAREHOUSE_ID between 500 and 520)
 );
alter table sh.inventories disable CONSTRAINT ck_warehouse_id;

create table sh.products ( PRODUCT_ID NUMBER(6), COUNTRY  CHAR(3), LABEL VARCHAR(10), DETAILED_LABEL VARCHAR(20) );

@/home/oracle/labs/DBMod_LoadTrans/DP_script_products.sql
@/home/oracle/labs/DBMod_LoadTrans/RMAN_script_pdb2_inventories.sql

EXIT
EOF

