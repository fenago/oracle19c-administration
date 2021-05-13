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
#
# add pdb3_orcl to tnsnames.ora
#
if grep -iq pdb3_orcl "$ORACLE_HOME/network/admin/tnsnames.ora" 
   then 
      echo "pdb3_orcl exists in the tnsnames.ora file"
   else
      cat add_pdb3_tns.ora >> $ORACLE_HOME/network/admin/tnsnames.ora
fi
