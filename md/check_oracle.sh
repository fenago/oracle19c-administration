#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check if Oracle is installed by looking for Oracle binaries
if [ -d "/u01/app/oracle" ]; then
    echo "Oracle binaries found in /u01/app/oracle"
else
    echo "Oracle binaries not found in /u01/app/oracle"
fi

# Check for installed Oracle packages using rpm
echo "Checking for installed Oracle packages..."
rpm -qa | grep -i oracle

# Check if Oracle services are running
echo "Checking for running Oracle processes..."
ps -ef | grep -i [o]ra_ | grep -v grep

# Check the status of the Oracle listener
if command_exists lsnrctl; then
    echo "Checking Oracle listener status..."
    lsnrctl status
else
    echo "Oracle listener control utility (lsnrctl) not found"
fi

# Optionally, check for Oracle environment variables
echo "Oracle environment variables:"
env | grep -i oracle

# Print ORACLE_HOME and ORACLE_SID if set
if [ -n "$ORACLE_HOME" ]; then
    echo "ORACLE_HOME is set to $ORACLE_HOME"
else
    echo "ORACLE_HOME is not set"
fi

if [ -n "$ORACLE_SID" ]; then
    echo "ORACLE_SID is set to $ORACLE_SID"
else
    echo "ORACLE_SID is not set"
fi

echo "Script execution completed."
