### Lab 6.0: Setting Up Environment and Configuring Listener and TNS Names

#### Objective:
To set environment variables, start the CDBLAB, check the PDBs, use the information to configure `tnsnames.ora` and `listener.ora`, ensuring nothing is in an UNKNOWN state when running `lsnrctl status`, and verify the configuration using `tnsping`.

### Steps:

1. **Open the Terminal and Set Environment Variables:**

    ```shell
    export ORACLE_BASE=/u01/app/oracle
    export ORACLE_HOME=/u01/app/oracle/product/19.3.0/dbhome_1
    export ORACLE_SID=CDBLAB
    export PATH=$ORACLE_HOME/bin:$PATH
    ```

    **Explanation:** These environment variables set the Oracle base directory, Oracle home directory, the SID for the CDBLAB, and add the Oracle binaries to the system path.

2. **Start SQL*Plus:**

    ```shell
    sqlplus / as sysdba
    ```

    **Explanation:** This command opens SQL*Plus with SYSDBA privileges.

3. **Start the CDBLAB:**

    ```sql
    STARTUP;
    ```

    **Explanation:** This command starts the CDBLAB database.

4. **Check the Status of PDBs:**

    ```sql
    SELECT con_id, name, open_mode FROM v$pdbs;
    ```

    **Explanation:** This query checks the status of all PDBs in the CDBLAB and identifies the available PDBs.

5. **Open Each PDB Individually in Read Write Mode:**

    **Explanation:** This section ensures each PDB is opened in read write mode. Replace the PDB names with the actual names obtained from the previous query.

    ```sql
    ALTER PLUGGABLE DATABASE pdb_name OPEN READ WRITE;
    ```

    Repeat the above command for each PDB identified in step 4.

6. **Configure `listener.ora`:**

    **Explanation:** Edit the `listener.ora` file to include entries for CDBLAB and all identified PDBs.

    Open `listener.ora`:
    ```shell
    vi /u01/app/oracle/product/19.3.0/dbhome_1/network/admin/listener.ora
    ```

    Add the following entries, updating them with the actual PDB names obtained from step 4:

    ```plaintext
    LISTENER =
      (DESCRIPTION_LIST =
        (DESCRIPTION =
          (ADDRESS = (PROTOCOL = TCP)(HOST = localhost)(PORT = 1521))
        )
      )

    SID_LIST_LISTENER =
      (SID_LIST =
        (SID_DESC =
          (GLOBAL_DBNAME = CDBLAB)
          (SID_NAME = CDBLAB)
          (ORACLE_HOME = /u01/app/oracle/product/19.3.0/dbhome_1)
        )
        (SID_DESC =
          (GLOBAL_DBNAME = pdb_name1)
          (SID_NAME = pdb_name1)
          (ORACLE_HOME = /u01/app/oracle/product/19.3.0/dbhome_1)
        )
        (SID_DESC =
          (GLOBAL_DBNAME = pdb_name2)
          (SID_NAME = pdb_name2)
          (ORACLE_HOME = /u01/app/oracle/product/19.3.0/dbhome_1)
        )
        (SID_DESC =
          (GLOBAL_DBNAME = pdb_name3)
          (SID_NAME = pdb_name3)
          (ORACLE_HOME = /u01/app/oracle/product/19.3.0/dbhome_1)
        )
        (SID_DESC =
          (GLOBAL_DBNAME = pdb_name4)
          (SID_NAME = pdb_name4)
          (ORACLE_HOME = /u01/app/oracle/product/19.3.0/dbhome_1)
        )
      )
    ```

    **Note:** Replace `pdb_name1`, `pdb_name2`, `pdb_name3`, and `pdb_name4` with the actual names of your PDBs.

