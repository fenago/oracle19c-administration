Yes, we did create a `CDBDEV` in a prior lab. If `CDBDEV` already exists, we should either drop the existing `CDBDEV` before starting this lab or use a different name for the new CDB to avoid conflicts. For this lab, I'll assume we want to create a new CDB and name it `CDBLAB`.

### Practice 5-1: Shutting Down and Starting Up the Oracle Database

#### Objective:
To stop all running databases and listeners, create a new CDB named `CDBLAB` with three PDBs using DBCA, and ensure that all databases are running at the end of the practice.

#### Steps:

1. **Identify and Stop All Running Databases and Listeners**

   First, identify all running databases and listeners:
   ```sh
   pgrep -lf smon
   pgrep -lf tns
   ```

   Stop all running databases:
   ```sh
   sqlplus / as sysdba
   SHUTDOWN IMMEDIATE;
   ```

   Stop all running listeners:
   ```sh
   lsnrctl stop
   ```

2. **Set Oracle Environment Variables**

   Set the Oracle environment variables using the `oraenv` script:
   ```sh
   . oraenv
   ORACLE_SID = [oracle] ? CDBLAB
   ```

3. **Create a New CDB with Three PDBs Using DBCA**

   Use the following command to create a new CDB named `CDBLAB` with three PDBs (`PDB1`, `PDB2`, and `PDB3`):
   ```sh
   dbca -silent -createDatabase \
   -templateName General_Purpose.dbc \
   -gdbName CDBLAB -sid CDBLAB \
   -createAsContainerDatabase true \
   -numberOfPDBs 3 \
   -pdbName PDB1,PDB2,PDB3 \
   -pdbAdminPassword YourPDBPassword \
   -sysPassword fenago \
   -systemPassword fenago \
   -datafileDestination '/u01/app/oracle/oradata' \
   -storageType FS \
   -characterSet AL32UTF8 \
   -nationalCharacterSet AL16UTF16 \
   -createListener LISTENER \
   -listenerPort 1521 \
   -emConfiguration DBEXPRESS \
   -emExpressPort 5501 \
   -memoryMgmtType auto_sga \
   -totalMemory 2048 \
   -redoLogFileSize 50 \
   -automaticMemoryManagement false \
   -enableArchive true
   ```

4. **Verify the CDB and PDBs Creation**

   Connect to the CDB and verify the creation of the PDBs:
   ```sh
   sqlplus / as sysdba
   SELECT con_id, name, open_mode FROM v$pdbs;
   ```

5. **Start and Stop the CDB and PDBs**

   **Shutdown the CDB:**
   ```sql
   SHUTDOWN IMMEDIATE;
   ```

   **Startup the CDB in NOMOUNT Mode:**
   ```sql
   STARTUP NOMOUNT;
   ```

   **Mount the CDB:**
   ```sql
   ALTER DATABASE MOUNT;
   ```

   **Open the CDB:**
   ```sql
   ALTER DATABASE OPEN;
   ```

   **Open All PDBs:**
   ```sql
   ALTER PLUGGABLE DATABASE ALL OPEN;
   ```

   Verify the status of the PDBs:
   ```sql
   SELECT con_id, name, open_mode FROM v$pdbs;
   ```

6. **Set the PDB Save States**

   Save the state of the PDBs so they open automatically on CDB startup:
   ```sql
   ALTER PLUGGABLE DATABASE ALL SAVE STATE;
   ```

7. **Check the PDB Save States**

   Verify the saved states:
   ```sql
   SELECT con_id, con_name, state FROM DBA_PDB_SAVED_STATES;
   ```

8. **Stop the CDB**

   Shut down the CDB:
   ```sql
   SHUTDOWN IMMEDIATE;
   ```

9. **Start the CDB and Verify PDB States**

   Start the CDB and verify the PDB states:
   ```sql
   STARTUP;
   SELECT con_id, name, open_mode FROM v$pdbs;
   ```

10. **Ensure All PDBs Are Running**

    Ensure all PDBs are open:
    ```sql
    ALTER PLUGGABLE DATABASE ALL OPEN;
    SELECT con_id, name, open_mode FROM v$pdbs;
    ```

11. **Exit SQL*Plus**

    Exit SQL*Plus:
    ```sql
    EXIT;
    ```

12. **Start the Listener**

    Start the Oracle listener:
    ```sh
    lsnrctl start
    ```

### Summary
By following these steps, you will successfully identify and stop all running databases and listeners, create a new CDB named `CDBLAB` with three PDBs, and ensure that all databases are running at the end of the practice. This practice helps in understanding the complete lifecycle management of Oracle databases using DBCA and SQL*Plus commands.

