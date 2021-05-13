#! /bin/bash

# reset_DBMod_CreateDB.sh
# reset to begining any permenant artifacts created in this practice

cd /home/oracle/reset/DBMod_CreateDB

export ORACLE_SID=orclcdb
ORAENV_ASK="NO"
. oraenv
ORAENV_ASK=""

# drop DBs created
./dropCDBDEV.sh

./dropCDBTEST.sh

# drop PDBs

./drop_PDBs.sh

# reset parameters

./reset_parms.sh

#reset_tnsnames.ora

./reset_tnsnames.sh

exit

