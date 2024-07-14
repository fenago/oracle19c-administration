### Lab 4.1: Creating a New CDB

#### Objective:
To create a new Container Database (CDB) named `CDBDEV` using the `CREATE DATABASE` SQL command with specified characteristics.

#### Steps:

1. **Verify CDBDEV is not in /etc/oratab**

   Check if `CDBDEV` is recorded in `/etc/oratab`. If it is, remove the entry:
   ```sh
   sudo vi /etc/oratab
   ```
   Remove the line containing `CDBDEV` if it exists.

2. **Set Oracle Environment Variables**

   Set the Oracle environment variables using the `oraenv` script:
   ```sh
   . oraenv
   ```
   When prompted, enter `CDBDEV`.

3. **Create an Initialization Parameter File**

   Create an initialization parameter file from the sample `init.ora` file:
   ```sh
   cp $ORACLE_HOME/dbs/init.ora $ORACLE_HOME/dbs/initCDBDEV.ora
   ```

   Edit the `initCDBDEV.ora` file and set the following parameters:
   ```ini
   db_name='CDBDEV'
   enable_pluggable_database=true
   db_create_file_dest='/u01/app/oracle/oradata'
   db_recovery_file_dest='/u01/app/oracle/fast_recovery_area'
   db_recovery_file_dest_size=2G
   audit_file_dest='/u01/app/oracle/admin/CDBDEV/adump'
   diagnostic_dest='/u01/app/oracle'
   ```
   
4. **Verify Required Directories Exist**

   Verify that the directories exist, create them if they do not:
   ```sh
   mkdir -p /u01/app/oracle/oradata
   mkdir -p /u01/app/oracle/fast_recovery_area
   mkdir -p /u01/app/oracle/admin/CDBDEV/adump
   ```

5. **Start the Database Instance in NOMOUNT Mode**

   Start the database instance in `NOMOUNT` mode:
   ```sh
   sqlplus / as sysdba
   ```
   ```sql
   STARTUP NOMOUNT PFILE=$ORACLE_HOME/dbs/initCDBDEV.ora;
   ```

6. **Create the CDB**

   Execute the script with the `CREATE DATABASE` command:
   ```sql
   CREATE DATABASE CDBDEV
   USER SYS IDENTIFIED BY fenago
   USER SYSTEM IDENTIFIED BY fenago
   LOGFILE GROUP 1 ('/u01/app/oracle/oradata/CDBDEV/redo01.log') SIZE 100M,
           GROUP 2 ('/u01/app/oracle/oradata/CDBDEV/redo02.log') SIZE 100M,
           GROUP 3 ('/u01/app/oracle/oradata/CDBDEV/redo03.log') SIZE 100M
   MAXLOGFILES 5
   MAXLOGMEMBERS 5
   MAXLOGHISTORY 1
   MAXDATAFILES 100
   CHARACTER SET AL32UTF8
   NATIONAL CHARACTER SET AL16UTF16
   EXTENT MANAGEMENT LOCAL
   DATAFILE '/u01/app/oracle/oradata/CDBDEV/system01.dbf' SIZE 700M REUSE
   SYSAUX DATAFILE '/u01/app/oracle/oradata/CDBDEV/sysaux01.dbf' SIZE 550M REUSE
   DEFAULT TABLESPACE users
      DATAFILE '/u01/app/oracle/oradata/CDBDEV/users01.dbf'
      SIZE 200M REUSE AUTOEXTEND ON MAXSIZE UNLIMITED
   DEFAULT TEMPORARY TABLESPACE temp
      TEMPFILE '/u01/app/oracle/oradata/CDBDEV/temp01.dbf'
      SIZE 20M REUSE
   UNDO TABLESPACE undotbs
      DATAFILE '/u01/app/oracle/oradata/CDBDEV/undotbs01.dbf'
      SIZE 200M REUSE AUTOEXTEND ON MAXSIZE UNLIMITED
   ENABLE PLUGGABLE DATABASE
      SEED
      FILE_NAME_CONVERT = ('/u01/app/oracle/oradata/CDBDEV/', '/u01/app/oracle/oradata/pdbseed/')
      SYSTEM DATAFILES SIZE 125M AUTOEXTEND ON NEXT 10M MAXSIZE UNLIMITED
      SYSAUX DATAFILES SIZE 100M;
   ```

   If you receive errors, use the SQL*Plus command `SHUTDOWN ABORT`, correct the errors, and restart from step 5.

7. **Execute Catalog and Catproc Scripts**

   Run the following scripts:
   ```sql
   @$ORACLE_HOME/rdbms/admin/catalog.sql
   @$ORACLE_HOME/rdbms/admin/catproc.sql
   ```

8. **Exit SQL*Plus**

   ```sql
   EXIT;
   ```

9. **Add Entry to /etc/oratab**

   Add the new entry to `/etc/oratab`:
   ```sh
   echo "CDBDEV:/u01/app/oracle/product/19.3.0/dbhome_1:Y" | sudo tee -a /etc/oratab
   ```

   Verify the entry:
   ```sh
   cat /etc/oratab
   ```

10. **Verify Database Characteristics**

    Verify that the specified tablespaces are created for the `CDB$ROOT`:
    ```sh
    sqlplus / as sysdba
    ```
    ```sql
    SELECT tablespace_name FROM dba_tablespaces;
    ```

    **Expected Output:**
    The output should include `SYSTEM`, `SYSAUX`, `UNDOTBS`, `TEMP`, and `USERS`.

### Summary
By following these steps, you will successfully create a new CDB named `CDBDEV` using the `CREATE DATABASE` SQL command with the specified characteristics. This practice helps in understanding the manual creation of databases and configuring essential parameters.
