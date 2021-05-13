REM "************************** "
REM "For training purposes ONLY, execute as the oracle OS user

set echo on
set serveroutput on
set term on
set lines 200
set pages 44
set pause on pause "Press [Enter] to continue..."

drop tablespace tbssga including contents and datafiles;

create tablespace tbssga datafile '/u01/app/oracle/oradata/ORCLCDB/tbssga01.dbf' size 20m;

drop tablespace mytemp including contents and datafiles;

create temporary tablespace mytemp tempfile '/u01/app/oracle/oradata/ORCLCDB/mytemp01.dbf' size 40m reuse;

REM drop user amm cascade;

REM create user amm identified by fenago default tablespace tbssga temporary tablespace mytemp;

REM grant connect,resource,dba to amm;
pause Press [Enter] to continue...

column COMP format a20

SELECT substr(COMPONENT, 0, 20) COMP, CURRENT_SIZE CS, USER_SPECIFIED_SIZE US 
  FROM v$memory_dynamic_components 
 WHERE CURRENT_SIZE!=0;
pause Press [Enter] to continue...

