Let's provide detailed instructions including the exact commands and replacing placeholders with actual values for clarity.

## Lab 7.4: Setting Up and Understanding AWR (Automatic Workload Repository)

### Objective:
To configure and understand the main points of the Automatic Workload Repository (AWR) using SQL Developer.

### Prerequisites:
- Oracle Database is installed and running.
- You have SYSDBA privileges.
- SQL Developer is installed and configured.

### Steps:

### 1. Introduction to AWR

The Automatic Workload Repository (AWR) is a repository that collects, processes, and maintains performance statistics. These statistics are crucial for diagnosing performance issues and tuning the database.

### 2. Checking AWR Configuration

1. **Connect to the Database as SYSDBA:**
   - Open SQL Developer and create a connection with the following details:
     - **Connection Name:** SYSDBA_CDBLAB
     - **Username:** sys
     - **Password:** fenago
     - **Connection Type:** Basic
     - **Role:** SYSDBA
     - **Hostname:** localhost
     - **Port:** 1521
     - **Service Name:** CDBLAB
   - Click `Test` to verify the connection and then `Connect`.

2. **Check the AWR Configuration:**
   - Open a SQL Worksheet and run the following query to check the current AWR settings:

     ```sql
     SELECT snap_interval, retention FROM dba_hist_wr_control;
     ```

   - **snap_interval:** Interval between each AWR snapshot.
   - **retention:** Duration for which AWR data is retained.

### 3. Modifying AWR Snapshot Settings

1. **Adjust AWR Snapshot Interval and Retention:**
   - To modify the snapshot interval and retention period, run the following PL/SQL block:

     ```sql
     BEGIN
       DBMS_WORKLOAD_REPOSITORY.modify_snapshot_settings(
         interval => 60,   -- Snapshot interval in minutes
         retention => 43200  -- Retention period in minutes (30 days)
       );
     END;
     ```

2. **Verify the Changes:**
   - Run the following SQL statement separately to verify the changes:

     ```sql
     SELECT snap_interval, retention FROM dba_hist_wr_control;
     ```

### 4. Manually Creating AWR Snapshots

1. **Create a Manual AWR Snapshot:**
   - To create a manual AWR snapshot, run the following command:

     ```sql
     EXEC DBMS_WORKLOAD_REPOSITORY.create_snapshot;
     ```

2. **Verify the Snapshot:**
   - Check the latest snapshots using:

     ```sql
     SELECT snap_id, begin_interval_time, end_interval_time
     FROM dba_hist_snapshot
     ORDER BY snap_id DESC;
     ```

3. **Note the Snapshot IDs:**
   - Note down the `snap_id` of the two most recent snapshots from the output. You will need these for generating the AWR report.

### 5. Generating AWR Reports

1. **Generate an AWR Report:**
   - To generate an AWR report, you need two snapshot IDs. Replace `begin_snap_id` and `end_snap_id` with the actual snapshot IDs obtained in the previous step. Use the following SQL to generate an HTML report:

     ```sql
     DECLARE
       l_dbid       NUMBER;
       l_inst_num   NUMBER;
       l_bid        NUMBER := <begin_snap_id>;  -- Replace with actual begin snapshot ID
       l_eid        NUMBER := <end_snap_id>;    -- Replace with actual end snapshot ID
       l_rpt_type   VARCHAR2(20) := 'HTML';
       l_output     CLOB;
     BEGIN
       SELECT dbid, instance_number INTO l_dbid, l_inst_num FROM v$instance;

       l_output := DBMS_WORKLOAD_REPOSITORY.awr_report_html(
                      l_dbid, l_inst_num, l_bid, l_eid);

       DBMS_XDB.storeCLOB('/public/awr_report.html', l_output, TRUE);
     END;
     /

     -- Access the report at http://localhost:5500/public/awr_report.html
     ```

### 6. Understanding Key Sections of AWR Report

1. **Overview of AWR Report:**
   - The AWR report is divided into several sections. Key sections include:
     - **Cache Sizes:** Information about SGA and PGA usage.
     - **Load Profile:** Provides key performance metrics over the snapshot period.
     - **Instance Efficiency Percentages:** Measures how well the instance is performing.
     - **Top 5 Timed Foreground Events:** Identifies the top events where most time is spent.
     - **SQL Statistics:** Information about SQL statements that consumed significant resources.

2. **Important Metrics:**
   - **DB Time:** Total time spent by user processes either actively working or waiting for database resources.
   - **DB CPU:** Total CPU time spent on database processes.
   - **Buffer Cache Hit Ratio:** Indicates how often data is found in the buffer cache rather than reading from disk.
   - **Redo Size:** Amount of redo generated.
   - **Logical Reads:** Number of times data was requested by SQL queries.

### 7. Conclusion and Best Practices

1. **Regular Monitoring:**
   - Regularly monitor AWR reports to keep track of database performance.
   - Schedule automatic generation and review of AWR reports.

2. **Fine-Tuning:**
   - Use the insights from AWR reports to identify performance bottlenecks and fine-tune the database.

3. **Documentation:**
   - Maintain documentation of any changes made based on AWR report findings.

### Summary

By following these steps, you will have configured AWR, created snapshots, generated reports, and understood the key sections and metrics in an AWR report using SQL Developer. This lab provides a comprehensive guide to setting up and using AWR for Oracle Database performance tuning and monitoring.

### Detailed Instructions with Actual Values:

1. **Connect to SQL Developer as SYSDBA:**

   - Open SQL Developer and connect to the database as SYSDBA.

2. **Run the PL/SQL Block:**

   ```sql
   BEGIN
     DBMS_WORKLOAD_REPOSITORY.modify_snapshot_settings(
       interval => 60,   -- Snapshot interval in minutes
       retention => 43200  -- Retention period in minutes (30 days)
     );
   END;
   ```

   - Execute this PL/SQL block by pressing the green run button or by pressing F5.

3. **Run the Verification Query Separately:**

   ```sql
   SELECT snap_interval, retention FROM dba_hist_wr_control;
   ```

   - Execute this query by pressing the green run button or by pressing F5.

4. **Create a Manual AWR Snapshot:**

   ```sql
   EXEC DBMS_WORKLOAD_REPOSITORY.create_snapshot;
   ```

5. **Verify the Snapshot:**

   ```sql
   SELECT snap_id, begin_interval_time, end_interval_time
   FROM dba_hist_snapshot
   ORDER BY snap_id DESC;
   ```

6. **Generate the AWR Report:**

   Replace `<begin_snap_id>` and `<end_snap_id>` with the snapshot IDs obtained in the previous step.

   ```sql
   DECLARE
     l_dbid       NUMBER;
     l_inst_num   NUMBER;
     l_bid        NUMBER := <begin_snap_id>;  -- Replace with actual begin snapshot ID
     l_eid        NUMBER := <end_snap_id>;    -- Replace with actual end snapshot ID
     l_rpt_type   VARCHAR2(20) := 'HTML';
     l_output     CLOB;
   BEGIN
     SELECT dbid, instance_number INTO l_dbid, l_inst_num FROM v$instance;

     l_output := DBMS_WORKLOAD_REPOSITORY.awr_report_html(
                    l_dbid, l_inst_num, l_bid, l_eid);

     DBMS_XDB.storeCLOB('/public/awr_report.html', l_output, TRUE);
   END;
   /

   -- Access the report at http://localhost:5500/public/awr_report.html
   ```

By following these corrected instructions, you should be able to configure and verify AWR settings, create manual snapshots, and generate AWR reports successfully.
