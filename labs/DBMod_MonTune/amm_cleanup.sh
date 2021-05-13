#!/bin/bash
# For training only, execute as oracle OS user
export ORACLE_SID=orcl

# ORAENV_ASK=NO;
# . oraenv
# ORAENV_ASK='';

sqlplus / as sysdba <<EOF!
set echo on
drop user amm cascade;
drop tablespace tbssga including contents and datafiles;
drop tablespace mytemp including contents and datafiles;

shutdown immediate;

CREATE SPFILE FROM PFILE='/tmp/initorcl.ora.bak';

startup

EOF!



