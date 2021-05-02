
#
export ORACLE_SID=orclcdb
ORAENV_ASK="NO"
. oraenv
ORAENV_ASK=""

$ORACLE_HOME/bin/sqlplus hr/fenago@orclpdb1 <<EOF
col index_name format A18
drop table hr.test;
create table hr.test (c1 number, c2 number) tablespace users;
insert into hr.test values (1,1);
insert into hr.test select * from hr.test;
/
/
/
/
/
/
/
/
/
/
/
/
/
/
/
/
/
/
insert into hr.test values (2,2);
commit;
create index hr.i_test on hr.test(c1) tablespace users;
SET ECHO ON
SELECT index_name, compression from user_indexes
WHERE  index_name = 'I_TEST';
EXIT
EOF