### Addendum: Verifying Created Files and Running Processes

#### Objective:
To verify all the files created for the new CDB (`CDBLAB`) and its three PDBs (`PDB1`, `PDB2`, `PDB3`), and to find the processes that are running for all of them.

#### Steps:

1. **Open a New Terminal**

   Open a new terminal window.

2. **Verify Files Created for CDB and PDBs**

   Navigate to the Oracle datafile destination directory:
   ```sh
   cd /u01/app/oracle/oradata/CDBLAB
   ls -l
   ```

   **Expected Files in `CDBLAB` Directory:**
   - **Control Files:** `control01.ctl`, `control02.ctl`
   - **Redo Log Files:** `redo01.log`, `redo02.log`, `redo03.log`
   - **System Data Files:** `system01.dbf`, `sysaux01.dbf`
   - **Temporary Tablespace:** `temp01.dbf`
   - **Undo Tablespace:** `undotbs01.dbf`
   - **PDB Seed Files:** `pdbseed/system01.dbf`, `pdbseed/sysaux01.dbf`

   **Explanation:**
   - **Control Files:** Essential for database startup, containing metadata about the database structure.
   - **Redo Log Files:** Used for recovery purposes, storing all changes made to the database.
   - **System Data Files:** Contain the core data dictionary and system information.
   - **Temporary Tablespace:** Used for temporary storage of data during SQL operations.
   - **Undo Tablespace:** Stores undo information for transactions.
   - **PDB Seed Files:** Template files for creating new PDBs.

3. **Verify Files for Each PDB**

   Navigate to each PDB's directory and list the files:
   
   For `PDB1`:
   ```sh
   cd /u01/app/oracle/oradata/CDBLAB/PDB1
   ls -l
   ```

   For `PDB2`:
   ```sh
   cd /u01/app/oracle/oradata/CDBLAB/PDB2
   ls -l
   ```

   For `PDB3`:
   ```sh
   cd /u01/app/oracle/oradata/CDBLAB/PDB3
   ls -l
   ```

   **Expected Files in Each PDB Directory:**
   - **System Data File:** `system01.dbf`
   - **Sysaux Data File:** `sysaux01.dbf`
   - **Temporary Tablespace:** `temp01.dbf`
   - **Users Tablespace:** `users01.dbf`

   **Explanation:**
   - **System Data File:** Contains the core data dictionary and system information for the PDB.
   - **Sysaux Data File:** Auxiliary data for the PDB.
   - **Temporary Tablespace:** Temporary storage for SQL operations within the PDB.
   - **Users Tablespace:** Default tablespace for user data within the PDB.

4. **Find Running Processes for the CDB and PDBs**

   Identify all running processes for the CDB and PDBs using the `pgrep` command:
   ```sh
   pgrep -lf smon
   ```

   **Expected Output:**
   - You should see entries like `ora_smon_CDBLAB`, `ora_smon_PDB1`, `ora_smon_PDB2`, and `ora_smon_PDB3`.

   **Explanation:**
   - **SMON Process:** System Monitor process for each database, responsible for instance recovery, cleaning up temporary segments, and other tasks.

   Check the listener process:
   ```sh
   pgrep -lf tns
   ```

   **Expected Output:**
   - You should see an entry like `tnslsnr LISTENER`.

   **Explanation:**
   - **Listener Process:** Manages incoming client connections to the Oracle database.

5. **Detailed Process Information**

   For more detailed information about each process, use the `ps` command:
   ```sh
   ps -ef | grep smon
   ```

   **Explanation:**
   - This command provides detailed information about the `smon` processes, including the user running them, start time, and more.

6. **Checking Database Status in SQL*Plus**

   Connect to SQL*Plus to check the status of the CDB and PDBs:
   ```sh
   sqlplus / as sysdba
   ```

   **Check the Status of the PDBs:**
   ```sql
   SELECT con_id, name, open_mode FROM v$pdbs;
   ```

   **Expected Output:**
   - You should see the following:
     ```
     CON_ID    NAME       OPEN_MODE
     -------   -------    ----------
     2         PDB$SEED   READ ONLY
     3         PDB1       READ WRITE
     4         PDB2       READ WRITE
     5         PDB3       READ WRITE
     ```

   **Explanation:**
   - **PDB$SEED:** Template for creating new PDBs, should be in READ ONLY mode.
   - **PDB1, PDB2, PDB3:** User-defined PDBs, should be in READ WRITE mode.

### Summary
By following these detailed steps, you will verify the files created for the new CDB and its PDBs and identify the running processes associated with them. This addendum ensures a thorough understanding of the Oracle database's file structure and process management.
