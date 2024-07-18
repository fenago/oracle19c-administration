### Lab 6.4: Creating Local Users and Admins in PDBLAB1 and PDBLAB2

#### Objective:
To create local users and admins in PDBLAB1 and PDBLAB2, and verify their existence within their respective PDBs and not in the CDB.

### Steps:

1. **Connect to SQL*Plus as SYSDBA:**

    **Explanation:** This step establishes a connection to the database with SYSDBA privileges, which is required to perform administrative tasks such as creating users.

    ```shell
    sqlplus / as sysdba
    ```

2. **Create a Local User in PDBLAB1:**

    - **Switch to PDBLAB1:**

      **Explanation:** This command switches the context to the PDBLAB1 container, allowing you to create users specific to this PDB.

      ```sql
      ALTER SESSION SET CONTAINER = PDBLAB1;
      ```

    - **Create a Local User `PDB1_USER`:**

      **Explanation:** This command creates a local user named `PDB1_USER` in PDBLAB1. The user will be identified by the specified password.

      ```sql
      CREATE USER PDB1_USER IDENTIFIED BY password;
      ```

    - **Grant Privileges to the Local User:**

      **Explanation:** The `CONNECT` privilege allows the user to connect to the database. The `RESOURCE` privilege allows the user to create and manage database objects such as tables and indexes.

      ```sql
      GRANT CONNECT, RESOURCE TO PDB1_USER;
      ```

      **Other Options:** Additional privileges that can be granted include `DBA` (for full administrative rights), `CREATE SESSION` (to allow session creation), `CREATE TABLE` (to allow table creation), etc.

    - **Verify the Local User in PDBLAB1:**

      **Explanation:** This query checks if `PDB1_USER` exists in PDBLAB1.

      ```sql
      SELECT username FROM dba_users WHERE username = 'PDB1_USER';
      ```

    - **Verify the User Does Not Exist in CDB:**

      **Explanation:** This query ensures that `PDB1_USER` is not visible in the root container (CDB).

      ```sql
      ALTER SESSION SET CONTAINER = CDB$ROOT;
      SELECT username FROM cdb_users WHERE username = 'PDB1_USER';
      ```

3. **Create a Local Admin in PDBLAB1:**

    - **Switch to PDBLAB1:**

      **Explanation:** This command switches the context to the PDBLAB1 container.

      ```sql
      ALTER SESSION SET CONTAINER = PDBLAB1;
      ```

    - **Create a Local Admin `PDB1_ADMIN`:**

      **Explanation:** This command creates a local admin named `PDB1_ADMIN` in PDBLAB1.

      ```sql
      CREATE USER PDB1_ADMIN IDENTIFIED BY password;
      ```

    - **Grant DBA Privileges to the Local Admin:**

      **Explanation:** The `DBA` privilege grants full administrative rights within PDBLAB1.

      ```sql
      GRANT DBA TO PDB1_ADMIN;
      ```

    - **Verify the Local Admin in PDBLAB1:**

      **Explanation:** This query checks if `PDB1_ADMIN` exists in PDBLAB1.

      ```sql
      SELECT username FROM dba_users WHERE username = 'PDB1_ADMIN';
      ```

    - **Verify the Admin Does Not Exist in CDB:**  (It will show up here but it is NOT a common user which is the main point)

      **Explanation:** This query ensures that `PDB1_ADMIN` is not visible in the root container (CDB).

      ```sql
      ALTER SESSION SET CONTAINER = CDB$ROOT;
      SELECT username FROM cdb_users WHERE username = 'PDB1_ADMIN';
      ```

4. **Repeat the Steps to Create a Local User and Admin in PDBLAB2:**

    **Explanation:** Repeat the above steps for PDBLAB2 to create `PDB2_USER` and `PDB2_ADMIN`.

    - **Switch to PDBLAB2:**

      ```sql
      ALTER SESSION SET CONTAINER = PDBLAB2;
      ```

    - **Create a Local User `PDB2_USER`:**

      ```sql
      CREATE USER PDB2_USER IDENTIFIED BY password;
      ```

    - **Grant Privileges to the Local User:**

      ```sql
      GRANT CONNECT, RESOURCE TO PDB2_USER;
      ```

    - **Verify the Local User in PDBLAB2:**

      ```sql
      SELECT username FROM dba_users WHERE username = 'PDB2_USER';
      ```

    - **Verify the User Does Not Exist in CDB:**

      ```sql
      ALTER SESSION SET CONTAINER = CDB$ROOT;
      SELECT username FROM cdb_users WHERE username = 'PDB2_USER';
      ```

    - **Create a Local Admin `PDB2_ADMIN`:**

      ```sql
      ALTER SESSION SET CONTAINER = PDBLAB2;
      CREATE USER PDB2_ADMIN IDENTIFIED BY password;
      GRANT DBA TO PDB2_ADMIN;
      ```

    - **Verify the Local Admin in PDBLAB2:**

      ```sql
      SELECT username FROM dba_users WHERE username = 'PDB2_ADMIN';
      ```

    - **Verify the Admin Does Not Exist in CDB:**

      ```sql
      ALTER SESSION SET CONTAINER = CDB$ROOT;
      SELECT username FROM cdb_users WHERE username = 'PDB2_ADMIN';
      ```

### Explanation:

- **Connecting to SQL*Plus as SYSDBA:** Provides the necessary privileges to perform administrative tasks.
- **Switching to PDB:** Allows you to perform tasks specific to the selected PDB.
- **Creating Users:** The `CREATE USER` command is used to create a new user. Local users are specific to a PDB, while common users (with prefix `C##`) are shared across the entire CDB.
- **Granting Privileges:** `CONNECT` allows the user to connect to the database. `RESOURCE` allows the user to create and manage database objects. `DBA` grants full administrative rights within the PDB.
- **Verification:** Queries are used to ensure the users are created correctly in the PDBs and are not visible in the root container.

By following these steps, you will create local users and admins in PDBLAB1 and PDBLAB2 and verify their existence within their respective PDBs.
