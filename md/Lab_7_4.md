### Lab 7.4: Setting Up and Understanding AWR (Automatic Workload Repository)

## Objective:
To configure and understand the Automatic Workload Repository (AWR), generate snapshots, and create an AWR report using SQL Developer.

## Prerequisites:
- Oracle Database 19c or higher.
- SQL Developer installed and configured to connect to the Oracle database.
- Access to SYSDBA privileges.

## Steps:

### 1. Configure AWR Snapshot Settings

#### a. Check Current Snapshot Settings
1. **Connect to the Database as SYSDBA:**
   - Open SQL Developer and connect to your CDB as SYSDBA.
   - Connection details:
     - **Connection Name:** SYSDBA_CDBLAB
     - **Username:** sys
     - **Password:** fenago
     - **Connection Type:** Basic
     - **Role:** SYSDBA
     - **Hostname:** localhost
     - **Port:** 1521
     - **Service Name:** CDBLAB

2. **Check Current AWR Snapshot Settings:**
   - Run the following SQL to check the current snapshot interval and retention settings:

     ```sql
     SELECT snap_interval, retention 
     FROM dba_hist_wr_control;
     ```

#### b. Modify Snapshot Settings

1. **Modify the AWR Snapshot Settings:**
   - Use the following PL/SQL block to change the snapshot interval to 60 minutes and the retention to 30 days:

     ```sql
     BEGIN
       DBMS_WORKLOAD_REPOSITORY.modify_snapshot_settings(
         interval => 60,    -- Snapshot interval in minutes
         retention => 43200 -- Retention period in minutes (30 days)
       );
     END;
     ```

2. **Verify the New Settings:**
   - Run the following SQL to verify the new settings:

     ```sql
     SELECT snap_interval, retention 
     FROM dba_hist_wr_control;
     ```

### 2. Generate AWR Snapshots

#### a. Manually Create a Snapshot

1. **Create a Manual Snapshot:**
   - Use the following PL/SQL block to create a manual snapshot:

     ```sql
     EXEC DBMS_WORKLOAD_REPOSITORY.create_snapshot;
     ```

### 3. Generate an AWR Report

#### a. Capture Snapshot IDs

1. **Retrieve Snapshot IDs:**
   - Run the following SQL query to get the two most recent snapshot IDs:

     ```sql
     SELECT snap_id, begin_interval_time, end_interval_time
     FROM dba_hist_snapshot
     ORDER BY snap_id DESC;
     ```

   - Note down the `snap_id` values for the two most recent snapshots. For example, let's say the two latest snapshot IDs are 52 (most recent) and 51 (second most recent).

#### b. Generate the AWR Report

1. **Generate the AWR Report:**
   - Use the following PL/SQL block to generate the AWR report dynamically using the snapshot IDs:

     ```sql
     DECLARE
       l_dbid       NUMBER;
       l_inst_num   NUMBER;
       l_bid        NUMBER;
       l_eid        NUMBER;
       l_rpt_type   VARCHAR2(20) := 'HTML';
       l_output     CLOB;
     BEGIN
       -- Retrieve DBID and instance number
       SELECT dbid, instance_number INTO l_dbid, l_inst_num FROM v$database;

       -- Retrieve the two most recent snapshot IDs
       SELECT MAX(snap_id) INTO l_eid FROM dba_hist_snapshot;
       SELECT MAX(snap_id) - 1 INTO l_bid FROM dba_hist_snapshot;

       -- Generate the AWR report
       l_output := DBMS_WORKLOAD_REPOSITORY.awr_report_html(
                      l_dbid, l_inst_num, l_bid, l_eid);

       -- Create temporary LOB and store report
       DBMS_LOB.CREATETEMPORARY(l_output, TRUE);
       DBMS_XDB.CREATERESOURCE('/public/awr_report.html', l_output);
     END;
     /
     ```

2. **Execute the PL/SQL Block:**
   - Execute this PL/SQL block by pressing the green run button or by pressing F5.

3. **Access the AWR Report:**
   - Open a web browser and navigate to `http://localhost:5500/public/awr_report.html` to view the generated AWR report.

### Summary:

By following these steps, you have:
- Configured the AWR snapshot settings.
- Generated manual AWR snapshots.
- Created an AWR report dynamically using SQL Developer.

### Additional Information:

- **AWR Overview:**
  The Automatic Workload Repository (AWR) is a built-in repository in Oracle databases that collects, processes, and maintains performance statistics. It provides a historical view of database performance data, which can be used for diagnosing and resolving performance issues.

- **Key Components:**
  - **Snapshots:** Periodic collections of performance data.
  - **Reports:** Summarize the data collected in snapshots, highlighting performance issues and trends.

- **Snapshot Interval and Retention:**
  - **Snapshot Interval:** The frequency at which snapshots are taken. The default is every 60 minutes.
  - **Retention Period:** How long the snapshots are stored in the repository. The default is 8 days.

This lab provides a comprehensive understanding of configuring, generating, and utilizing AWR reports to monitor and diagnose Oracle database performance.
