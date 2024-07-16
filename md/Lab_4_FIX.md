Let's go through the steps to open `pdb1` and `pdb2` and ensure they are correctly configured. Additionally, I will show you how to manually set the environment variables.

### Manually Setting Environment Variables

First, set the environment variables. Ensure you replace `<your_values>` with the appropriate values for your environment.

```sh
xhost +
su - oracle
```
then set the environment

```sh
export ORACLE_BASE=/u01/app/oracle
export ORACLE_HOME=/u01/app/oracle/product/19.3.0/dbhome_1
export ORACLE_SID=CDBDEV
export PATH=$ORACLE_HOME/bin:$PATH
```

### Steps to Open `pdb1` and `pdb2` and Run `catalog.sql` and `catproc.sql`

1. **Connect to SQL*Plus as SYSDBA**:
   ```sh
   sqlplus / as sysdba
   ```

2. **Ensure you are in the root container (CDB)**:
   ```sql
   SHOW CON_NAME;
   ```

   If it does not show `CDB$ROOT`, switch to the root container:
   ```sql
   ALTER SESSION SET CONTAINER = CDB$ROOT;
   ```

3. **Open the PDBs**:
   ```sql
   ALTER PLUGGABLE DATABASE pdb1 OPEN;
   ALTER PLUGGABLE DATABASE pdb2 OPEN;
   ```

4. **Switch to the PDB and run `catalog.sql` and `catproc.sql` for each PDB**:

   - **For `pdb1`**:
     ```sql
     ALTER SESSION SET CONTAINER = pdb1;
     @$ORACLE_HOME/rdbms/admin/catalog.sql;
     @$ORACLE_HOME/rdbms/admin/catproc.sql;
     ```

   - **For `pdb2`**:
     ```sql
     ALTER SESSION SET CONTAINER = pdb2;
     @$ORACLE_HOME/rdbms/admin/catalog.sql;
     @$ORACLE_HOME/rdbms/admin/catproc.sql;
     ```

5. **Exit SQL*Plus**:
   ```sql
   EXIT;
   ```

### Full Command Sequence

Here is the full sequence of commands:

### Set Environment Variables
```sh
export ORACLE_BASE=/u01/app/oracle
export ORACLE_HOME=/u01/app/oracle/product/19.3.0/dbhome_1
export ORACLE_SID=CDBDEV
export PATH=$ORACLE_HOME/bin:$PATH
```

### Open and Configure PDBs
```sh
sqlplus / as sysdba
```

#### Ensure you are in the root container
```sql
SHOW CON_NAME;

-- If not in CDB$ROOT
ALTER SESSION SET CONTAINER = CDB$ROOT;
```

#### Open the PDBs
```sql
ALTER PLUGGABLE DATABASE pdb1 OPEN;
ALTER PLUGGABLE DATABASE pdb2 OPEN;
```

#### Switch to `pdb1` and run the scripts
```sql
ALTER SESSION SET CONTAINER = pdb1;
@$ORACLE_HOME/rdbms/admin/catalog.sql;
@$ORACLE_HOME/rdbms/admin/catproc.sql;
```

#### Switch to `pdb2` and run the scripts
```sql
ALTER SESSION SET CONTAINER = pdb2;
@$ORACLE_HOME/rdbms/admin/catalog.sql;
@$ORACLE_HOME/rdbms/admin/catproc.sql;
```

#### Exit SQL*Plus
```sql
EXIT;
```

### Verify the PDBs
After following the above steps, you should verify that `pdb1` and `pdb2` are open and properly configured.

### Check the Status of the PDBs
Reconnect to SQL*Plus:
```sh
sqlplus / as sysdba
```

#### Verify the PDBs are open
```sql
SHOW PDBS;
```

### Test the PDB Connections
Finally, use SQL*Plus to connect to `pdb1` and `pdb2` to ensure they are accessible.

```sh
sqlplus pdbadmin/fenago@localhost:1521/pdb1
sqlplus pdbadmin/fenago@localhost:1521/pdb2
```

By following these steps, you should be able to open and configure `pdb1` and `pdb2`, and verify their status and connectivity.
