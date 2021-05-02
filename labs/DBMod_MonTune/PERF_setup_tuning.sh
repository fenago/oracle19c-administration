#!/bin/sh
# use bash shell
#

#

export ORACLE_SID=orclcdb
ORAENV_ASK="NO"
. oraenv
ORAENV_ASK=""
#
cd /home/oracle/labs/DBMod_MonTune
$ORACLE_HOME/bin/sqlplus -s /nolog  <<EOF

conn sys/fenago@orclpdb1 as sysdba 
DROP TABLESPACE tbs_app INCLUDING CONTENTS and DATAFILES;
create tablespace TBS_APP datafile '/u01/app/oracle/oradata/ORCLCDB/orclpdb1/tbs_app01.dbf' size 800M autoextend on next 25M maxsize 1600M;
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
 
CREATE OR REPLACE EDITIONABLE TYPE "OE"."CUST_ADDRESS_TYP"
  AS OBJECT
    ( street_address	 VARCHAR2(40)
    , postal_code	 VARCHAR2(10)
    , city		 VARCHAR2(30)
    , state_province	 VARCHAR2(10)
    , country_id	 CHAR(2)
    );
/

CREATE OR REPLACE EDITIONABLE TYPE "OE"."PHONE_LIST_TYP"
  AS VARRAY(5) OF VARCHAR2(25);
/

create table oe.customers  (
 CUSTOMER_ID		NUMBER(6),
 CUST_FIRST_NAME	VARCHAR2(20),
 CUST_LAST_NAME 	VARCHAR2(20),
 CUST_ADDRESS		OE.CUST_ADDRESS_TYP,
 PHONE_NUMBERS		OE.PHONE_LIST_TYP,
 NLS_LANGUAGE		VARCHAR2(3),
 NLS_TERRITORY		VARCHAR2(30),
 CREDIT_LIMIT		NUMBER(9,2),
 CUST_EMAIL			VARCHAR2(40),
 ACCOUNT_MGR_ID 	NUMBER(6),
 CUST_GEO_LOCATION	MDSYS.SDO_GEOMETRY,
 DATE_OF_BIRTH      DATE,
 MARITAL_STATUS 	VARCHAR2(20),
 GENDER 			VARCHAR2(1),
 INCOME_LEVEL		VARCHAR2(20)
 );
 
create table oe.inventories (
  PRODUCT_ID     NUMBER(6),
  WAREHOUSE_ID	 NUMBER(3),
  QUANTITY_ON_HAND NUMBER(8)
 );

create table oe.product_information (
 PRODUCT_ID           NUMBER(6),
 PRODUCT_NAME         VARCHAR2(50),
 PRODUCT_DESCRIPTION  VARCHAR2(2000),
 CATEGORY_ID          NUMBER(2),
 WEIGHT_CLASS         NUMBER(1),
 WARRANTY_PERIOD      INTERVAL YEAR(2) TO MONTH,
 SUPPLIER_ID          NUMBER(6),
 PRODUCT_STATUS       VARCHAR2(20),
 LIST_PRICE           NUMBER(8,2),
 MIN_PRICE            NUMBER(8,2),
 CATALOG_URL          VARCHAR2(50)
 );

CREATE SEQUENCE oe.orders_seq START WITH 10 MAXVALUE 999999999999;

ALTER TABLE "OE"."ORDERS" MODIFY ( "ORDER_TOTAL" NUMBER(12, 2) );

@/home/oracle/labs/DBMod_MonTune/PERF_script_customers.sql
@/home/oracle/labs/DBMod_MonTune/PERF_script_product_information.sql
drop table oe.lineorder;
create table oe.lineorder
(LO_ORDERKEY number,
LO_LINENUMBER number,
LO_CUSTKEY number,
LO_PARTKEY number,
LO_SUPPKEY number,
LO_ORDERDATE number,
LO_ORDERPRIORITY char(15),
LO_SHIPPRIORITY char(1),
LO_QUANTITY number,
LO_EXTENDEDPRICE number,
LO_ORDTOTALPRICE number,
LO_DISCOUNT number,
LO_REVENUE number,
LO_SUPPLYCOST number,
LO_TAX number,
LO_COMMITDATE number,
LO_SHIPMODE char(10) );

