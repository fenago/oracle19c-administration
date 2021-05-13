#!/bin/sh
# use bash shell
#
# Written by:  Dominique Jeunot
# Modified by: James Spiller for 19c DBMod_PDBs

#
export ORACLE_SID=orclcdb
ORAENV_ASK="NO"
. oraenv
ORAENV_ASK=""
#
cd $HOME/labs/DBMod_PDBs

# add test to tnsnames.ora

if grep -iq "^test =" "$ORACLE_HOME/network/admin/tnsnames.ora" 
   then 
      echo "test exists in the tnsnames.ora file"
   else
      cat add_test_tns.ora >> $ORACLE_HOME/network/admin/tnsnames.ora
fi