7. **Configure `tnsnames.ora`:**

    **Explanation:** Edit the `tnsnames.ora` file to include entries for CDBLAB and all identified PDBs.

    Open `tnsnames.ora`:
    ```shell
    vi /u01/app/oracle/product/19.3.0/dbhome_1/network/admin/tnsnames.ora
    ```

    Add the following entries, updating them with the actual PDB names obtained from step 4:

    ```plaintext
    CDBLAB =
      (DESCRIPTION =
        (ADDRESS = (PROTOCOL = TCP)(HOST = localhost)(PORT = 1521))
        (CONNECT_DATA =
          (SERVER = DEDICATED)
          (SERVICE_NAME = CDBLAB)
        )
      )

    pdb_name1 =
      (DESCRIPTION =
        (ADDRESS = (PROTOCOL = TCP)(HOST = localhost)(PORT = 1521))
        (CONNECT_DATA =
          (SERVER = DEDICATED)
          (SERVICE_NAME = pdb_name1)
        )
      )

    pdb_name2 =
      (DESCRIPTION =
        (ADDRESS = (PROTOCOL = TCP)(HOST = localhost)(PORT = 1521))
        (CONNECT_DATA =
          (SERVER = DEDICATED)
          (SERVICE_NAME = pdb_name2)
        )
      )

    pdb_name3 =
      (DESCRIPTION =
        (ADDRESS = (PROTOCOL = TCP)(HOST = localhost)(PORT = 1521))
        (CONNECT_DATA =
          (SERVER = DEDICATED)
          (SERVICE_NAME = pdb_name3)
        )
      )

    pdb_name4 =
      (DESCRIPTION =
        (ADDRESS = (PROTOCOL = TCP)(HOST = localhost)(PORT = 1521))
        (CONNECT_DATA =
          (SERVER = DEDICATED)
          (SERVICE_NAME = pdb_name4)
        )
      )
    ```

    **Note:** Replace `pdb_name1`, `pdb_name2`, `pdb_name3`, and `pdb_name4` with the actual names of your PDBs.

8. **Reload the Listener:**

    ```shell
    lsnrctl reload
    ```

    **Explanation:** This command reloads the listener with the new configuration.

9. **Verify Listener Status:**

    ```shell
    lsnrctl status
    ```

    **Explanation:** This command checks the status of the listener to ensure all services are known.

10. **Test Connections with `tnsping`:**

    **Explanation:** Use `tnsping` to verify the connectivity to each service.

    ```shell
    tnsping CDBLAB
    tnsping pdb_name1
    tnsping pdb_name2
    tnsping pdb_name3
    tnsping pdb_name4
    ```

    **Note:** Replace `pdb_name1`, `pdb_name2`, `pdb_name3`, and `pdb_name4` with the actual names of your PDBs.

### Detailed Example:

1. **Open the Terminal and Set Environment Variables:**

    ```shell
    export ORACLE_BASE=/u01/app/oracle
    export ORACLE_HOME=/u01/app/oracle/product/19.3.0/dbhome_1
    export ORACLE_SID=CDBLAB
    export PATH=$ORACLE_HOME/bin:$PATH
    ```

2. **Start SQL*Plus:**

    ```shell
    sqlplus / as sysdba
    ```

3. **Start the CDBLAB:**

    ```sql
    STARTUP;
    ```

4. **Check the Status of PDBs:**

    ```sql
    SELECT con_id, name, open_mode FROM v$pdbs;
    ```

5. **Open Each PDB Individually in Read Write Mode:**

    ```sql
    ALTER PLUGGABLE DATABASE pdb_name OPEN READ WRITE;
    ```

    Repeat the above command for each PDB identified in step 4.

6. **Configure `listener.ora`:**

    Open `listener.ora`:
    ```shell
    vi /u01/app/oracle/product/19.3.0/dbhome_1/network/admin/listener.ora
    ```

    Add the entries, updating them with the actual PDB names obtained from step 4.

7. **Configure `tnsnames.ora`:**

    Open `tnsnames.ora`:
    ```shell
    vi /u01/app/oracle/product/19.3.0/dbhome_1/network/admin/tnsnames.ora
    ```

    Add the entries, updating them with the actual PDB names obtained from step 4.

8. **Reload the Listener:**

    ```shell
    lsnrctl reload
    ```

9. **Verify Listener Status:**

    ```shell
    lsnrctl status
    ```

10. **Test Connections with `tnsping`:**

    ```shell
    tnsping CDBLAB
    tnsping pdb_name1
    tnsping pdb_name2
    tnsping pdb_name3
    tnsping pdb_name4
    ```

### Explanation:

- **Setting Environment Variables:** Ensures the Oracle environment is correctly configured for operations.
- **Starting SQL*Plus:** Provides access to the database with SYSDBA privileges.
- **Starting the CDBLAB and Checking PDBs:** Ensures all databases are up and running.
- **Opening PDBs in Read Write Mode:** Ensures each PDB is accessible for operations.
- **Configuring `listener.ora` and `tnsnames.ora`:** Ensures proper network configuration for