drop table oe.part;
create table oe.part (
P_PARTKEY number,
P_NAME varchar(22),
P_MFGR char(6),
P_CATEGORY char(7),
P_BRAND1 char(9),
P_COLOR varchar(11),
P_TYPE varchar(25),
P_SIZE number,
P_CONTAINER char(10)) ;

drop table oe.supplier;
create table oe.supplier (
S_SUPPKEY number,
S_NAME char(25),
S_ADDRESS varchar(25),
S_CITY char(10),
S_NATION char(15),
S_REGION char(12),
S_PHONE char(15))  ;

drop table oe.customer;
create table oe.customer (
C_CUSTKEY number,
C_NAME varchar(25),
C_ADDRESS varchar(25),
C_CITY char(10),
C_NATION char(15),
C_REGION char(12),
C_PHONE char(15),
C_MKTSEGMENT char(10)) ;

drop table oe.date_dim;
create table oe.date_dim (
D_DATEKEY number,
D_DATE char(18),
D_DAYOFWEEK char(10),
D_MONTH char(9),
D_YEAR number,
D_YEARMONTHNUM number,
D_YEARMONTH char(7),
D_DAYNUMINWEEK number,
D_DAYNUMINMONTH number,
D_DAYNUMINYEAR number,
D_MONTHNUMINYEAR number,
D_WEEKNUMINYEAR number,
D_SELLINGSEASON char(12),
D_LASTDAYINWEEKFL char(1),
D_LASTDAYINMONTHFL char(1),
D_HOLIDAYFL char(1),
D_WEEKDAYFL char(1))  ;

host sqlldr oe/fenago@orclpdb1  control=/home/oracle/labs/DBMod_MonTune/PERF_control_part.ctl
insert /*+ append */ into oe.part  select p_partkey + 200001, P_NAME,P_MFGR,
                  P_CATEGORY,P_BRAND1,P_COLOR,P_TYPE,P_SIZE,P_CONTAINER
				  FROM oe.part;
commit;
insert /*+ append */ into oe.part  select p_partkey + 400002, P_NAME,P_MFGR,
                  P_CATEGORY,P_BRAND1,P_COLOR,P_TYPE,P_SIZE,P_CONTAINER
				  FROM oe.part;
commit;
insert /*+ append */ into oe.part  select p_partkey + 800004, P_NAME,P_MFGR,
                  P_CATEGORY,P_BRAND1,P_COLOR,P_TYPE,P_SIZE,P_CONTAINER
				  FROM oe.part;
commit;

host sqlldr oe/fenago@orclpdb1 control=/home/oracle/labs/DBMod_MonTune/PERF_control_date.ctl

@/home/oracle/labs/DBMod_MonTune/PERF_script_pdb1_inventories.sql
@/home/oracle/labs/DBMod_MonTune/PERF_script_pdb1_orders.sql
@/home/oracle/labs/DBMod_MonTune/PERF_script_pdb1_order_items.sql

host sqlldr oe/fenago@orclpdb1 control=/home/oracle/labs/DBMod_MonTune/PERF_control_lineorder.ctl
host sqlldr oe/fenago@orclpdb1 control=/home/oracle/labs/DBMod_MonTune/PERF_control_supplier.ctl
host sqlldr oe/fenago@orclpdb1 control=/home/oracle/labs/DBMod_MonTune/PERF_control_customer.ctl

