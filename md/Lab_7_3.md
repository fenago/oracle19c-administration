# Lab: Backup and Restore Oracle CDB and PDB

## Objective:
To learn the basics of backing up the CDBLAB and one of its PDBs, and how to restore the PDBs. The lab will also cover common issues that can occur during the recovery/restore process and ways to mitigate them.

### Prerequisites:
- Oracle Database is installed and running.
- CDBLAB with at least one PDB (PDBLAB1) is available.
- RMAN (Recovery Manager) is configured.

### Steps:

### 1. Backup the CDB (CDBLAB)

**Explanation:**
Backing up the entire CDB ensures that you can restore the complete environment, including all PDBs, in case of a failure.

1. **Connect to RMAN:**
   - **Terminal:**
     - Open a terminal and connect to RMAN as the Oracle user.
     ```bash
     rman target /
     ```

2. **Backup the CDB:**
   - **RMAN:**
     - Run the following commands to back up the entire CDB.
     ```rman
     RUN {
       BACKUP DATABASE PLUS ARCHIVELOG;
       BACKUP CURRENT CONTROLFILE;
     }
     ```

3. **Verify the Backup:**
   - **RMAN:**
     - List the backups to verify.
     ```rman
     LIST BACKUP;
     ```

### 2. Backup a PDB (PDBLAB1)

**Explanation:**
Backing up individual PDBs allows for more granular recovery and can save time and resources compared to backing up the entire CDB.

1. **Backup the PDB:**
   - **RMAN:**
     - Run the following command to back up the PDBLAB1.
     ```rman
     RUN {
       BACKUP PLUGGABLE DATABASE PDBLAB1 PLUS ARCHIVELOG;
     }
     ```

2. **Verify the Backup:**
   - **RMAN:**
     - List the backups to verify.
     ```rman
     LIST BACKUP OF PLUGGABLE DATABASE PDBLAB1;
     ```

### 3. Restore the PDB (PDBLAB1)

**Explanation:**
Restoring a PDB involves bringing back the database to a specific point in time using the backups. This is useful in case of data corruption or accidental data loss.

1. **Restore the PDB:**
   - **RMAN:**
     - Run the following commands to restore PDBLAB1.
     ```rman
     RUN {
       SHUTDOWN IMMEDIATE;
       STARTUP MOUNT;
       RESTORE PLUGGABLE DATABASE PDBLAB1;
       RECOVER PLUGGABLE DATABASE PDBLAB1;
       ALTER PLUGGABLE DATABASE PDBLAB1 OPEN RESETLOGS;
     }
     ```

2. **Verify the Restoration:**
   - **SQL*Plus (Terminal):**
     - Connect to SQL*Plus and verify the status of the PDB.
     ```sql
     sqlplus / as sysdba
     SELECT NAME, OPEN_MODE FROM V$PDBS WHERE NAME = 'PDBLAB1';
     ```

### 4. Common Issues and Mitigation Strategies

**Explanation:**
During the backup and restore process, several issues can arise. Understanding these potential problems and their solutions is crucial for successful database management.

1. **Common Issues:**
   - **Corrupt Backup Files:**
     - Issue: Backup files may become corrupt and unusable.
     - Mitigation: Regularly validate backups using RMAN's `VALIDATE` command.
     ```rman
     VALIDATE BACKUPSET <backup_set_id>;
     ```

   - **Insufficient Disk Space:**
     - Issue: Lack of disk space can interrupt the backup process.
     - Mitigation: Monitor disk usage and configure RMAN to use multiple backup destinations.

   - **Incomplete Backups:**
     - Issue: Backups may be incomplete due to errors or interruptions.
     - Mitigation: Use RMAN's `CHECK LOGICAL` option to ensure backups are logically complete.
     ```rman
     BACKUP CHECK LOGICAL DATABASE;
     ```

   - **Recovery Failures:**
     - Issue: Recovery process may fail due to missing files or incorrect commands.
     - Mitigation: Ensure all necessary archive logs and backups are available. Use RMAN's `CATALOG` command to update RMAN repository with any missing files.
     ```rman
     CATALOG START WITH '<backup_location>';
     ```

2. **Testing Backups:**
   - Regularly test the restore process in a non-production environment to ensure backups are valid and the recovery process is understood.

### Summary:

By following these steps, you will have learned the basics of backing up and restoring Oracle CDB and PDB. This lab covers essential commands and procedures using RMAN, provides validation checks, and discusses common issues and mitigation strategies to ensure a smooth backup and recovery process.
