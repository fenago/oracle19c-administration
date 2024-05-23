
# Step-by-Step Lab: Monitoring the CDB fenagoCDB from the Command Line and Launching DBCA GUI

## Prerequisites
- Ensure that the Oracle Database software is installed.
- The CDB named fenagoCDB should be created and running.
- Set the ORACLE_HOME and ORACLE_SID environment variables appropriately.

## Steps

### 1. Set Environment Variables
```bash
export ORACLE_HOME=/u01/app/oracle/product/19.3.0/dbhome_1
export ORACLE_SID=fenagoCDB
```

### 2. Connect to SQL*Plus as SYSDBA
```sql
sqlplus / as sysdba
```

### 3. Monitor the CDB

#### Check the status of the CDB
```sql
SELECT name, open_mode, cdb FROM V$DATABASE;
```

#### View the instance name and status
```sql
SELECT instance_name, status FROM V$INSTANCE;
```

#### List all PDBs and their statuses
```sql
SELECT pdb_name, open_mode FROM CDB_PDBS;
```

#### View the current container
```sql
SELECT name, con_id, open_mode FROM V$CONTAINERS;
```

#### Check the sessions connected to the CDB
```sql
SELECT sid, serial#, username, status, program FROM V$SESSION;
```

#### Check the tablespace usage
```sql
SELECT tablespace_name, used_space, tablespace_size, USED_PERCENT
FROM dba_tablespace_usage_metrics;
```

#### Monitor the undo tablespace usage
```sql
SELECT tablespace_name, used_blocks, free_blocks
FROM v$undostat;
```

#### View alert log messages
```bash
tail -f $ORACLE_HOME/diag/rdbms/fenagoCDB/alert_fenagoCDB.log
```

### 4. Launch the DBCA GUI in a New Terminal
1. Right-click on the desktop and select "Open Terminal Here".
2. In the new terminal, run the following commands:
```bash
xhost +
su - oracle
dbca
```

### 5. Using DBCA GUI
- Follow the on-screen instructions in the DBCA (Database Configuration Assistant) to manage the CDB.

## Conclusion
You have successfully monitored the CDB fenagoCDB from the command line and launched the DBCA GUI for further database management.
