### Summary of Steps to Configure the Listener and Services

1. **Update `listener.ora`:**

    Ensure it includes entries for your CDB and PDBs.

    Example:
    ```plaintext
    LISTENER =
      (DESCRIPTION_LIST =
        (DESCRIPTION =
          (ADDRESS = (PROTOCOL = TCP)(HOST = localhost)(PORT = 1521))
        )
      )

    SID_LIST_LISTENER =
      (SID_LIST =
        (SID_DESC =
          (GLOBAL_DBNAME = CDBLAB)
          (SID_NAME = CDBLAB)
          (ORACLE_HOME = /u01/app/oracle/product/19.3.0/dbhome_1)
        )
        (SID_DESC =
          (GLOBAL_DBNAME = PDBLAB1)
          (SID_NAME = PDBLAB1)
          (ORACLE_HOME = /u01/app/oracle/product/19.3.0/dbhome_1)
        )
        (SID_DESC =
          (GLOBAL_DBNAME = PDBLAB2)
          (SID_NAME = PDBLAB2)
          (ORACLE_HOME = /u01/app/oracle/product/19.3.0/dbhome_1)
        )
        (SID_DESC =
          (GLOBAL_DBNAME = PDBLAB3)
          (SID_NAME = PDBLAB3)
          (ORACLE_HOME = /u01/app/oracle/product/19.3.0/dbhome_1)
        )
      )
    ```

2. **Update `tnsnames.ora`:**

    Ensure it includes entries for your CDB and PDBs.

    Example:
    ```plaintext
    CDBLAB =
      (DESCRIPTION =
        (ADDRESS = (PROTOCOL = TCP)(HOST = localhost)(PORT = 1521))
        (CONNECT_DATA =
          (SERVER = DEDICATED)
          (SERVICE_NAME = CDBLAB)
        )
      )

    PDBLAB1 =
      (DESCRIPTION =
        (ADDRESS = (PROTOCOL = TCP)(HOST = localhost)(PORT = 1521))
        (CONNECT_DATA =
          (SERVER = DEDICATED)
          (SERVICE_NAME = PDBLAB1)
        )
      )

    PDBLAB2 =
      (DESCRIPTION =
        (ADDRESS = (PROTOCOL = TCP)(HOST = localhost)(PORT = 1521))
        (CONNECT_DATA =
          (SERVER = DEDICATED)
          (SERVICE_NAME = PDBLAB2)
        )
      )

    PDBLAB3 =
      (DESCRIPTION =
        (ADDRESS = (PROTOCOL = TCP)(HOST = localhost)(PORT = 1521))
        (CONNECT_DATA =
          (SERVER = DEDICATED)
          (SERVICE_NAME = PDBLAB3)
        )
      )
    ```

3. **Reload the Listener:**

    ```shell
    lsnrctl reload
    ```

4. **Verify Listener Status:**

    ```shell
    lsnrctl status
    ```

### Steps to Set and Verify EM Express Port

1. **Set the EM Express Port:**

    ```sql
    EXEC dbms_xdb_config.sethttpsport(5501);
    ```

2. **Verify the EM Express Port:**

    ```sql
    SELECT dbms_xdb_config.gethttpsport() FROM dual;
    ```
    Ensure the output shows 5501.

3. **Restart the Listener:**

    ```shell
    lsnrctl stop
    lsnrctl start
    ```

4. **Verify Listener Status:**

    ```shell
    lsnrctl status
    ```

5. **Access EM Express:**

    Open a web browser and navigate to:
    ```url
    https://localhost:5501/em
    ```

6. **Browser Authentication:**

    When the browser prompts for authentication:
    - **Username:** sys
    - **Password:** fenago

7. **EM Express Login:**

    On the EM Express login page:
    - **Username:** sys
    - **Password:** fenago
    - **Container Name:** CDBLAB
    - **Connection Type:** SYSDBA

By following these steps, you will configure the listener, set the EM Express port, and successfully connect to EM Express.
