#!/bin/sh
# use bash shell
#
# Written by:  Dominique Jeunot
#

export ORACLE_HOME=/u01/app/oracle/product/12.2.0/dbhome_1
export ORACLE_SID=ORCL
PATH=$ORACLE_HOME/bin:$PATH; export PATH
$ORACLE_HOME/bin/sqlplus -s /nolog  <<EOF
CONNECT sys/oracle_4U@pdb1 AS SYSDBA
CREATE TABLESPACE users DATAFILE '/u01/app/oracle/oradata/ORCL/pdb1/users01.dbf' size 10m;
start $HOME/labs/PERF_hr_main.sql
drop user NGREENBERG cascade;
create user NGREENBERG identified by oracle_4U;
grant create session to NGREENBERG;

drop user SMAVRIS cascade;
create user SMAVRIS identified by oracle_4U;
grant create session to SMAVRIS;

grant select, update on hr.employees to NGREENBERG,  SMAVRIS;

EXIT
EOF
