#!/bin/sh
#  -- DISCLAIMER:
#  -- This script is provided for educational purposes only. It is
#  -- NOT supported by Oracle World Wide Technical Support.
#  -- The script has been tested and appears to work as intended.
#  -- You should always run new scripts on a test instance initially.
#

#
export ORACLE_SID=orclcdb
ORAENV_ASK="NO"
. oraenv
ORAENV_ASK=""
#
mkdir -p /u01/app/backup/ORCLCDB/orclpdb1
mkdir -p /u01/app/backup/ORCLCDB/orclpdb2
$ORACLE_HOME/bin/sqlplus /nolog>> /tmp/setup.log 2>&1 <<EOF
connect sys/fenago@orclpdb1 as sysdba

-- CLEANUP from previous run
DROP USER bar CASCADE;
DROP TABLESPACE bartbs INCLUDING CONTENTS AND DATAFILES;

-- Create tablespace
CREATE TABLESPACE bartbs
DATAFILE '/u01/app/backup/ORCLCDB/orclpdb1/bartbs.dbf' SIZE 50M REUSE
SEGMENT SPACE MANAGEMENT MANUAL;

-- Create user
CREATE USER BAR IDENTIFIED BY fenago 
DEFAULT TABLESPACE bartbs
QUOTA UNLIMITED ON bartbs;

GRANT CREATE SESSION TO BAR;

-- create table and populate 
-- be sure table is at least 2 blocks long
CREATE TABLE BAR.barcopy
TABLESPACE bartbs
AS SELECT * FROM HR.EMPLOYEES;

INSERT INTO BAR.BARCOPY
SELECT * FROM BAR.BARCOPY;

INSERT INTO BAR.BARCOPY
SELECT * FROM BAR.BARCOPY;

connect / as sysdba
ALTER SYSTEM SWITCH logfile;
connect sys/fenago@orclpdb1 as sysdba
ALTER SYSTEM checkpoint;
EOF

echo "Setup done." >> /tmp/setup.log
echo "Setup done."
