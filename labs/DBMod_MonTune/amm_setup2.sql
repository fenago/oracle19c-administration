REM "************************** "
REM "For training purposes ONLY
REM  Connected as the AMM user with the oracle_4U password
set echo on
set serveroutput on
set term on
set lines 200
set pages 44
set pause on pause "Press [Enter] to continue..."
drop table tabsga purge;

create table tabsga(a number, b number) tablespace tbssga;

begin
  for i in 1..100000 loop
    insert into tabsga values (i, i);
  end loop;
end;
/
commit;
pause Press [Enter] to continue...

alter table tabsga parallel 64;

create or replace procedure testpga( psize number ) as
begin
declare
  TYPE nAllotment_tabtyp    IS TABLE OF char(2048) INDEX BY BINARY_INTEGER;
  myarray nAllotment_tabtyp;
begin
  for i in 1..psize loop
    myarray(i) := to_char(i);
  end loop;
end;
end;
/
pause Press [Enter] to continue...

show errors

SELECT substr(COMPONENT, 0, 20) COMP, CURRENT_SIZE CS, USER_SPECIFIED_SIZE US 
  FROM v$memory_dynamic_components 
 WHERE CURRENT_SIZE!=0;

pause Press [Enter] to exit the script...
set pause off

