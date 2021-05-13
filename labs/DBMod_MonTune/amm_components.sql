REM "************************** "
REM "For training purposes ONLY, execute as the oracle OS user

set echo on
set serveroutput on
set term on
set lines 200
set pages 100
set heading on
column comp format a20
column final_size format 999999999
column oper_type format a9
set pause on pause "Press [Enter] to continue..."

SELECT substr(COMPONENT, 0, 20) COMP, CURRENT_SIZE CS, USER_SPECIFIED_SIZE US 
 FROM v$memory_dynamic_components 
WHERE CURRENT_SIZE!=0;
pause Press [Enter] to continue...

SELECT substr(COMPONENT,0,20) comp, FINAL_SIZE, OPER_TYPE, OPER_MODE, status 
 FROM v$memory_resize_ops 
ORDER BY  START_TIME desc;

pause Press [Enter] to exit the script...
set pause off
