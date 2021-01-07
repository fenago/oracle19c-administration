#!/bin/sh
# use bash shell
#
# Written by: Dominique.Jeunot@oracle.com
#

export ORACLE_HOME=/u01/app/oracle/product/18.0.0/dbhome_1
export ORACLE_SID=ORCL
PATH=$ORACLE_HOME/bin:$PATH; export PATH

$ORACLE_HOME/bin/sqlplus -s /nolog  <<EOF

conn sys/DBAdmin_1@pdb1 as sysdba
drop tablespace TBS_APP including contents and datafiles; 
create tablespace TBS_APP datafile '/u02/app/oracle/oradata/ORCL/PDB1/tbs_app01.dbf' size 800M;
drop tablespace TBS_APP2 including contents and datafiles;
create tablespace TBS_APP2 datafile '/u02/app/oracle/oradata/ORCL/PDB1/tbs_app02.dbf' size 100M;
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
 ) tablespace tbs_app2;
 
CREATE SEQUENCE oe.orders_seq START WITH 10 MAXVALUE 999999999999;
ALTER TABLE oe.orders ADD primary key (order_id);

CREATE INDEX oe.i_order_items ON oe.order_items(ORDER_ID);
ALTER TABLE "OE"."ORDERS" MODIFY ( "ORDER_TOTAL" NUMBER(12, 2) );

@/home/oracle/labs/PERF_script_pdb1_orders.sql
@/home/oracle/labs/PERF_script_pdb1_order_items.sql

conn sys/DBAdmin_1@pdb2 as sysdba
drop tablespace TBS_APP including contents and datafiles; 
create tablespace TBS_APP datafile '/u02/app/oracle/oradata/ORCL/PDB2/tbs_app01.dbf' size 800M;
drop user sh cascade;
create user sh identified by DBAdmin_1 default tablespace tbs_app;
grant create session, dba to sh;

create table sh.inventories (
  PRODUCT_ID     NUMBER(6),
  WAREHOUSE_ID	 NUMBER(3) ,
  QUANTITY_ON_HAND NUMBER(8),
  CONSTRAINT ck_warehouse_id CHECK (WAREHOUSE_ID between 500 and 520)
 );
alter table sh.inventories disable CONSTRAINT ck_warehouse_id;

create table sh.products ( PRODUCT_ID NUMBER(6), COUNTRY  CHAR(3), LABEL VARCHAR(10), DETAILED_LABEL VARCHAR(20) );

@/home/oracle/labs/DP_script_products.sql
@/home/oracle/labs/RMAN_script_pdb2_inventories.sql

EXIT
EOF

