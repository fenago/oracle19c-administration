#!/bin/bash

#Reset the entire module environment after DBMod_NetSvcs practices

cd $HOME/reset/DBMod_NetSvcs

# deinstall client

./deinstall_client.sh

#remove CDBTEST Database
./dropCDBTEST.sh

# reset network configuration
./reset_tnsnames.sh

# reset initparameters by restart orclcdb database
ORACLE_SID=orclcdb
ORAENV_ASK="NO"
. oraenv
ORAENV_ASK=""

sqlplus / as sysdba <<EOF

ALTER SYSTEM SET DISPATCHERS='(PROTOCOL=tcp)(SERVICE=orclcdbXDB)' SCOPE=BOTH;
shutdown immediate
startup
EOF

