To resolve this, follow these steps:

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

3. **Open the PDB**:
   ```sql
   ALTER PLUGGABLE DATABASE pdb1 OPEN;
   ```

4. **Switch to the PDB**:
   ```sql
   ALTER SESSION SET CONTAINER = pdb1;
   ```

5. **Run `catalog.sql`**:
   ```sql
   @$ORACLE_HOME/rdbms/admin/catalog.sql
   ```

6. **Run `catproc.sql`**:
   ```sql
   @$ORACLE_HOME/rdbms/admin/catproc.sql
   ```

7. **Exit SQL*Plus**:
   ```sql
   EXIT;
   ```

Here are the commands step-by-step:

### Step 1: Connect to SQL*Plus as SYSDBA
```sh
sqlplus / as sysdba
```

### Step 2: Ensure You Are in the Root Container (CDB)
```sql
SHOW CON_NAME;
```
If it shows something other than `CDB$ROOT`, switch to the root container:
```sql
ALTER SESSION SET CONTAINER = CDB$ROOT;
```

### Step 3: Open the PDB
```sql
ALTER PLUGGABLE DATABASE pdb1 OPEN;
```

### Step 4: Switch to the PDB
```sql
ALTER SESSION SET CONTAINER = pdb1;
```

### Step 5: Run `catalog.sql`
```sql
@$ORACLE_HOME/rdbms/admin/catalog.sql
```

### Step 6: Run `catproc.sql`
```sql
@$ORACLE_HOME/rdbms/admin/catproc.sql
```

### Step 7: Exit SQL*Plus
```sql
EXIT;
```

These steps ensure that you have the necessary privileges to perform the required actions. Make sure you are connected as `SYSDBA` to avoid privilege issues.