insert /*+ append */ into oe.supplier select S_SUPPKEY + 2001, S_NAME, S_ADDRESS, S_CITY ,  S_NATION, S_REGION	, S_PHONE from oe.supplier;
commit;	 
insert  /*+ append */ into oe.supplier select S_SUPPKEY + 4002, S_NAME, S_ADDRESS, S_CITY , S_NATION, S_REGION	, S_PHONE from oe.supplier;
commit;	 
insert  /*+ append */ into oe.supplier select S_SUPPKEY + 8004, S_NAME, S_ADDRESS, S_CITY , S_NATION, S_REGION	, S_PHONE from oe.supplier;
commit;	 

insert  /*+ append */ into oe.customer select C_CUSTKEY+30001, C_NAME ,C_ADDRESS, C_CITY , C_NATION, C_REGION,C_PHONE,C_MKTSEGMENT	from oe.customer;
commit;
insert  /*+ append */ into oe.customer select C_CUSTKEY+60002, C_NAME ,C_ADDRESS, C_CITY , C_NATION, C_REGION,C_PHONE,C_MKTSEGMENT	from oe.customer;
commit;
insert  /*+ append */ into oe.customer select C_CUSTKEY+120004, C_NAME ,C_ADDRESS, C_CITY , C_NATION, C_REGION,C_PHONE,C_MKTSEGMENT from oe.customer;
commit;

insert /*+ append */ into oe.lineorder select 
LO_ORDERKEY	+6000001,  LO_LINENUMBER	,
 LO_CUSTKEY	+ 120004,  LO_PARTKEY	+120004,
 LO_SUPPKEY	+64032,  LO_ORDERDATE + 100		,
 LO_ORDERPRIORITY		,  LO_SHIPPRIORITY	,  LO_QUANTITY	,
 LO_EXTENDEDPRICE	,  LO_ORDTOTALPRICE,  LO_DISCOUNT	,
 LO_REVENUE  *  10	,  LO_SUPPLYCOST * 100	,  LO_TAX 		+100,
 LO_COMMITDATE + 200		,  LO_SHIPMODE		
 from OE.lineorder;
commit;
insert /*+ append */ into oe.lineorder select 
LO_ORDERKEY	+12000001,  LO_LINENUMBER	,
 LO_CUSTKEY	+ 120004,  LO_PARTKEY	+420033,
 LO_SUPPKEY	+64032,  LO_ORDERDATE + 101		,
 LO_ORDERPRIORITY		,  LO_SHIPPRIORITY	,  LO_QUANTITY	,
 LO_EXTENDEDPRICE	,  LO_ORDTOTALPRICE,  LO_DISCOUNT	,
 LO_REVENUE  *  12	,  LO_SUPPLYCOST * 100	,  LO_TAX +323,
 LO_COMMITDATE + 400		,  LO_SHIPMODE		
 from oe.lineorder;
commit;
insert /*+ append */ into oe.lineorder select 
LO_ORDERKEY	+24000002,  LO_LINENUMBER	,
 LO_CUSTKEY	+ 11,  LO_PARTKEY	+33,
 LO_SUPPKEY	+21,  LO_ORDERDATE + 11		,
 LO_ORDERPRIORITY		,  LO_SHIPPRIORITY	,  LO_QUANTITY	,
 LO_EXTENDEDPRICE	,  LO_ORDTOTALPRICE,  LO_DISCOUNT	,
 LO_REVENUE  *  3	,  LO_SUPPLYCOST * 2	,  LO_TAX +33,
 LO_COMMITDATE + 2		,  LO_SHIPMODE		
 from oe.lineorder;
commit;

conn sys/fenago@orclpdb2 as sysdba 
DROP TABLESPACE tbs_app INCLUDING CONTENTS AND DATAFILES;
create tablespace TBS_APP datafile '/u01/app/oracle/oradata/ORCLCDB/orclpdb2/tbs_app01.dbf' size 800M;
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
 
CREATE OR REPLACE EDITIONABLE TYPE "OE"."CUST_ADDRESS_TYP"
  AS OBJECT
    ( street_address	 VARCHAR2(40)
    , postal_code	 VARCHAR2(10)
    , city		 VARCHAR2(30)
    , state_province	 VARCHAR2(10)
    , country_id	 CHAR(2)
    );
