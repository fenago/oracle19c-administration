### Lab 3.1: Creating a New CDB

#### Objective:
To create a new Container Database (CDB) named `CDBTEST` using DBCA in silent mode with specified characteristics.

#### Steps:

1. **Set Up Environment Variables**

   First, make sure the Oracle environment variables are set correctly. Run the following commands to set the Oracle environment:
   ```sh
   export ORACLE_SID=CDBTEST
   export ORACLE_HOME=/u01/app/oracle/product/19.3.0/dbhome_1
   export PATH=$ORACLE_HOME/bin:$PATH
   ```

2. **Create a Response File for DBCA**

   Create a response file named `dbca_cdbtest.rsp` with the following content:
   ```sh
   touch /u01/app/oracle/product/19.3.0/dbhome_1/dbca_cdbtest.rsp
   ```

   Edit the file with your preferred text editor and add the following:
   ```sh
   nano /u01/app/oracle/product/19.3.0/dbhome_1/dbca_cdbtest.rsp
   ```

   **Note:** You can also use `vscode`.

   Copy and paste the following configuration into the response file:
   ```ini
   [GENERAL]
   RESPONSEFILE_VERSION = "19.0.0"
   OPERATION_TYPE = "createDatabase"
   
   [CREATEDATABASE]
   GDBNAME = "CDBTEST"
   SID = "CDBTEST"
   TEMPLATE_NAME = "General_Purpose.dbc"
   SYSPASSWORD = "fenago"
   SYSTEMPASSWORD = "fenago"
   DATAFILEDESTINATION = "/u01/app/oracle/oradata/CDBTEST"
   STORAGE_TYPE = "FS"
   CHARACTERSET = "AL32UTF8"
   NATIONALCHARACTERSET = "AL16UTF16"
   TOTALMEMORY = "2048"
   
   [CREATEPLUGGABLEDATABASE]
   TEMPDATADIR = "/u01/app/oracle/oradata/CDBTEST/temp01.dbf"
   
   [INITPARAMS]
   db_create_file_dest = "/u01/app/oracle/oradata/CDBTEST"
   db_create_online_log_dest_1 = "/u01/app/oracle/oradata/CDBTEST"
   enable_pluggable_database = TRUE
   db_block_size = 8192
   db_domain = ""
   db_name = CDBTEST
   db_unique_name = CDBTEST
   open_cursors = 300
   processes = 300
   audit_file_dest = /u01/app/oracle/admin/CDBTEST/adump
   audit_trail = db
   compatible = 19.0.0
   control_files = ("/u01/app/oracle/oradata/CDBTEST/control01.ctl")
   db_recovery_file_dest = /u01/app/oracle/fast_recovery_area
   db_recovery_file_dest_size = 2G
   diagnostic_dest = /u01/app/oracle
   remote_login_passwordfile = EXCLUSIVE
   undo_tablespace = UNDOTBS
   ```

3. **Run DBCA in Silent Mode**

   Before running the DBCA command, you can validate the response file using:
   ```sh
   dbca -silent -validate -responseFile /u01/app/oracle/product/19.3.0/dbhome_1/dbca_cdbtest.rsp
   ```
   
   Use the following command to run DBCA in silent mode with the created response file:
   ```sh
   $ORACLE_HOME/bin/dbca -silent -createDatabase -responseFile /u01/app/oracle/product/19.3.0/dbhome_1/dbca_cdbtest.rsp
   ```

4. **Verify the Creation of the CDB**

   Once DBCA completes, you should verify the creation of the CDB by connecting to the database and checking its status.

   **Switch to the Oracle User:**
   ```sh
   su - oracle
   ```

   **Connect to the Database:**
   ```sh
   sqlplus / as sysdba
   ```

   **Check the CDB Status:**
   ```sql
   SELECT name, open_mode FROM v$database;
   ```

   **Expected Output:**
   The output should confirm that the database `CDBTEST` is created and open.

5. **Check the EM Express Port**

   To verify that the EM Express is configured correctly on port 5502, run the following SQL command:
   ```sql
   SELECT dbms_xdb_config.getHttpsPort() FROM dual;
   ```

   **Expected Output:**
   The port number should be 5502.

### Summary
By following these steps, you will successfully create a new CDB named `CDBTEST` using DBCA in silent mode with the specified characteristics. This practice helps in understanding the automated creation of databases and configuring essential parameters using response files.
