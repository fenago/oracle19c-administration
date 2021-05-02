#! /bin/bash

# reset_netsvcs.sh
# reset oratab, listener.ora, tnsnames.ora, DB parameters, Stop CMAN

export ORACLE_SID=orclcdb
ORAENV_ASK="NO"
. oraenv
ORAENV_ASK=""

#stop LISTENER2

lsnrctl stop LISTENER2


cp $ORACLE_HOME/network/admin/listener.old $ORACLE_HOME/network/admin/listener.ora

# Reset tnsnames.ora
cp $ORACLE_HOME/network/admin/tnsnames.old $ORACLE_HOME/network/admin/tnsnames.ora

# reset DB parameters
sqlplus / as sysdba <<EOF
ALTER SYSTEM set LOCAL_LISTENER=LISTENER_ORCLCDB SCOPE=BOTH;
ALTER SYSTEM reset REMOTE_LISTENER SCOPE=BOTH;
ALTER SYSTEM set DISPATCHERS="(PROTOCOL=TCP) (SERVICE=orclcdbXDB)" SCOPE=BOTH;
EXIT
EOF 

export ORACLE_SID=client
ORAENV_ASK="NO"
. oraenv
ORAENV_ASK=""

#stop cman
cmctl shutdown

cd /home/oracle

rm -rf trace
rm -rf logs

$ORACLE_HOME/deinstall/deinstall -silent -paramfile /home/oracle/labs/DBMod_NetSvcs/deinstallclient.rsp 

rm -rf /stage/client

#remove client from /etc/oratab

sed '/client/d' /etc/oratab > /tmp/oratab
cp /tmp/oratab /etc/oratab

