# Lab 6-2: Managing PDBs Using SQL Developer

## Objective:
To perform various management tasks on a Pluggable Database (PDB) using SQL Developer, including changing PDB modes, setting storage limits, renaming the PDB, modifying lockout time, unplugging, dropping, and plugging back in the PDB.

## Prerequisites:
- SQL Developer installed and configured.
- Connection to the CDB (CDBLAB) and PDB (PDBLAB3) established.

## Steps:

### 1. Changing the PDB Modes

#### Purpose:
Changing the mode of a PDB allows you to manage its accessibility and operational state. Modes include READ WRITE, READ ONLY, and MOUNTED.

#### Instructions:
1. Open SQL Developer and connect to PDBLAB3.
2. In the Connections pane, right-click on the connection for PDB3_CDBLAB and select "SQL Worksheet."
3. **Check Current Mode:**

    ```sql
    SELECT name, open_mode FROM v$pdbs WHERE name = 'PDBLAB3';
    ```
    **Verification:**
    Ensure the output shows the current open mode of PDBLAB3.

4. **Close the PDB:**

    ```sql
    ALTER PLUGGABLE DATABASE PDBLAB3 CLOSE IMMEDIATE;
    ```
    **Verification:**
    ```sql
    SELECT name, open_mode FROM v$pdbs WHERE name = 'PDBLAB3';
    ```
    Ensure the output shows PDBLAB3 in the MOUNTED state.

5. **Open the PDB in READ ONLY Mode:**

    ```sql
    ALTER PLUGGABLE DATABASE PDBLAB3 OPEN READ ONLY;
    ```
    **Verification:**
    ```sql
    SELECT name, open_mode FROM v$pdbs WHERE name = 'PDBLAB3';
    ```
    Ensure the output shows PDBLAB3 in READ ONLY mode.

6. **Open the PDB in READ WRITE Mode (if required):**

    ```sql
    ALTER PLUGGABLE DATABASE PDBLAB3 CLOSE IMMEDIATE;

    ALTER PLUGGABLE DATABASE PDBLAB3 OPEN READ WRITE;
    ```
    **Verification:**
    ```sql
    SELECT name, open_mode FROM v$pdbs WHERE name = 'PDBLAB3';
    ```
    Ensure the output shows PDBLAB3 in READ WRITE mode.

### 2. Setting the PDB Storage Limit

#### Purpose:
Setting a storage limit helps in managing disk usage by restricting the maximum size a PDB can grow.

#### Instructions:
1. In the SQL Worksheet connected to PDBLAB3, enter the following command to set the storage limit:

    ```sql
    ALTER PLUGGABLE DATABASE PDBLAB3 STORAGE MAXSIZE 2G;
    ```
2. Run the command.

#### Verification:
To verify the storage limit, execute:

```sql
SELECT tablespace_name, max_size FROM dba_tablespaces WHERE con_id = (SELECT con_id FROM v$pdbs WHERE name = 'PDBLAB3');
```

Ensure the output shows the MAXSIZE set to 2G.

### 3. Changing the Global Name of the PDB

#### Purpose:
Changing the global name of a PDB can help in identifying and managing the PDB within a larger environment.

#### Instructions:
1. In the SQL Worksheet, enter the following command to change the global name:

    ```sql
    ALTER PLUGGABLE DATABASE PDBLAB3 RENAME GLOBAL_NAME TO PDB_LAB3_CDBLAB;
    ```
2. Run the command.

#### Verification:
To verify the name change, execute:

```sql
SELECT name FROM v$pdbs WHERE name = 'PDB_LAB3_CDBLAB';
```

Ensure the output shows the new name.

### 4. Changing the PDB Lockout Time

#### Purpose:
Changing the PDB lockout time adjusts the duration for which a PDB is locked out after a certain number of failed login attempts.

#### Instructions:
1. In the SQL Worksheet, enter the following command:

    ```sql
    ALTER PROFILE DEFAULT LIMIT FAILED_LOGIN_ATTEMPTS 5 PASSWORD_LOCK_TIME 1;
    ```
2. Run the command.

#### Verification:
To verify the changes, execute:

```sql
SELECT resource_name, limit FROM dba_profiles WHERE profile = 'DEFAULT' AND resource_name IN ('FAILED_LOGIN_ATTEMPTS', 'PASSWORD_LOCK_TIME');
```

Ensure the output shows the updated limits.

### 5. Unplugging the PDB

#### Purpose:
Unplugging a PDB prepares it for being moved or dropped without removing its data files.

#### Instructions:
1. In the SQL Worksheet, enter the following command to close and unplug the PDB:

    ```sql
    ALTER PLUGGABLE DATABASE PDB_LAB3_CDBLAB CLOSE IMMEDIATE;
    ALTER PLUGGABLE DATABASE PDB_LAB3_CDBLAB UNPLUG INTO '/u01/app/oracle/oradata/CDBLAB/PDB_LAB3_CDBLAB.xml';
    ```
2. Run the commands.

#### Verification:
Ensure the PDB is in the unplugged state by executing:

```sql
SELECT name, open_mode FROM v$pdbs WHERE name = 'PDB_LAB3_CDBLAB';
```

### 6. Dropping the PDB

#### Purpose:
Dropping a PDB removes it from the CDB but retains its data files, allowing it to be plugged back in later.

#### Instructions:
1. In the SQL Worksheet, enter the following command:

    ```sql
    DROP PLUGGABLE DATABASE PDB_LAB3_CDBLAB KEEP DATAFILES;
    ```
2. Run the command.

#### Verification:
To verify the PDB is dropped, execute:

```sql
SELECT name FROM v$pdbs;
```

Ensure PDB_LAB3_CDBLAB is not listed.

### 7. Plugging Back in the PDB

#### Purpose:
Plugging back in a PDB allows it to be reattached to the CDB, making it operational again.

#### Instructions:
1. In the SQL Worksheet, enter the following command to plug the PDB back in:

    ```sql
    CREATE PLUGGABLE DATABASE PDB_LAB3_CDBLAB USING '/u01/app/oracle/oradata/CDBLAB/PDB_LAB3_CDBLAB.xml' COPY FILE_NAME_CONVERT = ('/u01/app/oracle/oradata/CDBLAB/', '/u01/app/oracle/oradata/CDBLAB/PDB_LAB3_CDBLAB/');
    ```
2. Run the command.

#### Verification:
To verify the PDB is plugged back in, execute:

```sql
SELECT name, open_mode FROM v$pdbs WHERE name = 'PDB_LAB3_CDBLAB';
```

Ensure the output shows PDB_LAB3_CDBLAB in READ WRITE mode.

## Summary:
By following these steps, you will have successfully managed various aspects of a PDB using SQL Developer, including changing modes, setting storage limits, renaming, adjusting lockout time, unplugging, dropping, and plugging back in the PDB. Each step includes verification to ensure the changes are correctly applied.
