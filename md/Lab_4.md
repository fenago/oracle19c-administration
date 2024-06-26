# Oracle Tablespace
**Summary**: In this lab, you will learn about the Oracle tablespace and how Oracle uses tablespaces to logically store the data in the database.

What is an Oracle Tablespace
----------------------------

Oracle divides a database into one or more logical storage units called tablespaces.

Each tablespace consists of one or more files called datafiles. A datafile physically stores the data objects of the database such as tables and [indexes] on disk.

In other words, Oracle **logically** stores data in the tablespaces and **physically** stores data in datafiles associated with the corresponding tablespaces.

The following picture illustrates the relationship between a database, tablespaces, and datafiles:

![Oracle tablespace](./images/Oracle-tablespace.png)

By using tablespaces, you can perform the following operations:

*   Control the storage size allocated for the database data.
*   grant specific space quotas to the `database users`.
*   Control the availability of data by taking tablespaces online or offline (more on this later).
*   Improve the performance of the database by allocating data storage across devices.
*   Perform partial database backup or recovery.

Default tablespaces in Oracle
-----------------------------

Oracle comes with the following default tablespaces: `SYSTEM`, `SYSAUX`, `USERS`, `UNDOTBS1`, and `TEMP`.

*   The `SYSTEM` and `SYSAUX` tablespaces store system-generated objects such as data dictionary tables. You should not store any object in these tablespaces.
*   The `USERS` tablespace is helpful for ad-hoc users.
*   The `UNDOTBS1` holds the undo data.
*   The `TEMP` is the temporary tablespace that is used for storing intermediate results of sorting, hashing, and large object processing operations.

Online and Offline Tablespaces
------------------------------

A tablespace can be online or offline. If a tablespace is offline, you cannot access data stored in it. On the other hand, if a tablespace is online, its data is available for reading and writing.

Note that the `SYSTEM` tablespace must always be online because it contains the data dictionary that must be available to Oracle.

Normally, a tablespace is online so that its data is available to users. However, you can take a tablespace offline to make data inaccessible to users when you update and maintain the applications.

In case of some errors such as hardware failures, Oracle automatically takes an online tablespace offline. Any attempt to access data in offline tablespace will result in an error.

Read-Only Tablespaces
---------------------

The read-only tablespaces allow Oracle to avoid performing backup and recovery of large, static parts of a database. Because Oracle doesn’t update the files of a read-only tablespace, you can store the files on the read-only media.

Oracle allows you to remove objects such as tables and indexes from a read-only tablespace. However, it does not allow you to create or alter objects in a read-only tablespace.

When you create a new tablespace, it is in the read-write mode. To change a tablespace to a read-only tablespace, you use the `ALTER TABLESPACE` command with the `READ ONLY` option.



1.	Start Oracle SQL Developer by Using the SQL Developer Desktop Icon Double-click the SQL Developer desktop icon.
 
![](./images/5.png)

The SQL Developer interface appears.

![](./images/6.png)

2.	Create a New Oracle SQL Developer Database Connection

a.	To create a new database connection, in the Connections Navigator, right-click Connections and select New Connection from the context menu.

![](./images/7.png)

The New / Select Database Connection dialog box appears.

b.	Create a database connection by using the following information:

i.	Connection Name: **myconnection**

ii.	Username: **sys**

iii. Password: **fenago**

iv.	Hostname: **localhost**

v.	Port: **1521**

vi.	Service Name: **FENAGODB1**

vii. Role: **SYSDBA**

Ensure that you select the Save Password check box.

![](./images/8.png)

Test the connection by clicking `Test` button and then click `Connect` button.
 
When you create a connection, a SQL Worksheet for that connection opens automatically.

![](./images/9.png)

In the next lab, we will look into creating tablespaces.