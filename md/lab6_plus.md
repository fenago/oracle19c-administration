
# Step-by-Step Lab: Monitoring Pluggable Databases (PDBs) within fenagoCDB

## Prerequisites
- Ensure that the `fenagoCDB` CDB is created and running.
- Ensure that the PDBs `pdb1` and `pdb2` are created and running.
- Set the `ORACLE_HOME` and `ORACLE_SID` environment variables appropriately.

## Steps

### 1. Set Environment Variables
```bash
export ORACLE_HOME=/u01/app/oracle/product/19.3.0/dbhome_1
export ORACLE_SID=fenagoCDB
```

### 2. Connect to SQL*Plus as SYSDBA
```sql
sqlplus / as sysdba
```

### 3. Check the Status of All PDBs
```sql
SELECT pdb_name, status FROM CDB_PDBS;
```

*Explanation:* This query retrieves the status of all PDBs within the CDB.

### 4. Monitor PDB Resource Usage
```sql
SELECT name, open_mode, restricted FROM V$PDBS;
```

*Explanation:* This query provides detailed information about the open mode and restricted status of each PDB.

### 5. Check PDB Datafile Usage
```sql
SELECT file_name, bytes, maxbytes, status FROM CDB_DATA_FILES WHERE con_id IN (SELECT con_id FROM CDB_PDBS WHERE pdb_name='PDB1');
```

*Explanation:* This query checks the datafile usage for `pdb1`.

```sql
SELECT file_name, bytes, maxbytes, status FROM CDB_DATA_FILES WHERE con_id IN (SELECT con_id FROM CDB_PDBS WHERE pdb_name='PDB2');
```

*Explanation:* This query checks the datafile usage for `pdb2`.

### 6. Monitor PDB Sessions
```sql
SELECT s.sid, s.serial#, s.username, s.status, s.osuser, s.machine, s.program FROM CDB_SESSIONS s WHERE s.con_id IN (SELECT con_id FROM CDB_PDBS WHERE pdb_name='PDB1');
```

*Explanation:* This query monitors active sessions in `pdb1`.

```sql
SELECT s.sid, s.serial#, s.username, s.status, s.osuser, s.machine, s.program FROM CDB_SESSIONS s WHERE s.con_id IN (SELECT con_id FROM CDB_PDBS WHERE pdb_name='PDB2');
```

*Explanation:* This query monitors active sessions in `pdb2`.

### 7. Monitor PDB Wait Events
```sql
SELECT event, total_waits, time_waited FROM CDB_WAIT_CLASSES WHERE con_id IN (SELECT con_id FROM CDB_PDBS WHERE pdb_name='PDB1');
```

*Explanation:* This query monitors wait events for `pdb1`.

```sql
SELECT event, total_waits, time_waited FROM CDB_WAIT_CLASSES WHERE con_id IN (SELECT con_id FROM CDB_PDBS WHERE pdb_name='PDB2');
```

*Explanation:* This query monitors wait events for `pdb2`.

### 8. Check PDB Performance Metrics
```sql
SELECT con_id, name, value FROM CDB_SYSSTAT WHERE con_id IN (SELECT con_id FROM CDB_PDBS WHERE pdb_name='PDB1');
```

*Explanation:* This query retrieves performance metrics for `pdb1`.

```sql
SELECT con_id, name, value FROM CDB_SYSSTAT WHERE con_id IN (SELECT con_id FROM CDB_PDBS WHERE pdb_name='PDB2');
```

*Explanation:* This query retrieves performance metrics for `pdb2`.

## Conclusion
You have successfully monitored the Pluggable Databases (PDBs) within the `fenagoCDB` Container Database (CDB). These steps include checking the status of PDBs, monitoring resource usage, datafile usage, active sessions, wait events, and performance metrics.

This guide provides a comprehensive approach to monitoring PDBs in Oracle, ensuring that you can handle both typical and exceptional scenarios effectively.
