# Learn How to Extend a Tablespace in Oracle By Practical Examples
**Summary**: In this lab, you will learn how to extend the size of a tablespace in the Oracle Database.

When tablespaces of the database are full, you will not able to add or remove data on these tablespaces anymore.

There are a few ways you can extend a tablespace.

Extending a tablespace by adding a new datafile
-----------------------------------------------

The first way to extend a tablespace is to add a new datafile by using the `ALTER TABLESPACE` statement:

```
ALTER TABLESPACE tablespace_name
    ADD DATAFILE 'path_to_datafile'
    SIZE size;

```


If you use the `AUTOEXTEND ON` clause, Oracle will automatically extend the size of the datafile when needed:

```
ALTER TABLESPACE tablespace_name
    ADD DATAFILE 'path_to_datafile'
    SIZE size
    AUTOEXTEND ON;

```


Let’s see the following example.

First, `create a new tablespace` called `tbs10` with the size 1MB:

```
CREATE TABLESPACE tbs10 
    DATAFILE 'tbs10.dbf' SIZE 1m;

```


Next, `create a new table` `t1` whose tablespace is `tbs10`:

```
CREATE TABLE t1(id INT PRIMARY  KEY) 
TABLESPACE tbs10;

```


Then, insert `1,000,000` rows into the `t1` table:

```
BEGIN
    FOR counter IN 1..1000000 loop
        INSERT INTO t1(id)
        VALUES(counter);
    END loop;
END;
/

```


Oracle issued the following error:

```
ORA-01653: unable to extend table OT.T1 by 8 in tablespace TBS10

```


So the tablespace `tbs10` does not have enough space for the 1 million rows.

After that, use the `ATLER TABLESPACE` statement to add one more datafile whose size is 10MB with the `AUTOEXTEND ON` option:

```
ALTER TABLESPACE tbs10
    ADD DATAFILE 'tbs10_2.dbf'
    SIZE 10m
    AUTOEXTEND ON;

```


Finally, insert 1 million rows into the `t1` table. It should work now. This query returns the number of rows from the `t1` table:

```
SELECT count(*) FROM t1;

```


Here is the output:

```
COUNT(*)

1000000    

```


Extending a tablespace by resizing the datafile
-----------------------------------------------

Another way to extend a tablespace is to resize the data file by using the `ALTER DATABASE RESIZE DATAFILE` statement:

```
ALTER DATABASE
    DATAFILE 'path_to_datafile'
    RESIZE size;
```


Consider the following example.

First, `create a new tablespace` called `tbs11`:

```
CREATE TABLESPACE tbs11
    DATAFILE 'tbs11.dbf'
    SIZE 1m;
```


Next, `create a new table` called `t2` that uses `tbs11` as the tablespace:

```
CREATE TABLE t2(
    c INT PRIMARY KEY
) TABLESPACE tbs11;
```


Then, query the size of the tablespace `tbs11`:

```
SELECT 
    tablespace_name, 
    bytes / 1024 / 1024 MB
FROM 
    dba_free_space
WHERE 
    tablespace_name = 'TBS11';
```


The following illustrates the output:

```
TABLESPACE_NAME         MB

TBS11                .9375

```


After that, use the `ALTER DATABASE` to extend the size of the datafile of the tablespace to 15MB:

```
ALTER DATABASE 
    DATAFILE 'tbs11.dbf' 
    RESIZE 15m;
```


Finally, query the size of the `tbs11` tablespace:

```
SELECT 
    tablespace_name, 
    bytes / 1024 / 1024 MB
FROM 
    dba_free_space
WHERE 
    tablespace_name = 'TBS11';
```


Here is the output:

```
TABLESPACE_NAME          MB

TBS11               14.9375

```


As you can see, the size of the tablespace `tbs11` has been extended to 15MB.

Note that Oracle does not allow you to add a datafile to a bigfile tablespace, therefore, you only can use `ALTER DATABASE DATAFILE RESIZE` command.

In this lab, you have learned how to extend the tablespace by adding a new datafile to the tablespace or resizing an existing datafile.
