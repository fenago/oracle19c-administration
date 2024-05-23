
# Step-by-Step Lab: Creating and Managing a New Container Database (CDB) Named fenagoCB

## Prerequisites
- Ensure that the Oracle Database software is installed.
- Set the ORACLE_HOME and ORACLE_SID environment variables appropriately.

## Steps

### 1. Set Environment Variables
```bash
export ORACLE_HOME=/u01/app/oracle/product/19.3.0/dbhome_1
export ORACLE_SID=fenagoCB
```

*Explanation:* These commands set the environment variables required for Oracle to identify the correct database home and the instance to be managed.

### 2. Connect to SQL*Plus as SYSDBA
```sql
sqlplus / as sysdba
```

*Explanation:* This command connects you to the Oracle database as the SYSDBA user, which has administrative privileges.

### 3. Create the Initialization Parameter File (PFILE)
```sql
CREATE PFILE='/tmp/initfenagoCB.ora' FROM SPFILE;
```

*Explanation:* This command creates a PFILE from the SPFILE. The PFILE is a text file that contains initialization parameters for starting the database instance.

### 4. Edit the PFILE
Edit `/tmp/initfenagoCB.ora` to include the necessary parameters for creating the CDB. Ensure the following parameters are set:
```plaintext
db_name=fenagoCB
enable_pluggable_database=true
```

*Explanation:* Edit the PFILE to set the database name and enable the pluggable database feature, which allows the creation of PDBs within the CDB.

### 5. Start the Instance in NOMOUNT Mode
```sql
STARTUP NOMOUNT PFILE='/tmp/initfenagoCB.ora';
```

*Explanation:* This command starts the Oracle instance without mounting the database, allowing you to create the database structure.

### 6. Create the CDB
Execute the `CREATE DATABASE` command to create the CDB:
```sql
CREATE DATABASE fenagoCB
USER SYS IDENTIFIED BY password
USER SYSTEM IDENTIFIED BY password
LOGFILE GROUP 1 ('/u01/app/oracle/oradata/fenagoCB/redo01.log') SIZE 100M,
        GROUP 2 ('/u01/app/oracle/oradata/fenagoCB/redo02.log') SIZE 100M,
        GROUP 3 ('/u01/app/oracle/oradata/fenagoCB/redo03.log') SIZE 100M
EXTENT MANAGEMENT LOCAL
DATAFILE '/u01/app/oracle/oradata/fenagoCB/system01.dbf' SIZE 700M REUSE
SYSAUX DATAFILE '/u01/app/oracle/oradata/fenagoCB/sysaux01.dbf' SIZE 550M REUSE
DEFAULT TABLESPACE users
DEFAULT TEMPORARY TABLESPACE temp TEMPFILE '/u01/app/oracle/oradata/fenagoCB/temp01.dbf' SIZE 20M REUSE
UNDO TABLESPACE undotbs1 DATAFILE '/u01/app/oracle/oradata/fenagoCB/undotbs01.dbf' SIZE 200M REUSE
ENABLE PLUGGABLE DATABASE
SEED
  FILE_NAME_CONVERT = ('/u01/app/oracle/oradata/fenagoCB/', '/u01/app/oracle/oradata/fenagoCB/pdbseed/')
  SYSTEM DATAFILES SIZE 125M AUTOEXTEND ON NEXT 10M MAXSIZE UNLIMITED
  SYSAUX DATAFILES SIZE 100M;
```

*Explanation:* This command creates the new CDB with the specified parameters, including the log files, data files, and the default tablespaces. The `FILE_NAME_CONVERT` clause is used to specify how the data files for the PDB$SEED are created.

### 7. Create SPFILE from PFILE
```sql
CREATE SPFILE FROM PFILE='/tmp/initfenagoCB.ora';
```

*Explanation:* This command creates an SPFILE from the PFILE. The SPFILE is a binary file that stores the database initialization parameters in a persistent manner.

### 8. Restart the Database
Shutdown the instance and restart it using the newly created SPFILE:
```sql
SHUTDOWN IMMEDIATE;
STARTUP;
```

*Explanation:* These commands shut down and then restart the database using the newly created SPFILE.

### 9. Verify the CDB Creation
Query the `V$DATABASE` view to verify the CDB creation:
```sql
SELECT name, open_mode, cdb FROM V$DATABASE;
```

*Explanation:* This query verifies the creation of the CDB by checking its name, open mode, and whether it is a CDB.

## Additional Steps for Creating PFILE Manually if SPFILE is Missing
If the SPFILE is missing, you need to create the PFILE manually:

### 1. Create a PFILE Manually
Create a PFILE `/tmp/initfenagoCB.ora` with the following contents:
```bash
vi /tmp/initfenagoCB.ora
```

Add the following lines to the file:
```plaintext
db_name=fenagoCB
enable_pluggable_database=true
```

### 2. Start the Instance in NOMOUNT Mode
```sql
STARTUP NOMOUNT PFILE='/tmp/initfenagoCB.ora';
```

### 3. Create the CDB
```sql
CREATE DATABASE fenagoCB
USER SYS IDENTIFIED BY password
USER SYSTEM IDENTIFIED BY password
LOGFILE GROUP 1 ('/u01/app/oracle/oradata/fenagoCB/redo01.log') SIZE 100M,
        GROUP 2 ('/u01/app/oracle/oradata/fenagoCB/redo02.log') SIZE 100M,
        GROUP 3 ('/u01/app/oracle/oradata/fenagoCB/redo03.log') SIZE 100M
EXTENT MANAGEMENT LOCAL
DATAFILE '/u01/app/oracle/oradata/fenagoCB/system01.dbf' SIZE 700M REUSE
SYSAUX DATAFILE '/u01/app/oracle/oradata/fenagoCB/sysaux01.dbf' SIZE 550M REUSE
DEFAULT TABLESPACE users
DEFAULT TEMPORARY TABLESPACE temp TEMPFILE '/u01/app/oracle/oradata/fenagoCB/temp01.dbf' SIZE 20M REUSE
UNDO TABLESPACE undotbs1 DATAFILE '/u01/app/oracle/oradata/fenagoCB/undotbs01.dbf' SIZE 200M REUSE
ENABLE PLUGGABLE DATABASE
SEED
  FILE_NAME_CONVERT = ('/u01/app/oracle/oradata/fenagoCB/', '/u01/app/oracle/oradata/fenagoCB/pdbseed/')
  SYSTEM DATAFILES SIZE 125M AUTOEXTEND ON NEXT 10M MAXSIZE UNLIMITED
  SYSAUX DATAFILES SIZE 100M;
```

### 4. Create SPFILE from PFILE
```sql
CREATE SPFILE FROM PFILE='/tmp/initfenagoCB.ora';
```

### 5. Restart the Database
```sql
SHUTDOWN IMMEDIATE;
STARTUP;
```

### 6. Verify the CDB Creation
```sql
SELECT name, open_mode, cdb FROM V$DATABASE;
```

## Conclusion
You have successfully created a new Container Database (CDB) named fenagoCB and managed it using both standard and manual methods. These steps include setting environment variables, connecting to SQL*Plus, creating initialization parameter files, and verifying the database creation.

This guide provides a comprehensive approach to managing CDBs in Oracle, ensuring that you can handle both typical and exceptional scenarios effectively.
