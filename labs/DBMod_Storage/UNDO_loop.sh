#!/bin/sh
# use bash shell
#
# Written by: Dominique.Jeunot@oracle.com
# modified by darryl.balaski@oracle.com

export ORACLE_SID=orclcdb
ORAENV_ASK="NO"
. oraenv
ORAENV_ASK=""

cd $HOME/labs/DBMod_Storage

a=0

while [ $a -lt 20000 ]
do
$ORACLE_HOME/bin/sqlplus -s /nolog  <<EOF
CONNECT odr/cloud_4U@orclpdb1
start PERF_loop.sql
start PERF_loop.sql
start PERF_loop.sql
start PERF_loop.sql
start PERF_loop.sql
start PERF_loop.sql
start PERF_loop.sql
start PERF_loop.sql

EXIT
EOF
if [ $a -eq  10000 ]
   then
      break
   fi
   a=`expr $a + 1`
done
