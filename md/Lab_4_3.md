### Lab 4.3: Using Automatic Diagnostic Repository (ADR) in Oracle Database
#### Objective:
To understand and utilize the Automatic Diagnostic Repository (ADR) for diagnosing and resolving issues in the Oracle Database environment. This lab will guide you through a use case involving ADR in the CDBDEV environment with its associated PDBs.

### Steps:

#### 1. Understanding ADR and its Components
The Automatic Diagnostic Repository (ADR) is a file-based repository for storing database diagnostic data such as traces, dumps, alert logs, and other diagnostic data. ADR simplifies diagnostics by providing tools to manage and analyze diagnostic data efficiently.

#### 2. Accessing ADR and Configuring ADR Homes
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

3. **Verify ADR Base and ADR Home settings**:
    ```sql
    SHOW PARAMETER diagnostic_dest;
    ```

    The `diagnostic_dest` parameter should point to the ADR base directory, typically `$ORACLE_BASE`.

4. **Check the ADR Home structure**:
    ```bash
    cd $ORACLE_BASE/diag/rdbms/cdbdev/CDBDEV
    ls -l
    ```

#### 3. Generating Diagnostic Data
To simulate a use case for ADR, we'll generate some diagnostic data by causing a deliberate error.

1. **Connect to PDB1**:
    ```bash
    sqlplus pdbadmin/fenago@localhost:1521/pdb1
    ```

2. **Generate an ORA-00600 internal error**:
    ```sql
    CREATE OR REPLACE PROCEDURE cause_error AS
    BEGIN
      RAISE_APPLICATION_ERROR(-20001, 'Deliberate Error for ADR Lab');
    END;
    /

    EXEC cause_error;
    ```

3. **Check the alert log for PDB1**:
    ```bash
    cd $ORACLE_BASE/diag/rdbms/cdbdev/pdb1/trace
    tail -f alert_pdb1.log
    ```

#### 4. Using ADRCI (ADR Command Interpreter)
ADRCI is a command-line tool to manage and view diagnostic data in ADR.

1. **Start ADRCI**:
    ```bash
    adrci
    ```

2. **Show ADR homes**:
    ```plaintext
    adrci> show homes
    ```

    This will list all ADR homes for the database and its components.

3. **Set the ADR home for CDBDEV**:
    ```plaintext
    adrci> set home diag/rdbms/cdbdev/CDBDEV
    ```

4. **View the alert log**:
    ```plaintext
    adrci> show alert -tail -f
    ```

5. **View recent incidents**:
    ```plaintext
    adrci> show incident -last 10
    ```

6. **Package incidents for support**:
    ```plaintext
    adrci> ips create package problem 1
    adrci> ips add incident <incident_id> package <package_id>
    adrci> ips generate package <package_id> in /tmp
    ```

7. **Exit ADRCI**:
    ```plaintext
    adrci> exit
    ```

#### 5. Managing Diagnostic Data
1. **Purge old diagnostic data**:
    ```bash
    adrci
    ```

    ```plaintext
    adrci> purge -age 1440
    ```

    This command purges diagnostic data older than 24 hours (1440 minutes).

2. **Automatic purge configuration**:
    ```sql
    BEGIN
      DBMS_SCHEDULER.create_job (
        job_name        => 'PURGE_OLD_DIAGNOSTICS',
        job_type        => 'PLSQL_BLOCK',
        job_action      => 'BEGIN DBMS_ADVISOR.create_task(purge); END;',
        start_date      => SYSTIMESTAMP,
        repeat_interval => 'FREQ=DAILY; BYHOUR=2; BYMINUTE=0; BYSECOND=0',
        enabled         => TRUE
      );
    END;
    /
    ```

#### Summary
By following these steps, you will understand how to use ADR to manage and analyze diagnostic data in your Oracle Database environment. This lab demonstrates how to generate diagnostic data, use ADRCI to manage and view this data, and automate the purging of old diagnostic data. This knowledge is crucial for effective database administration and troubleshooting.
