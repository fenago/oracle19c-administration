### Lab 6.3: Creating a Common User and Verifying Across CDB and PDBs

#### Objective:
To create a common user named `DRLEE` in the CDB (CDBLAB) and verify its existence in both the root container and the PDBs (PDBLAB1 and PDBLAB2).

### Steps:

1. **Connect to SQL*Plus as SYSDBA:**

    ```shell
    sqlplus / as sysdba
    ```

2. **Ensure You Are in the Root Container (CDB$ROOT):**

    ```sql
    ALTER SESSION SET CONTAINER = CDB$ROOT;
    ```

3. **Create the Common User `DRLEE`:**

    ```sql
    CREATE USER C##DRLEE IDENTIFIED BY password;
    ```

4. **Grant Privileges to the Common User:**

    ```sql
    GRANT CONNECT, RESOURCE, DBA TO C##DRLEE;
    ```

5. **Verify the Common User in the Root Container:**

    ```sql
    SELECT username, common FROM cdb_users WHERE username = 'C##DRLEE';
    ```

6. **Switch to PDBLAB1 and Verify the Common User:**

    ```sql
    ALTER SESSION SET CONTAINER = PDBLAB1;
    SELECT username, common FROM cdb_users WHERE username = 'C##DRLEE';
    ```

7. **Switch to PDBLAB2 and Verify the Common User:**

    ```sql
    ALTER SESSION SET CONTAINER = PDBLAB2;
    SELECT username, common FROM cdb_users WHERE username = 'C##DRLEE';
    ```

### Detailed Example:

1. **Connect to SQL*Plus as SYSDBA:**
    ```shell
    sqlplus / as sysdba
    ```

2. **Ensure You Are in the Root Container (CDB$ROOT):**
    ```sql
    ALTER SESSION SET CONTAINER = CDB$ROOT;
    ```

3. **Create the Common User `DRLEE`:**
    ```sql
    CREATE USER C##DRLEE IDENTIFIED BY password;
    ```

4. **Grant Privileges to the Common User:**
    ```sql
    GRANT CONNECT, RESOURCE, DBA TO C##DRLEE;
    ```

5. **Verify the Common User in the Root Container:**
    ```sql
    SELECT username, common FROM cdb_users WHERE username = 'C##DRLEE';
    ```

6. **Switch to PDBLAB1 and Verify the Common User:**
    ```sql
    ALTER SESSION SET CONTAINER = PDBLAB1;
    SELECT username, common FROM cdb_users WHERE username = 'C##DRLEE';
    ```

7. **Switch to PDBLAB2 and Verify the Common User:**
    ```sql
    ALTER SESSION SET CONTAINER = PDBLAB2;
    SELECT username, common FROM cdb_users WHERE username = 'C##DRLEE';
    ```

### Explanation:

- **Step 1:** Connect to SQL*Plus as the SYSDBA user to have the necessary privileges to create a common user.
- **Step 2:** Ensure you are operating in the root container (CDB$ROOT).
- **Step 3:** Create a common user with the prefix `C##`.
- **Step 4:** Grant the necessary privileges to the new common user.
- **Step 5:** Verify the existence of the common user in the root container.
- **Step 6 & 7:** Switch to each PDB (PDBLAB1 and PDBLAB2) and verify the existence of the common user.

By following these steps, you will create a common user named `DRLEE` and verify its existence across the root container and the specified PDBs (PDBLAB1 and PDBLAB2).
