#!/bin/sh
# use bash shell
#
# Written by: Dominique.Jeunot@oracle.com
# modified by darryl.balaski@oracle.com
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
CONNECT oe/cloud_4U@orclpdb1
start $HOME/labs/DBMod_MonTune/PERF_loop.sql
start $HOME/labs/DBMod_MonTune/PERF_loop.sql
start $HOME/labs/DBMod_MonTune/PERF_loop.sql
start $HOME/labs/DBMod_MonTune/PERF_loop.sql
start $HOME/labs/DBMod_MonTune/PERF_loop.sql
start $HOME/labs/DBMod_MonTune/PERF_loop.sql
start $HOME/labs/DBMod_MonTune/PERF_loop.sql
start $HOME/labs/DBMod_MonTune/PERF_loop.sql

CONNECT system/cloud_4U@orclpdb2
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
