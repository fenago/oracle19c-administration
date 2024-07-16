### Lab 4.1: Creating a New CDB

#### Objective:
To create a new Container Database (CDB) named `CDBDEV` using the `CREATE DATABASE` SQL command with specified characteristics.

#### Pre-req
Start a NEW terminal shell and execute:
```
xhost +
```
Then create the directories needed (note that if you want a new DB - then replace CDBDEV with your new DB): REMEMBER YOU ARE DOING THIS AS ROOT

```
mkdir -p /u01/app/oracle/oradata/CDBDEV
mkdir -p /u01/app/oracle/oradata/pdbseed
mkdir -p /u01/app/oracle/fast_recovery_area
mkdir -p /u01/app/oracle/admin/CDBDEV/adump

chown -R oracle:oinstall /u01/app/oracle/oradata
chown -R oracle:oinstall /u01/app/oracle/fast_recovery_area
chown -R oracle:oinstall /u01/app/oracle/admin

chmod -R 775 /u01/app/oracle/oradata
chmod -R 775 /u01/app/oracle/fast_recovery_area
chmod -R 775 /u01/app/oracle/admin
```
Then switch to oracle

```
su - oracle
```

It looks like the Oracle environment variables are not being set correctly due to the ORACLE_BASE environment variable not being set for the current user. Let's go through the steps to troubleshoot and resolve this issue:

1. **Check /etc/oratab**: Ensure that CDBDEV is not present in the `/etc/oratab` file. If it is, remove it.

    ```bash
    vi /etc/oratab
    ```

    Delete any line containing `CDBDEV` if it exists.

2. **Set Oracle Environment Variables Manually**: Since the ORACLE_BASE is not set automatically, you can set it manually in the terminal.

    ```bash
    export ORACLE_BASE=/u01/app/oracle
    export ORACLE_HOME=/u01/app/oracle/product/19.3.0/dbhome_1
    export ORACLE_SID=CDBDEV
    export PATH=$ORACLE_HOME/bin:$PATH
    ```

3. **Create Initialization Parameter File**: Follow the steps to create and edit the initialization parameter file.

    ```bash
    cp $ORACLE_HOME/dbs/init.ora $ORACLE_HOME/dbs/initCDBDEV.ora
    vi $ORACLE_HOME/dbs/initCDBDEV.ora
    ```

    Set the following parameters in the `initCDBDEV.ora` file:

    ```plaintext
    # Change <ORACLE_BASE> to point to the oracle base (the one you specify at install time)
        
    db_name='CDBDEV'
    enable_pluggable_database=true
    sga_target=512M
    pga_aggregate_target=512M
    processes=150
    audit_file_dest='/u01/app/oracle/admin/CDBDEV/adump'
    audit_trail='db'
    db_block_size=8192
    db_domain=''
    db_create_file_dest='/u01/app/oracle/oradata'
    db_recovery_file_dest='/u01/app/oracle/fast_recovery_area'
    db_recovery_file_dest_size=2G
    diagnostic_dest='/u01/app/oracle'
    dispatchers='(PROTOCOL=TCP) (SERVICE=CDBDEVXDB)'
    open_cursors=300
    remote_login_passwordfile='EXCLUSIVE'
    undo_tablespace=UNDOTBS1
    control_files=(ora_control1, ora_control2)
    compatible='19.0.0'
    ```

4. **Verify Required Directories**: Ensure that the required directories exist. Create them if they do not.

    ```bash
    mkdir -p /u01/app/oracle/oradata
    mkdir -p /u01/app/oracle/fast_recovery_area
    mkdir -p /u01/app/oracle/admin/CDBDEV/adump
    ```
    Also delete any files from a prior attempt:

   ```bash
   rm /u01/app/oracle/product/19.3.0/dbhome_1/dbs/ora_control1
   rm /u01/app/oracle/product/19.3.0/dbhome_1/dbs/ora_control2
   ```

6. **Start the Database Instance in NOMOUNT Mode**:

    ```bash
    sqlplus / as sysdba
    ```

    Then call:
   ```
    STARTUP NOMOUNT PFILE=$ORACLE_HOME/dbs/initCDBDEV.ora;
    ```

