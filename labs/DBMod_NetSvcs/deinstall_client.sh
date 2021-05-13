#! /bin/bash

# Deinstall the network (CMAN client)

ORACLE_SID=client
ORAENV_ASK="NO"
. oraenv
ORAENV_ASK=""

$ORACLE_HOME/deinstall/deinstall -silent -paramfile $HOME/reset/DBMod_NetSvcs/deinstall_client.rsp

rm -rf /stage/client
