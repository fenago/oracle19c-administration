### Practice 5-1: Shutting Down and Starting Up the Oracle Database

#### Objective:
To stop all running databases and listeners, create a new CDB with three PDBs using DBCA, and ensure that all databases are running at the end of the practice.

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
   ```

3. **Create a New CDB with Three PDBs Using DBCA**

   Use the following command to create a new CDB named `CDBDEV` with three PDBs (`PDB1`, `PDB2`, and `PDB3`):
   ```sh
   dbca -silent -createDatabase \
   -templateName General_Purpose.dbc \
   -gdbName CDBDEV -sid CDBDEV \
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
By following these steps, you will successfully identify and stop all running databases and listeners, create a new CDB with three PDBs, and ensure that all databases are running at the end of the practice. This practice helps in understanding the complete lifecycle management of Oracle databases using DBCA and SQL*Plus commands.
