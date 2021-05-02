#!/bin/sh
# For training only, execute as oracle OS user

export ORACLE_SID=orclcdb
ORAENV_ASK="NO"
. oraenv
ORAENV_ASK=""

$ORACLE_HOME/bin/sqlplus /nolog <<EOF
connect / as sysdba
alter system set disk_asynch_io = FALSE scope = spfile;
shutdown immediate;
startup
alter pluggable database all open;
set echo on
conn hr/fenago@orclpdb1
create table employees1 tablespace tbsalert as select * from hr.employees;
create table employees2 tablespace tbsalert as select * from hr.employees;
create table employees3 tablespace tbsalert as select * from hr.employees;
create table employees4 tablespace tbsalert as select * from hr.employees;
create table employees5 tablespace tbsalert as select * from hr.employees;

alter table employees1 enable row movement;
alter table employees2 enable row movement;
alter table employees3 enable row movement;
alter table employees4 enable row movement;
alter table employees5 enable row movement;

BEGIN
FOR i in 1..10 LOOP
   insert into employees1 select * from employees1;
   insert into employees2 select * from employees2;
   insert into employees3 select * from employees3;
   insert into employees4 select * from employees4;
   insert into employees5 select * from employees5;
   commit;   
 END LOOP;
END;
/
insert into employees1 select * from employees1;
insert into employees2 select * from employees2;
insert into employees3 select * from employees3;
commit;
exit
EOF

