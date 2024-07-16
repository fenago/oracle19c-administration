### Lab 4.2: Creating and Managing Pluggable Databases (PDBs)
#### Objective:
To create two new Pluggable Databases (PDBs) within the Container Database (CDB) CDBDEV, and to manage them. This lab will also guide you on how to view and manage the PDBs in SQL Developer from an administrative perspective.

#### Pre-requisites:
Ensure that the CDBDEV database is up and running, and that you have SQL Developer installed.

### Steps:

#### 1. Create Directories for PDBs
1. **Start a new terminal shell and execute as root**:
    ```bash
    xhost +
    su - oracle
    ```

2. **Create directories for the new PDBs**:
    ```bash
    mkdir -p /u01/app/oracle/oradata/CDBDEV/pdb1
    mkdir -p /u01/app/oracle/oradata/CDBDEV/pdb2
    chown -R oracle:oinstall /u01/app/oracle/oradata/CDBDEV/pdb1
    chown -R oracle:oinstall /u01/app/oracle/oradata/CDBDEV/pdb2
    chmod -R 775 /u01/app/oracle/oradata/CDBDEV/pdb1
    chmod -R 775 /u01/app/oracle/oradata/CDBDEV/pdb2
    ```

#### 2. Create the Pluggable Databases (PDBs)
1. **Set Oracle environment variables manually**:
    ```bash
    export ORACLE_BASE=/u01/app/oracle
    export ORACLE_HOME=/u01/app/oracle/product/19.3.0/dbhome_1
    export ORACLE_SID=CDBDEV
    export PATH=$ORACLE_HOME/bin:$PATH
    ```

2. **Connect to SQL*Plus**:
    ```bash
    sqlplus / as sysdba
    ```

3. **Create PDB1**:
    ```sql
    CREATE PLUGGABLE DATABASE pdb1
    ADMIN USER pdbadmin IDENTIFIED BY fenago
    FILE_NAME_CONVERT = ('/u01/app/oracle/oradata/CDBDEV/', '/u01/app/oracle/oradata/CDBDEV/pdb1/');
    ```

4. **Create PDB2**:
    ```sql
    CREATE PLUGGABLE DATABASE pdb2
    ADMIN USER pdbadmin IDENTIFIED BY fenago
    FILE_NAME_CONVERT = ('/u01/app/oracle/oradata/CDBDEV/', '/u01/app/oracle/oradata/CDBDEV/pdb2/');
    ```

#### 3. Open the Pluggable Databases
1. **Open PDB1**:
    ```sql
    ALTER PLUGGABLE DATABASE pdb1 OPEN;
    ```

2. **Open PDB2**:
    ```sql
    ALTER PLUGGABLE DATABASE pdb2 OPEN;
    ```

3. **Verify the PDBs are open**:
    ```sql
    SHOW PDBS;
    ```

#### 4. Create Entries in `tnsnames.ora`
1. **Edit `tnsnames.ora`**:
    ```bash
    vi $ORACLE_HOME/network/admin/tnsnames.ora
    ```

2. **Add the following entries**:
    ```plaintext
    PDB1 =
      (DESCRIPTION =
        (ADDRESS = (PROTOCOL = TCP)(HOST = localhost)(PORT = 1521))
        (CONNECT_DATA =
          (SERVICE_NAME = pdb1)
        )
      )

    PDB2 =
      (DESCRIPTION =
        (ADDRESS = (PROTOCOL = TCP)(HOST = localhost)(PORT = 1521))
        (CONNECT_DATA =
          (SERVICE_NAME = pdb2)
        )
      )
    ```

#### 5. Start the Listener and Register PDBs
1. **Restart the listener**:
    ```bash
    lsnrctl stop
    lsnrctl start
    ```

2. **Register the databases with the listener**:
    ```bash
    sqlplus / as sysdba
    ALTER SYSTEM REGISTER;
    ```

3. **Verify the listener status**:
    ```bash
    lsnrctl status
    ```

#### 6. Connecting to PDBs Using SQL Developer
1. **Launch SQL Developer**:
    - Locate and double-click the SQL Developer launcher icon on your desktop.

2. **Create new connections for PDB1 and PDB2**:
    - **File -> New -> Database Connection...**
    - **Connection Name**: PDB1_Admin
    - **Username**: PDBADMIN
    - **Password**: fenago
    - **Connection Type**: Basic
    - **Role**: Default
    - **Hostname**: localhost
    - **Port**: 1521
    - **Service Name**: pdb1

    Repeat the same steps for PDB2:
    - **Connection Name**: PDB2_Admin
    - **Username**: PDBADMIN
    - **Password**: fenago
    - **Connection Type**: Basic
    - **Role**: Default
    - **Hostname**: localhost
    - **Port**: 1521
    - **Service Name**: pdb2

3. **Test and Save the Connections**:
    - Click the **Test** button to verify the connection details.
    - Click the **Save** button to save the connection.
    - Click the **Connect** button to establish the connection to PDB1 and PDB2.

#### 7. Manage PDBs in SQL Developer
1. **Explore the PDBs**:
    - In the **Connections** pane, expand `PDB1_Admin` and `PDB2_Admin` to explore tables, views, and other database objects.

2. **Administer PDBs**:
    - Navigate to **Security -> Users** to manage database users.
    - Navigate to **Storage -> Tablespaces** to manage tablespaces.
    - Use the **SQL Worksheet** to run administrative SQL commands.

3. **Monitor PDB Performance**:
    - Use the **Performance** tab to view active sessions, wait events, and other performance metrics.

#### Summary:
By following these steps, you will successfully create and manage two Pluggable Databases (PDBs) within the Container Database (CDB) CDBDEV. You will also learn how to connect to these PDBs using SQL Developer and perform administrative tasks, ensuring effective database management and monitoring.
