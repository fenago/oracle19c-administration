rem
rem Header: hr_main.sql 2015/03/19 10:23:26 smtaylor Exp $
rem
rem
rem NAME
rem   hr_main.sql - Main script for HR schema
rem
rem DESCRIPTON
rem   HR (Human Resources) is the smallest and most simple one 
rem   of the Sample Schemas
rem   
rem NOTES
rem   Run as SYS or SYSTEM
rem
rem MODIFIED   (MM/DD/YY)
rem   celsbern  03/10/16 - removing grant to sys.dbms_stats
rem   dmatisha  10/09/15 - added check to see if hr user exists 
rem       before dropping the hr user.
rem   dmatisha  10/08/15 - removed connect string, sys password, 
rem       changed to use alter session current_schema=hr instead
rem       of reconnecting. You now MUST be connected as sys 
rem       prior to running this script. Modified log parameter 
rem       from &log_path.hr_main.log to &log_path/hr_main.log 
rem   smtaylor  03/19/15 - added parameter 6, connect_string
rem   smtaylor  03/19/15 - added @&connect_string to CONNECT
rem   jmadduku  02/18/11 - Grant Unlimited Tablespace priv with RESOURCE
rem   celsbern  06/17/10 - fixing bug 9733839
rem   pthornto  07/16/04 - obsolete 'connect' role 
rem   hyeh      08/29/02 - hyeh_mv_comschema_to_rdbms
rem   ahunold   08/28/01 - roles
rem   ahunold   07/13/01 - NLS Territory
rem   ahunold   04/13/01 - parameter 5, notes, spool
rem   ahunold   03/29/01 - spool
rem   ahunold   03/12/01 - prompts
rem   ahunold   03/07/01 - hr_analz.sql
rem   ahunold   03/03/01 - HR simplification, REGIONS table
rem   ngreenbe  06/01/00 - created

SET ECHO OFF
SET VERIFY OFF

REM =======================================================
REM cleanup section
REM =======================================================

DECLARE
vcount INTEGER :=0;
BEGIN
select count(1) into vcount from dba_users where username = 'HR';
IF vcount != 0 THEN
EXECUTE IMMEDIATE ('DROP USER hr CASCADE');
END IF;
END;
/

REM =======================================================
REM create user
REM three separate commands, so the create user command 
REM will succeed regardless of the existence of the 
REM DEMO and TEMP tablespaces 
REM =======================================================

CREATE USER hr IDENTIFIED BY oracle_4U;

ALTER USER hr DEFAULT TABLESPACE users QUOTA UNLIMITED ON users;

ALTER USER hr TEMPORARY TABLESPACE temp;

GRANT CREATE SESSION, CREATE VIEW, ALTER SESSION, CREATE SEQUENCE TO hr;
GRANT CREATE SYNONYM, CREATE DATABASE LINK, RESOURCE , UNLIMITED TABLESPACE TO hr;

REM =======================================================
REM create hr schema objects
REM =======================================================

ALTER SESSION SET CURRENT_SCHEMA=HR;

ALTER SESSION SET NLS_LANGUAGE=American;
ALTER SESSION SET NLS_TERRITORY=America;

--
-- create tables, sequences and constraint
--

@$HOME/labs/PERF_hr_cre.sql

-- 
-- populate tables
--

@$HOME/labs/PERF_hr_popul.sql

--
-- create indexes
--

@$HOME/labs/PERF_hr_idx.sql

--
-- create procedural objects
--

@$HOME/labs/PERF_hr_code.sql

--
-- add comments to tables and columns
--

@$HOME/labs/PERF_hr_comnt.sql

--
-- gather schema statistics
--

@$HOME/labs/PERF_hr_analz.sql

