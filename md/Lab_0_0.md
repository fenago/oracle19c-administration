### Lab Instructions: Creating a Small Database Called `drlee`

In this lab, I will guide you through the process of creating a small Oracle database called `drlee` using the Database Configuration Assistant (DBCA) in silent mode. We will use a template similar to the provided example for `ORCL`. 

#### Prerequisites
- Ensure Oracle Database software is installed.
- Ensure Oracle environment variables are set (`ORACLE_HOME`, `PATH`, etc.).
- Sufficient privileges to create and delete databases.

#### Step-by-Step Instructions

#### Step 1: Create the `drlee` Database

1. **Navigate to the DBCA binary location:**

   ```bash
   cd $ORACLE_HOME/bin
   ```

2. **Execute the following command to create the `drlee` database:**

   ```bash
   ./dbca -silent -createDatabase \
   -templateName General_Purpose.dbc \
   -gdbname drlee \
   -sid drlee \
   -createAsContainerDatabase true \
   -numberOfPDBs 1 \
   -pdbName pdb1 \
   -useLocalUndoForPDBs true \
   -responseFile NO_VALUE \
   -characterSet AL32UTF8 \
   -totalMemory 1024 \
   -sysPassword Welcome_1 \
   -systemPassword Welcome_1 \
   -pdbAdminPassword Welcome_1 \
   -emConfiguration DBEXPRESS \
   -dbsnmpPassword Welcome_1 \
   -emExpressPort 5500 \
   -enableArchive true \
   -recoveryAreaDestination /u03/app/oracle/fast_recovery_area \
   -recoveryAreaSize 5000 \
   -datafileDestination /u02/app/oracle/oradata
   ```

   This command will create a new container database named `drlee` with a pluggable database `pdb1`. Adjust memory settings and file destinations as needed for your environment.

#### Step 2: Verify the Creation of `drlee`

1. **Check the status of the newly created database:**

   ```bash
   sqlplus / as sysdba
   ```

2. **Connect to the `drlee` database:**

   ```sql
   SELECT NAME, OPEN_MODE FROM V$PDBS;
   ```

   Ensure that the `drlee` database and its pluggable database `pdb1` are listed and in the appropriate OPEN mode.

#### Step 3: Delete the `drlee` Database

1. **Navigate to the DBCA binary location (if not already there):**

   ```bash
   cd $ORACLE_HOME/bin
   ```

2. **Execute the following command to delete the `drlee` database:**

   ```bash
   ./dbca -silent -deleteDatabase \
   -sourceDB drlee \
   -sid drlee \
   -sysPassword Welcome_1
   ```

   This command will remove the `drlee` database from the system.

### Summary

In this lab, you have learned how to create and delete a small Oracle database named `drlee` using the DBCA in silent mode. You have also verified the creation of the database and its pluggable database. This process is essential for managing Oracle databases efficiently in various environments.
