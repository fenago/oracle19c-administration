#!/bin/sh
# use bash shell
#

# mod by James.Spiller@oracle.com

#
export ORACLE_SID=orclcdb
ORAENV_ASK="NO"
. oraenv
ORAENV_ASK=""
#
mkdir -p /u01/app/oracle/oradata/ORCLCDB/orclpdb3
cd $HOME/labs/DBMod_PDBs
$ORACLE_HOME/bin/sqlplus "/ as sysdba" @create_pdb3.sql
# add pdb3 to tnsnames.ora
if grep -iq pdb3 "$ORACLE_HOME/network/admin/tnsnames.ora" 
   then 
      echo "PDB3 exists in the tnsnames.ora file"
   else
      cat orclpdb3.ora >> $ORACLE_HOME/network/admin/tnsnames.ora 
fi
read -sp "Input the SYSTEM user password: " passvar 
$ORACLE_HOME/bin/sqlplus "system/$passvar@pdb3" @cr_user_test.sql

