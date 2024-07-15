### Lab 3.1: Creating a New CDB Using DBCA GUI and Response File

**Objective:**
To create a new Container Database (CDB) named `CDBTEST` using the DBCA GUI, save the response file, and use it to create a second CDB in silent mode. The steps will include starting and stopping both CDBs.

**Steps:**

#### Part A: Create the First CDB Using DBCA GUI

1. **Set Up Environment Variables**

   Open a terminal and set the Oracle environment variables:

   ```sh
   export ORACLE_SID=CDBTEST
   export ORACLE_HOME=/u01/app/oracle/product/19.3.0/dbhome_1
   export PATH=$ORACLE_HOME/bin:$PATH
   ```

2. **Launch DBCA GUI**

   Start the Database Configuration Assistant (DBCA) with the GUI:

   ```sh
   dbca
   ```

3. **Create a New Database**

   Follow these steps in the DBCA GUI:

   - **Welcome Screen**: Click `Next`.
   - **Database Operation**: Select `Create a database` and click `Next`.
   - **Creation Mode**: Select `Advanced configuration` and click `Next`.
   - **Database Template**: Choose `General Purpose or Transaction Processing` and click `Next`.
   - **Database Identification**: Enter `Global Database Name: CDBTEST` and `SID: CDBTEST`. Click `Next`.
   - **Management Options**: Enable `Configure Enterprise Manager (EM) Express` and set the port to `5502`. Click `Next`.
   - **Storage Option**: Select `File System` and click `Next`.
   - **Database File Locations**: Set the database file location to `/u01/app/oracle/oradata/CDBTEST`. Click `Next`.
   - **Fast Recovery Area**: Enable it and set the location to `/u01/app/oracle/fast_recovery_area` with size `2048 MB`. Click `Next`.
   - **Network Configuration**: Ensure listener is configured. Click `Next`.
   - **Data Vault Option**: Skip this step by clicking `Next`.
   - **Initialization Parameters**: Set memory to `2048 MB`, `Processes` to `300`, and ensure `Character Set` is `AL32UTF8`. Click `Next`.
   - **Storage Locations**: Verify the storage settings and click `Next`.
   - **Creation Options**: Select `Create Database` and check `Generate Database Creation Scripts`. Click `Next`.

4. **Save the Response File**

   In the summary screen, save the response file for future use:

   - Click on `Save Response File`.
   - Save it as `/u01/app/oracle/product/19.3.0/dbhome_1/dbca_CDBTEST.rsp`.

5. **Create the Database**

   Click `Finish` to create the database.

6. **Verify the Database Creation**

   After the database is created, connect to it and verify:

   ```sh
   sqlplus / as sysdba
   SQL> SELECT name, open_mode FROM v$database;
   ```

   Expected Output:

   ```sh
   NAME    OPEN_MODE
   ------- ----------
   CDBTEST READ WRITE
   ```

7. **Check EM Express Port**

   Verify EM Express configuration:

   ```sh
   SELECT dbms_xdb_config.getHttpsPort() FROM dual;
   ```

   Expected Output:

   ```sh
   GETHTTPSPORT
   ------------
   5502
   ```

8. **Stop the Database**

   ```sh
   sqlplus / as sysdba
   SQL> SHUTDOWN IMMEDIATE;
   ```

#### Part B: Create the Second CDB Using the Response File

1. **Edit the Response File**

   Edit the saved response file to create a new CDB named `CDBTEST2`:

   ```sh
   cp /u01/app/oracle/product/19.3.0/dbhome_1/dbca_CDBTEST.rsp /u01/app/oracle/product/19.3.0/dbhome_1/dbca_CDBTEST2.rsp
   nano /u01/app/oracle/product/19.3.0/dbhome_1/dbca_CDBTEST2.rsp
   ```

   Change the following parameters:

   ```ini
   [CREATEDATABASE]
   GDBNAME = "CDBTEST2"
   SID = "CDBTEST2"
   ```

2. **Run DBCA in Silent Mode**

   Run DBCA in silent mode using the edited response file:

   ```sh
   dbca -silent -createDatabase -responseFile /u01/app/oracle/product/19.3.0/dbhome_1/dbca_CDBTEST2.rsp
   ```

3. **Verify the Second Database Creation**

   After the database is created, connect to it and verify:

   ```sh
   export ORACLE_SID=CDBTEST2
   sqlplus / as sysdba
   SQL> SELECT name, open_mode FROM v$database;
   ```

   Expected Output:

   ```sh
   NAME      OPEN_MODE
   --------- ----------
   CDBTEST2  READ WRITE
   ```

4. **Check EM Express Port for the Second CDB**

   Verify EM Express configuration for `CDBTEST2`:

   ```sh
   SELECT dbms_xdb_config.getHttpsPort() FROM dual;
   ```

   Expected Output:

   ```sh
   GETHTTPSPORT
   ------------
   5502
   ```

5. **Stop the Second Database**

   ```sh
   sqlplus / as sysdba
   SQL> SHUTDOWN IMMEDIATE;
   ```

6. **Start the First Database**

   ```sh
   export ORACLE_SID=CDBTEST
   sqlplus / as sysdba
   SQL> STARTUP;
   ```

### Summary

In this lab, you created a new CDB named `CDBTEST` using the DBCA GUI, saved the response file, and used it to create a second CDB named `CDBTEST2` in silent mode. You verified the creation of both databases, checked the EM Express configuration, and managed the database instances. This practice helps you understand both GUI-based and silent mode database creation and management in Oracle.