/

CREATE OR REPLACE EDITIONABLE TYPE "OE"."PHONE_LIST_TYP"
  AS VARRAY(5) OF VARCHAR2(25);
/

create table oe.customers  (
 CUSTOMER_ID		NUMBER(6),
 CUST_FIRST_NAME	VARCHAR2(20),
 CUST_LAST_NAME 	VARCHAR2(20),
 CUST_ADDRESS		OE.CUST_ADDRESS_TYP,
 PHONE_NUMBERS		OE.PHONE_LIST_TYP,
 NLS_LANGUAGE		VARCHAR2(3),
 NLS_TERRITORY		VARCHAR2(30),
 CREDIT_LIMIT		NUMBER(9,2),
 CUST_EMAIL			VARCHAR2(40),
 ACCOUNT_MGR_ID 	NUMBER(6),
 CUST_GEO_LOCATION	MDSYS.SDO_GEOMETRY,
 DATE_OF_BIRTH      DATE,
 MARITAL_STATUS 	VARCHAR2(20),
 GENDER 			VARCHAR2(1),
 INCOME_LEVEL		VARCHAR2(20)
 );
 
create table oe.inventories (
  PRODUCT_ID     NUMBER(6),
  WAREHOUSE_ID	 NUMBER(3),
  QUANTITY_ON_HAND NUMBER(8)
 );

create table oe.product_information (
 PRODUCT_ID           NUMBER(6),
 PRODUCT_NAME         VARCHAR2(50),
 PRODUCT_DESCRIPTION  VARCHAR2(2000),
 CATEGORY_ID          NUMBER(2),
 WEIGHT_CLASS         NUMBER(1),
 WARRANTY_PERIOD      INTERVAL YEAR(2) TO MONTH,
 SUPPLIER_ID          NUMBER(6),
 PRODUCT_STATUS       VARCHAR2(20),
 LIST_PRICE           NUMBER(8,2),
 MIN_PRICE            NUMBER(8,2),
 CATALOG_URL          VARCHAR2(50)
 );

CREATE SEQUENCE oe.orders_seq START WITH 10 MAXVALUE 999999999999;

ALTER TABLE "OE"."ORDERS" MODIFY ( "ORDER_TOTAL" NUMBER(12, 2) );

@/home/oracle/labs/DBMod_MonTune/PERF_script_customers.sql
@/home/oracle/labs/DBMod_MonTune/PERF_script_product_information.sql
drop table oe.lineorder;
create table oe.lineorder
(LO_ORDERKEY number,
LO_LINENUMBER number,
LO_CUSTKEY number,
LO_PARTKEY number,
LO_SUPPKEY number,
LO_ORDERDATE number,
LO_ORDERPRIORITY char(15),
LO_SHIPPRIORITY char(1),
LO_QUANTITY number,
LO_EXTENDEDPRICE number,
LO_ORDTOTALPRICE number,
LO_DISCOUNT number,
LO_REVENUE number,
LO_SUPPLYCOST number,
LO_TAX number,
LO_COMMITDATE number,
LO_SHIPMODE char(10) );

drop table oe.part;
create table oe.part (
P_PARTKEY number,
P_NAME varchar(22),
P_MFGR char(6),
P_CATEGORY char(7),
P_BRAND1 char(9),
P_COLOR varchar(11),
P_TYPE varchar(25),
P_SIZE number,
P_CONTAINER char(10)) ;

drop table oe.supplier;
create table oe.supplier (
S_SUPPKEY number,
S_NAME char(25),
S_ADDRESS varchar(25),
S_CITY char(10),
S_NATION char(15),
S_REGION char(12),
S_PHONE char(15))  ;