7. **Create the CDB**: Execute the CREATE DATABASE command.

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
    UNDO TABLESPACE undotbs1
       DATAFILE '/u01/app/oracle/oradata/CDBDEV/undotbs01.dbf'
       SIZE 200M REUSE AUTOEXTEND ON MAXSIZE UNLIMITED
    ENABLE PLUGGABLE DATABASE
       SEED
       FILE_NAME_CONVERT = ('/u01/app/oracle/oradata/CDBDEV/', '/u01/app/oracle/oradata/pdbseed/')
       SYSTEM DATAFILES SIZE 125M AUTOEXTEND ON NEXT 10M MAXSIZE UNLIMITED
       SYSAUX DATAFILES SIZE 100M;
    ```

8. **Execute Catalog and Catproc Scripts**:

    ```sql
    @$ORACLE_HOME/rdbms/admin/catalog.sql
    @$ORACLE_HOME/rdbms/admin/catproc.sql
    ```

9. **Add Entry to /etc/oratab**: Add the new entry for CDBDEV to `/etc/oratab`.

    ```bash
    echo "CDBDEV:/u01/app/oracle/product/19.3.0/dbhome_1:Y" | sudo tee -a /etc/oratab
    cat /etc/oratab
    ```

10. **Verify Database Characteristics**: Verify that the specified tablespaces are created for the CDB$ROOT.

    ```sql
    sqlplus / as sysdba
    SELECT tablespace_name FROM dba_tablespaces;
    ```

Following these steps should help you successfully create the CDBDEV database. If you encounter any issues, please provide the specific error messages so I can assist further.

#### Optional

No, you don't need to run the `. oraenv` command if you manually set the environment variables using `export`. Here's a recap of what you need to do:

1. **Set Oracle Environment Variables Manually**: Set the Oracle environment variables manually in the terminal:

    ```bash
    export ORACLE_BASE=/u01/app/oracle
    export ORACLE_HOME=/u01/app/oracle/product/19.3.0/dbhome_1
    export ORACLE_SID=CDBDEV
    ```

After setting these environment variables, you can proceed with the rest of the steps to create the CDBDEV database.

If you prefer to use `. oraenv`, follow these steps instead:

1. **Update /etc/oratab**: Ensure that `CDBDEV` is in the `/etc/oratab` file with the correct path.

    ```bash
    echo "CDBDEV:/u01/app/oracle/product/19.3.0/dbhome_1:Y" | sudo tee -a /etc/oratab
    ```

2. **Run . oraenv**: Execute the `oraenv` command and specify `CDBDEV`.

    ```bash
    . oraenv
    ```

    When prompted, enter `CDBDEV`.

By running `. oraenv`, it will source the necessary environment variables from the `/etc/oratab` file.

After setting the environment variables using either method, proceed with the remaining steps to create and configure the CDBDEV database.

-----------------------DELETE BELOW THIS---------------------


#### Steps:

1. **Verify CDBDEV is not in /etc/oratab**

   Check if `CDBDEV` is recorded in `/etc/oratab`. If it is, remove the entry:
   ```sh
   vi /etc/oratab
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
   # Change <ORACLE_BASE> to point to the oracle base (the one you specify at install time)

    db_name='CDBDEV'
    enable_pluggable_database=true
    memory_target=1G
    processes=150
    audit_file_dest='/u01/app/oracle/admin/CDBDEV/adump'
    audit_trail='db'
    db_block_size=8192
    db_domain=''
    db_create_file_dest='/u01/app/oracle/oradata'
    db_recovery_file_dest='/u01/app/oracle/fast_recovery_area'
    db_recovery_file_dest_size=2G
    diagnostic_dest='/u01/app/oracle'
    dispatchers='(PROTOCOL=TCP) (SERVICE=CDBDEVXDB)'
    open_cursors=300
    remote_login_passwordfile='EXCLUSIVE'
    undo_tablespace=UNDOTBS1

    # You may want to ensure that control files are created on separate physical devices
    control_files=(ora_control1, ora_control2)
    compatible='11.2.0'
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
