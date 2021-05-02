#!/bin/sh
#  -- DISCLAIMER:
#  -- This script is provided for educational purposes only. It is
#  -- NOT supported by Oracle World Wide Technical Support.
#  -- The script has been tested and appears to work as intended.
#  -- You should always run new scripts on a test instance initially.
#  -- Run as ORACLE OS user

#  -- rman target / > /tmp/cleanup.log 2>&1 <<EOF
#  -- delete NOPROMPT copy of tablespace bartbs;
#  -- exit;
#  -- EOF
#

#
export ORACLE_SID=orclcdb
ORAENV_ASK="NO"
. oraenv
ORAENV_ASK=""
#

$ORACLE_HOME/bin/sqlplus -S /nolog >> /tmp/cleanup.log 2>&1 <<EOF
connect sys/fenago@orclpdb1 as sysdba

-- CLEANUP from previous run
DROP USER bar CASCADE;
DROP TABLESPACE bartbs INCLUDING CONTENTS AND DATAFILES;
drop directory dp_for_oe;
EXIT;
EOF


# . $LABS/set_rcat.sh >> /tmp/cleanup.log
$ORACLE_HOME/bin/sqlplus -S /nolog >> /tmp/cleanup.log 2>&1 <<EOF
connect sys/fenago@orclpdb2 as sysdba

-- CLEANUP from previous run
DROP USER bar CASCADE;
DROP TABLESPACE bartbs INCLUDING CONTENTS AND DATAFILES;
drop directory dp_for_oe;
EXIT;
EOF


rm -f /u01/app/backup/test.dmp
rm -f /u01/app/backup/test.bck
rm -rf /u01/app/backup/ORCLCDB
echo 'Cleanup complete.' >> /tmp/cleanup.log
echo 'Cleanup complete.'
