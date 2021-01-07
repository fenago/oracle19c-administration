#!/bin/sh
# use bash shell
#
# Written by: Dominique.Jeunot@oracle.com
#

export ORACLE_HOME=/u01/app/oracle/product/18.0.0/dbhome_1
export ORACLE_SID=ORCL
PATH=$ORACLE_HOME/bin:$PATH; export PATH
a=0

while [ $a -lt 10000 ]
do
$ORACLE_HOME/bin/sqlplus -s /nolog  <<EOF
CONNECT oe/DBAdmin_1@pdb1
start $HOME/labs/PERF_loop.sql
start $HOME/labs/PERF_loop.sql
start $HOME/labs/PERF_loop.sql
start $HOME/labs/PERF_loop.sql
start $HOME/labs/PERF_loop.sql
start $HOME/labs/PERF_loop.sql
start $HOME/labs/PERF_loop.sql
start $HOME/labs/PERF_loop.sql

CONNECT system/DBAdmin_1@pdb2
start $HOME/labs/PERF_loop.sql
start $HOME/labs/PERF_loop.sql
start $HOME/labs/PERF_loop.sql
start $HOME/labs/PERF_loop.sql
start $HOME/labs/PERF_loop.sql
start $HOME/labs/PERF_loop.sql
start $HOME/labs/PERF_loop.sql
start $HOME/labs/PERF_loop.sql
EXIT
EOF
if [ $a -eq  10000 ]
   then
      break
   fi
   a=`expr $a + 1`
done
