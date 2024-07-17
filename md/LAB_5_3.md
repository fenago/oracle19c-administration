### Lab: Using the DBA Features in Oracle SQL Developer

#### Objective:
To demonstrate how to use the DBA features in Oracle SQL Developer, set some important values in the Container Database (CDB), and explain their significance. Then, set values in the Pluggable Databases (PDBs) and explain their significance.

### Step 1: Access DBA Features in Oracle SQL Developer

1. **Open Oracle SQL Developer.**
2. **Connect to the CDB and PDBs:**
   - In the Connections pane, right-click on `CDBLAB` and select `Connect`.
   - Repeat the process for `PDB1_CDBLAB`, `PDB2_CDBLAB`, and `PDB3_CDBLAB`.

3. **Open the DBA Navigator:**
   - In the Connections pane, under the `DBA` section, right-click on `CDBLAB` and select `DBA Navigator`.

### Step 2: Set Important Values in the CDB

1. **Access Initialization Parameters:**
   - In the DBA Navigator, expand `CDBLAB` -> `Database` -> `Configuration` -> `Initialization Parameters`.

2. **Set Important Parameters:**
   - Locate and double-click on the parameter `open_cursors`.
     - **Explanation:** `open_cursors` determines the maximum number of cursors a session can have open simultaneously. Increasing this value can help prevent errors related to cursor limits.
     - **Action:** Set the value to `1000`.
   - Locate and double-click on the parameter `processes`.
     - **Explanation:** `processes` determines the maximum number of operating system processes that can connect to Oracle. It is important to set this value based on the expected number of concurrent users and background processes.
     - **Action:** Set the value to `300`.

3. **Apply the Changes:**
   - Click on the `Apply` button to save the changes.
   - A dialog box will appear, asking if you want to restart the database to apply the changes. Choose `Yes`.

### Step 3: Set Important Values in the PDBs

#### For PDB1_CDBLAB

1. **Access Initialization Parameters:**
   - In the DBA Navigator, expand `PDB1_CDBLAB` -> `Database` -> `Configuration` -> `Initialization Parameters`.

2. **Set Important Parameters:**
   - Locate and double-click on the parameter `pga_aggregate_target`.
     - **Explanation:** `pga_aggregate_target` sets the target aggregate PGA (Program Global Area) memory available to all server processes attached to the database. It is crucial for efficient memory management.
     - **Action:** Set the value to `500M`.

3. **Apply the Changes:**
   - Click on the `Apply` button to save the changes.

#### For PDB2_CDBLAB

1. **Access Initialization Parameters:**
   - In the DBA Navigator, expand `PDB2_CDBLAB` -> `Database` -> `Configuration` -> `Initialization Parameters`.

2. **Set Important Parameters:**
   - Locate and double-click on the parameter `sga_target`.
     - **Explanation:** `sga_target` sets the total size of all SGA (System Global Area) components. It is important for optimizing the memory allocation for the database.
     - **Action:** Set the value to `1G`.

3. **Apply the Changes:**
   - Click on the `Apply` button to save the changes.

#### For PDB3_CDBLAB

1. **Access Initialization Parameters:**
   - In the DBA Navigator, expand `PDB3_CDBLAB` -> `Database` -> `Configuration` -> `Initialization Parameters`.

2. **Set Important Parameters:**
   - Locate and double-click on the parameter `undo_retention`.
     - **Explanation:** `undo_retention` sets the time in seconds that Oracle attempts to retain old undo data before overwriting it. This is important for long-running queries to ensure they have consistent data.
     - **Action:** Set the value to `900`.

3. **Apply the Changes:**
   - Click on the `Apply` button to save the changes.

### Step 4: Verify the Changes

1. **In the DBA Navigator, verify the parameter changes for CDBLAB:**
   - Expand `CDBLAB` -> `Database` -> `Configuration` -> `Initialization Parameters`.
   - Check that `open_cursors` is set to `1000` and `processes` is set to `300`.

2. **Verify the parameter changes for PDB1_CDBLAB:**
   - Expand `PDB1_CDBLAB` -> `Database` -> `Configuration` -> `Initialization Parameters`.
   - Check that `pga_aggregate_target` is set to `500M`.

3. **Verify the parameter changes for PDB2_CDBLAB:**
   - Expand `PDB2_CDBLAB` -> `Database` -> `Configuration` -> `Initialization Parameters`.
   - Check that `sga_target` is set to `1G`.

4. **Verify the parameter changes for PDB3_CDBLAB:**
   - Expand `PDB3_CDBLAB` -> `Database` -> `Configuration` -> `Initialization Parameters`.
   - Check that `undo_retention` is set to `900`.

### Conclusion:
This lab provided step-by-step instructions to set important initialization parameters in the CDB and PDBs using the DBA features in Oracle SQL Developer. Understanding and configuring these parameters is crucial for optimal database performance and resource management.
