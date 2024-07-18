### Lab 6.5: Assigning Tablespace Quotas to Users in PDBLAB1 and PDBLAB2

#### Objective:
To assign tablespace quotas to the users created in PDBLAB1 and PDBLAB2, ensuring they have the necessary space to store data.

### Steps:

1. **Connect to SQL*Plus as SYSDBA:**

    **Explanation:** This step establishes a connection to the database with SYSDBA privileges, which is required to manage quotas.

    ```shell
    sqlplus / as sysdba
    ```

2. **Assign Quotas to Users in PDBLAB1:**

    - **Switch to PDBLAB1:**

      **Explanation:** This command switches the context to the PDBLAB1 container, allowing you to manage users specific to this PDB.

      ```sql
      ALTER SESSION SET CONTAINER = PDBLAB1;
      ```

    - **Assign Quota to `PDB1_USER`:**

      **Explanation:** This command assigns a quota on the USERS tablespace for `PDB1_USER`. A quota defines the amount of space that the user can use in the specified tablespace.

      ```sql
      ALTER USER PDB1_USER QUOTA 100M ON USERS;
      ```

      **Other Options:** You can assign different quotas such as `50M`, `200M`, `UNLIMITED`, etc., depending on the requirements.

    - **Assign Quota to `PDB1_ADMIN`:**

      **Explanation:** This command assigns a quota on the USERS tablespace for `PDB1_ADMIN`.

      ```sql
      ALTER USER PDB1_ADMIN QUOTA 500M ON USERS;
      ```

    - **Verify the Quotas in PDBLAB1:**

      **Explanation:** This query verifies the assigned quotas for users in PDBLAB1.

      ```sql
      SELECT username, tablespace_name, max_bytes 
      FROM dba_ts_quotas 
      WHERE username IN ('PDB1_USER', 'PDB1_ADMIN');
      ```

3. **Assign Quotas to Users in PDBLAB2:**

    - **Switch to PDBLAB2:**

      **Explanation:** This command switches the context to the PDBLAB2 container.

      ```sql
      ALTER SESSION SET CONTAINER = PDBLAB2;
      ```

    - **Assign Quota to `PDB2_USER`:**

      **Explanation:** This command assigns a quota on the USERS tablespace for `PDB2_USER`.

      ```sql
      ALTER USER PDB2_USER QUOTA 100M ON USERS;
      ```

    - **Assign Quota to `PDB2_ADMIN`:**

      **Explanation:** This command assigns a quota on the USERS tablespace for `PDB2_ADMIN`.

      ```sql
      ALTER USER PDB2_ADMIN QUOTA 500M ON USERS;
      ```

    - **Verify the Quotas in PDBLAB2:**

      **Explanation:** This query verifies the assigned quotas for users in PDBLAB2.

      ```sql
      SELECT username, tablespace_name, max_bytes 
      FROM dba_ts_quotas 
      WHERE username IN ('PDB2_USER', 'PDB2_ADMIN');
      ```

### Detailed Example:

1. **Connect to SQL*Plus as SYSDBA:**

    ```shell
    sqlplus / as sysdba
    ```

2. **Assign Quotas to Users in PDBLAB1:**

    - **Switch to PDBLAB1:**

      ```sql
      ALTER SESSION SET CONTAINER = PDBLAB1;
      ```

    - **Assign Quota to `PDB1_USER`:**

      ```sql
      ALTER USER PDB1_USER QUOTA 100M ON USERS;
      ```

    - **Assign Quota to `PDB1_ADMIN`:**

      ```sql
      ALTER USER PDB1_ADMIN QUOTA 500M ON USERS;
      ```

    - **Verify the Quotas in PDBLAB1:**

      ```sql
      SELECT username, tablespace_name, max_bytes 
      FROM dba_ts_quotas 
      WHERE username IN ('PDB1_USER', 'PDB1_ADMIN');
      ```

3. **Assign Quotas to Users in PDBLAB2:**

    - **Switch to PDBLAB2:**

      ```sql
      ALTER SESSION SET CONTAINER = PDBLAB2;
      ```

    - **Assign Quota to `PDB2_USER`:**

      ```sql
      ALTER USER PDB2_USER QUOTA 100M ON USERS;
      ```

    - **Assign Quota to `PDB2_ADMIN`:**

      ```sql
      ALTER USER PDB2_ADMIN QUOTA 500M ON USERS;
      ```

    - **Verify the Quotas in PDBLAB2:**

      ```sql
      SELECT username, tablespace_name, max_bytes 
      FROM dba_ts_quotas 
      WHERE username IN ('PDB2_USER', 'PDB2_ADMIN');
      ```

### Explanation:

- **Connecting to SQL*Plus as SYSDBA:** Provides the necessary privileges to perform administrative tasks such as managing quotas.
- **Switching to PDB:** Allows you to perform tasks specific to the selected PDB.
- **Assigning Quotas:** The `ALTER USER ... QUOTA ... ON ...` command is used to define the amount of space that a user can use in a specific tablespace.
- **Verifying Quotas:** Queries are used to ensure the quotas are assigned correctly.

By following these steps, you will assign tablespace quotas to the users in PDBLAB1 and PDBLAB2 and verify their existence within their respective PDBs.
