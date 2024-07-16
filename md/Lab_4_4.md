### Lab 4.4: Configuring and Accessing Oracle Enterprise Manager (EM) Express
#### Objective:
To configure and access Oracle Enterprise Manager (EM) Express for managing the CDBDEV database. EM Express provides a web-based interface for database administration and performance monitoring.

### Steps:

#### 1. Verify EM Express Configuration
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

3. **Check if EM Express is configured**:
    ```sql
    SELECT DBMS_XDB_CONFIG.GETHTTPSPORT() AS HTTPS_PORT FROM DUAL;
    SELECT DBMS_XDB_CONFIG.GETHTTPPORT() AS HTTP_PORT FROM DUAL;
    ```

    If the ports are not set, you will need to configure them.

#### 2. Configure EM Express Ports
1. **Set the HTTPS and HTTP ports**:
    ```sql
    EXEC DBMS_XDB_CONFIG.SETHTTPSPORT(5500);
    EXEC DBMS_XDB_CONFIG.SETHTTPPORT(8080);
    ```

2. **Verify the ports are set**:
    ```sql
    SELECT DBMS_XDB_CONFIG.GETHTTPSPORT() AS HTTPS_PORT FROM DUAL;
    SELECT DBMS_XDB_CONFIG.GETHTTPPORT() AS HTTP_PORT FROM DUAL;
    ```

#### 3. Enable EM Express Access
1. **Enable XDB Protocol Server**:
    ```sql
    ALTER SYSTEM SET DISPATCHERS='(PROTOCOL=TCP) (SERVICE=CDBDEVXDB)';
    ```

2. **Verify the configuration**:
    ```sql
    SELECT VALUE FROM V$PARAMETER WHERE NAME = 'dispatchers';
    ```

#### 4. Open Required Ports in Firewall
Ensure that the ports 5500 (HTTPS) and 8080 (HTTP) are open in the firewall settings to allow access to EM Express.

1. **Open ports in the firewall** (as root):
    ```bash
    firewall-cmd --permanent --add-port=5500/tcp
    firewall-cmd --permanent --add-port=8080/tcp
    firewall-cmd --reload
    ```

#### 5. Access EM Express
1. **Open a web browser** and enter the following URL to access EM Express:
    ```plaintext
    https://<hostname>:5500/em
    ```
    or
    ```plaintext
    http://<hostname>:8080/em
    ```

2. **Login with SYSDBA credentials**:
    - **Username**: `SYS`
    - **Password**: `fenago`
    - **Role**: `SYSDBA`

#### 6. Explore EM Express Features
1. **Dashboard**:
    - View the database performance summary, session activity, and storage information.

2. **Performance Hub**:
    - Access real-time and historical performance data.
    - Monitor SQL performance, Active Session History (ASH), and other performance metrics.

3. **Storage Management**:
    - Manage tablespaces, datafiles, and other storage components.

4. **Security Management**:
    - Create and manage users and roles.
    - Configure auditing and manage security policies.

5. **Database Configuration**:
    - View and modify initialization parameters.
    - Manage database instances and services.

6. **SQL and PL/SQL**:
    - Execute SQL queries and PL/SQL scripts.
    - Monitor and manage PL/SQL objects.

#### Summary
By following these steps, you will configure and access Oracle Enterprise Manager (EM) Express for managing the CDBDEV database. EM Express provides a comprehensive web-based interface for database administration, performance monitoring, and troubleshooting. This lab ensures you can effectively use EM Express to manage and monitor your Oracle database environment.
