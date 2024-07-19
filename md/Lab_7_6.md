# Lab: Uninstalling Oracle 19c and Installing Oracle 21c Using wget

## Objective:
To find and terminate all running Oracle instances and listeners, uninstall Oracle 19c, download and install Oracle 21c, create a new CDB and PDB, and verify the installation using SQL Developer.

## Prerequisites:
- Root or sudo privileges on the server.
- Internet access to download the Oracle binaries.

### Steps:

### 1. Find and Terminate All Running Oracle Instances and Listeners

**Explanation:**
Before uninstalling Oracle, it's crucial to terminate all running Oracle instances and listeners.

1. **Find All Running Oracle Instances and Listeners:**
   - Use the following commands to identify all running Oracle processes.

   ```bash
   ps -ef | grep pmon
   ps -ef | grep lsnrctl
   ```

2. **Terminate All Running Oracle Instances and Listeners:**
   - Use `kill -9` to terminate all identified Oracle processes.

   ```bash
   for pid in $(ps -ef | grep pmon | grep -v grep | awk '{print $2}'); do
       sudo kill -9 $pid
   done

   for pid in $(ps -ef | grep lsnrctl | grep -v grep | awk '{print $2}'); do
       sudo kill -9 $pid
   done
   ```

3. **Verify Termination:**
   - Ensure that no Oracle processes are running.

   ```bash
   ps -ef | grep pmon
   ps -ef | grep lsnrctl
   ```

### 2. Uninstall Existing Oracle 19c Installation

**Explanation:**
Before installing a new copy of Oracle, it's essential to remove the existing installation completely.

1. **Stop Oracle Services:**
   - Switch to the Oracle user and stop any remaining Oracle services.

   ```bash
   su - oracle
   sqlplus / as sysdba
   SHUTDOWN IMMEDIATE;
   exit
   lsnrctl stop
   ```

2. **Remove Oracle Directories:**
   - Remove the Oracle installation directories. Ensure you have the correct paths.

   ```bash
   su - root
   rm -rf /u01/app/oracle
   rm -rf /u01/app/oraInventory
   rm -rf /etc/oratab
   ```

3. **Remove Oracle User and Groups:**
   - Remove the Oracle user and groups.

   ```bash
   userdel -r oracle
   groupdel oinstall
   groupdel dba
   ```

### 3. Download Oracle 21c Installation Files

**Explanation:**
Use `wget` to download the Oracle binaries from the Oracle website.

1. **Create Download Directory:**
   - Create a directory to store the Oracle installation files.

   ```bash
   mkdir -p /opt/oracle/install
   cd /opt/oracle/install
   ```

2. **Download Oracle Binaries Using wget:**
   - Download the Oracle binaries. Note that you may need to accept the Oracle license agreement and use the appropriate `wget` command with cookies. Replace `<URL>` with the actual download link obtained from the Oracle website.

   ```bash
   wget --no-cookies --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" -O oracle-database-xe-21c-1.0-1.ol7.x86_64.rpm https://download.oracle.com/otn-pub/otn_software/database/oracle-database-xe-21c-1.0-1.ol7.x86_64.rpm
   ```

### 4. Install Oracle Database

**Explanation:**
Follow the steps to install Oracle Database using the downloaded binary.

1. **Install Prerequisites:**
   - Install any required prerequisites for Oracle.

   ```bash
   sudo yum install -y oracle-database-preinstall-21c
   ```

2. **Install Oracle Database:**
   - Install the Oracle Database RPM package.

   ```bash
   sudo yum localinstall -y oracle-database-xe-21c-1.0-1.ol7.x86_64.rpm
   ```

3. **Configure Oracle Database:**
   - Run the configuration script to set up Oracle Database.

   ```bash
   sudo /etc/init.d/oracle-xe-21c configure
   ```

### 5. Create a New CDB and PDB

**Explanation:**
Use DBCA to create a new CDB named `CDBLAB2` and a PDB named `PDBLAB1_CDBLAB2`.

1. **Run DBCA to Create a New CDB and PDB:**

   ```bash
   dbca -silent -createDatabase -gdbname CDBLAB2 -sid CDBLAB2 -createAsContainerDatabase true -numberOfPDBs 1 -pdbName PDBLAB1_CDBLAB2 -pdbAdminPassword PDBAdminPassword1 -templateName General_Purpose.dbc -responseFile NO_VALUE -characterSet AL32UTF8 -sysPassword SysPassword1 -systemPassword SystemPassword1 -createListener -emConfiguration LOCAL
   ```

2. **Verify the Database Creation:**
   - Connect to the new CDB and PDB using SQL*Plus to verify.

   ```bash
   sqlplus / as sysdba
   SELECT NAME, OPEN_MODE FROM V$PDBS;
   ```

### 6. Verify Installation and Connectivity with SQL Developer

**Explanation:**
Verify the new Oracle installation and connectivity using SQL Developer.

1. **Download and Install SQL Developer:**
   - If not already installed, download and install SQL Developer from the Oracle website.

2. **Create a Connection to CDBLAB2:**
   - Open SQL Developer and create a new connection:
     - Connection Name: `CDBLAB2`
     - Username: `sys`
     - Password: `SysPassword1`
     - Connection Type: `Basic`
     - Role: `SYSDBA`
     - Hostname: `localhost`
     - Port: `1521`
     - Service Name: `CDBLAB2`

3. **Create a Connection to PDBLAB1_CDBLAB2:**
   - Create another connection:
     - Connection Name: `PDBLAB1_CDBLAB2`
     - Username: `pdbadmin`
     - Password: `PDBAdminPassword1`
     - Connection Type: `Basic`
     - Hostname: `localhost`
     - Port: `1521`
     - Service Name: `PDBLAB1_CDBLAB2`

4. **Test and Verify Connections:**
   - Click the `Test` button for each connection to verify connectivity.
   - Once verified, click `Connect` to open the connection.

### Summary:

By following these steps, you will have successfully uninstalled the existing Oracle 19c installation, downloaded and installed Oracle 21c, created a new CDB named `CDBLAB2` with a PDB named `PDBLAB1_CDBLAB2`, and verified the installation and connectivity using SQL Developer. This lab provides a comprehensive guide to managing Oracle installations, ensuring you have a clean and up-to-date Oracle environment.
