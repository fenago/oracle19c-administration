# Use SHUTDOWN IMMEDIATE to Shut Down the Oracle Database
**Summary**: In this lab, you will learn how to use the Oracle `SHUTDOWN` statement to shut down the Oracle Database.

TL;DR
-----

Use the `SHUTDOWN IMMEDIATE` command to shut down the Oracle Database gracefully:

```
SHUTDOWN IMMEDIATE
```


Introduction to the Oracle `SHUTDOWN` statement
-----------------------------------------------

To shut down a currently running Oracle Database instance, you use the `SHUTDOWN` command as follows:

```
SHUTDOWN [ABORT | IMMEDIATE | NORMAL | TRANSACTIONAL [LOCAL]]
```


Let’s examine each option of the `SHUTDOWN` command.

### `SHUTDOWN NORMAL`

The `SHUTDOWN NORMAL` option waits for the current users to disconnect from the database before shutting down the database. The database instance will not accept any further database connection.  The `SHUTDOWN NORMAL` does not require an instance recovery on the next [database startup].

The `NORMAL` is the default option if you don’t explicitly specify any option. Therefore `SHUTDOWN` and `SHUTDOWN NORMAL` commands have the same effect.

The `SHUTDOWN` or `SHUTDOWN NORMAL` is not really practical because you cannot wait for all users to come back to their desks and disconnect from the database.

### `SHUTDOWN TRANSACTIONAL`

The `SHUTDOWN TRANSACTIONAL` waits for all uncommitted transactions to complete before shutting down the database instance. This saves the work for all users without requesting them to log off.

The database instance also does not accept any new transaction after a `SHUTDOWN TRANSACTIONAL` . When completing all transactions, the database instance disconnects all the currently connected users from the database and shuts down.

The `SHUTDOWN TRANSACTIONAL` does not require any instance recovery procedure on the next database startup.

The optional `LOCAL` mode waits for only local transactions to complete, not all the transactions. Then it shuts down the local instance. This option is useful in some cases e.g., a scheduled outage maintenance.

### `SHUTDOWN ABORT`

The `SHUTDOWN ABORT` is not recommended and is only used on some occasions. The `SHUTDOWN ABORT` has a similar effect as unplugging the power of the server. The database will be in an inconsistent state. Therefore, you should never use the `SHUTDOWN ABORT` command before backing up the database. If you try to do so, you may not be able to recover the backup.

It is recommended to use the `SHUTDOWN ABORT` only when you want to shut down the database instantaneously. For example, if you know a power shutdown is going to happen in a minute or you experience some problems when [starting up a database instance].

The `SHUTDOWN ABORT` proceeds with the fastest possible shutdown of the database. However, it requires instance recovery on the next database startup.

### `SHUTDOWN IMMEDIATE`

The `SHUTDOWN IMMEDIATE` is the most common and practical way to shut down the Oracle database.

The `SHUTDOWN IMMEDIATE` does not wait for the current users to disconnect from the database or for current transactions to be completed.

During the `SHUTDOWN IMMEDIATE`, all the connected sessions are disconnected immediately, all uncommitted transactions are rolled back, and the database completely shuts down.

After issuing the `SHUTDOWN IMMEDIATE` statement, the database will not accept any new connection. The statement will also close and dismount the database.

Unlike the `SHUTDOWN ABORT` option, the `SHUTDOWN IMMEDIATE` option does not require an instance recovery on the next database startup.

The following table illustrates the differences between the shutdown modes:


|Shutdown Modes                         |A  |I  |T  |N  |
|---------------------------------------|---|---|---|---|
|Allow new connection                   |No |No |No |No |
|Wait until all current sessions end    |No |No |No |Yes|
|Wait until all current transactions end|No |No |Yes|Yes|
|Force a checkpoint and close files     |No |Yes|Yes|Yes|


Shutdown Modes:

*   A = `ABORT`
*   I = `IMMEDIATE`
*   T = `TRANSACTIONAL`
*   N = `NORMAL`

### Notes

To issue the `SHUTDOWN` statement, you must connect to the database as `SYSDBA`, `SYSOPER`, `SYSBACKUP`, or `SYSDG`. If the current database is a pluggable database, the `SHUTDOWN` statement will close the pluggable database only. The consolidated instance will continue to run. On the other hand, if the current database is a CDB, the `SHUTDOWN` statement will close the CDB instance.

Oracle `SHUTDOWN` statement example
-----------------------------------

First, launch SQL\*Plus:

```
> sqlplus
```


Second, log in to the Oracle database using the `SYS` user:

```
Enter user-name: sys as sysdba
Enter password: <sys_password>
```


Third, check the current status of the Oracle instance:

```
SQL> select instance_name, status from v$instance;
```


Here is the output:

```
INSTANCE_NAME    STATUS

fenagodb             OPEN

```


Fourth, issue the `SHUTDOWN IMMEDIATE` command:

```
SQL> shutdown immediate
Database closed.
Database dismounted.
ORACLE instance shut down.
```


In this lab, you have learned how to use the Oracle `SHUTDOWN` statement to shut down the Oracle Database.
