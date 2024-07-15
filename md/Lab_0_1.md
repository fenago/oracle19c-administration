### Lab Instructions: Creating a CDB Named `drlee31` and Cleaning Up Existing Databases

In this lab, I will guide you through the process of deleting all existing databases except for `fenagodb` and then creating a new Container Database (CDB) named `drlee31`.

#### Prerequisites
- Ensure Oracle Database software is installed.
- Ensure Oracle environment variables are set (`ORACLE_HOME`, `PATH`, etc.).
- Sufficient privileges to manage databases.

### Part 1: Deleting All Databases Except for `fenagodb`

#### Step 1: Identify Existing Databases

1. **Check the existing databases:**

   ```bash
   lsnrctl status
   ```

2. **List the databases:**

   ```bash
   ps -ef | grep pmon
   ```

   Identify the databases other than `fenagodb`.

#### Step 2: Delete the Databases

For each database except `fenagodb`, perform the following steps:

1. **Set the Oracle SID:**

   ```bash
   export ORACLE_SID=<database_sid>
   ```

2. **Use DBCA to delete the database:**

   ```bash
   $ORACLE_HOME/bin/dbca -silent -deleteDatabase \
   -sourceDB <database_sid> \
   -sysPassword Welcome_1
   ```

   Repeat these steps for each database identified in Step 1.

### Part 2: Creating a CDB Named `drlee31`

#### Step 1: Set Up the Environment

1. **Set the Oracle SID for the new CDB:**

   ```bash
   export ORACLE_SID=drlee31
   ```

2. **Create the `initdrlee31.ora` file:**

   ```bash
   vi $ORACLE_HOME/dbs/initdrlee31.ora
   ```

   Add the following parameters:

   ```text
   DB_NAME=drlee31
   CONTROL_FILES=(/u01/app/oracle/oradata/drlee31/control01.ctl, /u01/app/oracle/oradata/drlee31/control02.ctl)
   ENABLE_PLUGGABLE_DATABASE=TRUE
   ```

#### Step 2: Start the Instance

1. **Connect to SQL*Plus as SYSDBA:**

   ```bash
   sqlplus / as sysdba
   ```

2. **Start the instance in NOMOUNT mode:**

   ```sql
   STARTUP NOMOUNT;
   ```

#### Step 3: Create the CDB

1. **Create the CDB:**

   ```sql
   CREATE DATABASE drlee31
   USER SYS IDENTIFIED BY Welcome_1
   USER SYSTEM IDENTIFIED BY Welcome_1
   LOGFILE GROUP 1 ('/u01/app/oracle/oradata/drlee31/redo1a.log', '/u02/app/oracle/oradata/drlee31/redo1b.log') SIZE 100M,
           GROUP 2 ('/u01/app/oracle/oradata/drlee31/redo2a.log', '/u02/app/oracle/oradata/drlee31/redo2b.log') SIZE 100M
   CHARACTER SET AL32UTF8
   NATIONAL CHARACTER SET AL16UTF16
   EXTENT MANAGEMENT LOCAL
   DATAFILE '/u01/app/oracle/oradata/drlee31/system01.dbf' SIZE 325M REUSE
   SYSAUX DATAFILE '/u01/app/oracle/oradata/drlee31/sysaux01.dbf' SIZE 325M REUSE
   DEFAULT TEMPORARY TABLESPACE temp TEMPFILE '/u01/app/oracle/oradata/drlee31/temp01.dbf' SIZE 20M REUSE
   UNDO TABLESPACE undotbs DATAFILE '/u01/app/oracle/oradata/drlee31/undotbs01.dbf' SIZE 200M REUSE
   ENABLE PLUGGABLE DATABASE
   SEED FILE_NAME_CONVERT=('/u01/app/oradata/drlee31/', '/u01/app/oracle/oradata/drlee31/pdbseed/');
   ```

#### Step 4: Run the CDB Scripts

1. **Run the CDB scripts:**

   ```sql
   @$ORACLE_HOME/rdbms/admin/catalog.sql
   @$ORACLE_HOME/rdbms/admin/catproc.sql
   ```

2. **Create the pluggable database:**

   ```sql
   CREATE PLUGGABLE DATABASE pdb1 ADMIN USER pdbadmin IDENTIFIED BY Welcome_1
   FILE_NAME_CONVERT = ('/u01/app/oracle/oradata/drlee31/pdbseed/', '/u01/app/oracle/oradata/drlee31/pdb1/');
   ```

3. **Open the PDB:**

   ```sql
   ALTER PLUGGABLE DATABASE pdb1 OPEN;
   ```

4. **Save the state of the PDB:**

   ```sql
   ALTER PLUGGABLE DATABASE pdb1 SAVE STATE;
   ```

### Summary

In this lab, you have learned how to delete all existing databases except for `fenagodb` and create a new CDB named `drlee31`. You have also created a pluggable database `pdb1` within the `drlee31` CDB. This process is crucial for managing Oracle databases efficiently in various environments.
