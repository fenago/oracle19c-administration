# Written by: Dominique.Jeunot@oracle.com
#
export ORACLE_HOME=/u01/app/oracle/product/18.0.0/dbhome_1
export ORACLE_SID=ORCL
$ORACLE_HOME/bin/sqlplus hr/Pass4HR@pdb1 <<EOF
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
