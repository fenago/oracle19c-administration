# How To Grant SELECT Object Privilege On One or More Tables to a User
**Summary**: In this lab, you will learn how to use the Oracle `GRANT` statement to grant `SELECT` object privilege on one or more tables to a user.

Grant SELECT on a table to a user
---------------------------------

To grant the `SELECT` object privilege on a table to a user or role, you use the following statement:

```
GRANT SELECT ON table_name TO {user | role};
```


The following example illustrates how to grant the `SELECT` object privilege on a table to a user.

First, [create a new user] called `DW` and grant the `CREATE SESSION` to the user:

```
CREATE USER dw IDENTIFIED BY abcd1234;

GRANT CREATE SESSION TO dw;
```


Second, grant the `SELECT` object privilege on the `ot.customers` table to the `dw` user:

```
GRANT SELECT ON customers TO dw;
```


Finally, use the `dw` user to log in to the Oracle Database and [query data] from the `ot.customers` table:

```
SELECT COUNT(*) 
FROM ot.customers;

```


Here is the output:

```
  COUNT(*)

    319

```


Grant SELECT on all tables in a schema to a user
------------------------------------------------

Sometimes, you want to grant `SELECT` on all tables that belong to a schema or user to another user. Unfortunately, Oracle doesn’t directly support this using a single SQL statement.

To work around this, you can select all table names of a user (or a schema) and grant the `SELECT` object privilege on each table to a grantee.

The following stored procedure illustrates the idea:

```
CREATE PROCEDURE grant_select(
    username VARCHAR2, 
    grantee VARCHAR2)
AS   
BEGIN
    FOR r IN (
        SELECT owner, table_name 
        FROM all_tables 
        WHERE owner = username
    )
    LOOP
        EXECUTE IMMEDIATE 
            'GRANT SELECT ON '||r.owner||'.'||r.table_name||' to ' || grantee;
    END LOOP;
END; 

```


This example grants the `SELECT` object privileges of all tables that belong to the user `OT` to the user `DW`:

```
EXEC grant_select('OT','DW');
```


When you use the user `DW` to login to the Oracle Database, the user `DW` should have the `SELECT` object privilege on all tables of the `OT`‘s schema.

In this lab, you have learned how to grant the `SELECT` object privilege on one or more tables to a user.
