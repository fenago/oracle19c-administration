#!/bin/sh
# use bash shell
#
# Written by: Jody Glover
#

export ORACLE_HOME=/u01/app/oracle/product/18.0.0/dbhome_1
export ORACLE_SID=ORCL
PATH=$ORACLE_HOME/bin:$PATH; export PATH
$ORACLE_HOME/bin/sqlplus -s /nolog  <<EOF

CONNECT sys/DBAdmin_1@pdb1 AS SYSDBA
drop user NGREENBERG cascade;
create user NGREENBERG identified by DBAdmin_1;
grant create session to NGREENBERG;

drop user SMAVRIS cascade;
create user SMAVRIS identified by DBAdmin_1;
grant create session to SMAVRIS;

grant select, update on hr.employees to NGREENBERG,  SMAVRIS;

EXIT
EOF