drop table oe.customer;
create table oe.customer (
C_CUSTKEY number,
C_NAME varchar(25),
C_ADDRESS varchar(25),
C_CITY char(10),
C_NATION char(15),
C_REGION char(12),
C_PHONE char(15),
C_MKTSEGMENT char(10)) ;

drop table oe.date_dim;
create table oe.date_dim (
D_DATEKEY number,
D_DATE char(18),
D_DAYOFWEEK char(10),
D_MONTH char(9),
D_YEAR number,
D_YEARMONTHNUM number,
D_YEARMONTH char(7),
D_DAYNUMINWEEK number,
D_DAYNUMINMONTH number,
D_DAYNUMINYEAR number,
D_MONTHNUMINYEAR number,
D_WEEKNUMINYEAR number,
D_SELLINGSEASON char(12),
D_LASTDAYINWEEKFL char(1),
D_LASTDAYINMONTHFL char(1),
D_HOLIDAYFL char(1),
D_WEEKDAYFL char(1))  ;

host sqlldr oe/fenago@orclpdb2  control=/home/oracle/labs/DBMod_MonTune/PERF_control_part.ctl
insert /*+ append */ into oe.part  select p_partkey + 200001, P_NAME,P_MFGR,
                  P_CATEGORY,P_BRAND1,P_COLOR,P_TYPE,P_SIZE,P_CONTAINER
				  FROM oe.part;
commit;
insert /*+ append */ into oe.part  select p_partkey + 400002, P_NAME,P_MFGR,
                  P_CATEGORY,P_BRAND1,P_COLOR,P_TYPE,P_SIZE,P_CONTAINER
				  FROM oe.part;
commit;
insert /*+ append */ into oe.part  select p_partkey + 800004, P_NAME,P_MFGR,
                  P_CATEGORY,P_BRAND1,P_COLOR,P_TYPE,P_SIZE,P_CONTAINER
				  FROM oe.part;
commit;

host sqlldr oe/fenago@orclpdb2 control=/home/oracle/labs/DBMod_MonTune/PERF_control_date.ctl

@/home/oracle/labs/DBMod_MonTune/PERF_script_pdb2_inventories.sql
@/home/oracle/labs/DBMod_MonTune/PERF_script_pdb2_orders.sql
@/home/oracle/labs/DBMod_MonTune/PERF_script_pdb2_order_items.sql

host sqlldr oe/fenago@orclpdb2 control=/home/oracle/labs/DBMod_MonTune/PERF_control_lineorder.ctl
host sqlldr oe/fenago@orclpdb2 control=/home/oracle/labs/DBMod_MonTune/PERF_control_supplier.ctl
host sqlldr oe/fenago@orclpdb2 control=/home/oracle/labs/DBMod_MonTune/PERF_control_customer.ctl

insert /*+ append */ into oe.supplier select S_SUPPKEY + 2001, S_NAME, S_ADDRESS, S_CITY ,  S_NATION, S_REGION	, S_PHONE from oe.supplier;
commit;	 

insert  /*+ append */ into oe.customer select C_CUSTKEY+30001, C_NAME ,C_ADDRESS, C_CITY , C_NATION, C_REGION,C_PHONE,C_MKTSEGMENT	from oe.customer;
commit;

insert /*+ append */ into oe.lineorder select 
LO_ORDERKEY	+6000001,  LO_LINENUMBER	,
 LO_CUSTKEY	+ 120004,  LO_PARTKEY	+120004,
 LO_SUPPKEY	+64032,  LO_ORDERDATE + 100		,
 LO_ORDERPRIORITY		,  LO_SHIPPRIORITY	,  LO_QUANTITY	,
 LO_EXTENDEDPRICE	,  LO_ORDTOTALPRICE,  LO_DISCOUNT	,
 LO_REVENUE  *  10	,  LO_SUPPLYCOST * 100	,  LO_TAX 		+100,
 LO_COMMITDATE + 200		,  LO_SHIPMODE		
 from OE.lineorder;
commit;


EXIT
EOF

