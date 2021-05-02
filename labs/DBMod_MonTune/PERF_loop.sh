#!/bin/sh
# use bash shell
#


#
export ORACLE_SID=orclcdb
ORAENV_ASK="NO"
. oraenv
ORAENV_ASK=""
#
a=0

while [ $a -lt 30000 ]
do
$ORACLE_HOME/bin/sqlplus -s /nolog  <<EOF
CONNECT oe/fenago@orclpdb1
start $HOME/labs/DBMod_MonTune/PERF_loop.sql
start $HOME/labs/DBMod_MonTune/PERF_loop.sql
start $HOME/labs/DBMod_MonTune/PERF_loop.sql
start $HOME/labs/DBMod_MonTune/PERF_loop.sql
start $HOME/labs/DBMod_MonTune/PERF_loop.sql
start $HOME/labs/DBMod_MonTune/PERF_loop.sql
start $HOME/labs/DBMod_MonTune/PERF_loop.sql
start $HOME/labs/DBMod_MonTune/PERF_loop.sql

CONNECT system/fenago@orclpdb2
start $HOME/labs/DBMod_MonTune/PERF_loop.sql
start $HOME/labs/DBMod_MonTune/PERF_loop.sql
start $HOME/labs/DBMod_MonTune/PERF_loop.sql
start $HOME/labs/DBMod_MonTune/PERF_loop.sql
start $HOME/labs/DBMod_MonTune/PERF_loop.sql
start $HOME/labs/DBMod_MonTune/PERF_loop.sql
start $HOME/labs/DBMod_MonTune/PERF_loop.sql
start $HOME/labs/DBMod_MonTune/PERF_loop.sql
EXIT
EOF
if [ $a -eq  10000 ]
   then
      break
   fi
   a=`expr $a + 1`
done
