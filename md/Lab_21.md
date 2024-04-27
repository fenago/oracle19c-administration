# Oracle DROP ROLE
**Summary**: In this lab, you will learn how to use the Oracle `DROP ROLE` statement to remove a role from the database.

Oracle DROP ROLE statement overview
-----------------------------------

The `DROP ROLE` statement allows you to remove a [role] from the database. Here is the syntax of the `DROP ROLE` statement:

```
DROP ROLE role_name;
```


In this syntax, you specify the name of the role that you want to drop after the `DROP ROLE` keywords.

When you drop a role, Oracle revokes it from all users and roles that have been previously `granted`. In addition, Oracle deletes the role from the database.

To drop a role, you must have the `DROP ANY ROLE` system privilege or have been granted the role with the `ADMIN OPTION`.

Oracle `DROP ROLE` examples
---------------------------

Let’s take some examples of using the `DROP ROLE` statement

1) Oracle DROP ROLE statement basic example
-------------------------------------------

First, log in to the Oracle Database using the `sys` account using sql developer.

Next, create a new role called `developer`:

```
CREATE ROLE developer;
```


Then, verify if the role has been created successfully:

```
SELECT * from dba_roles 
WHERE role = 'DEVELOPER';
```


After that, drop the developer role:

```
DROP ROLE developer;
```


Finally, check if the role has been dropped:

```
SELECT * from dba_roles 
WHERE role = 'DEVELOPER';
```


Oracle issued the following message indicating that the role developer has been removed successfully:

```
no rows selected

```


2) Oracle DROP ROLE statement basic example
-------------------------------------------

First, log in as `sys` user in sql developer.

Second, create a new role called `auditor` and grant the `SELECT` object privilege on the `orders` table in the [sample database]:

```
CREATE ROLE auditor;
GRANT SELECT ON orders TO auditor;
```


Third, create a new user named `audi`, grant the `CREATE SESSION` system privilege and the `auditor` role to `audi`:

```
CREATE USER audi IDENTIFIED BY Abcd1234;
GRANT CREATE SESSION TO auditor;
GRANT auditor TO audi;
```


Fourth, log in to the Oracle database as the `audi` user in the second session and issue the following command:

```
SELECT COUNT(*) FROM sys.orders;
```


Here is the output:

```
  COUNT(*)

  2
```


Query role of the `audi` user:

```
SELECT * FROM session_roles; 
```


Here is the role of the user `audi`:

```
ROLE

AUDITOR

```


Fifth, go back to the first session and drop the role `auditor`:

```
DROP ROLE auditor;
```


Sixth, go to the second session and check the roles of the user `audi` and issues the following `[SELECT]` statement:

```
SELECT * FROM session_roles;
```


The following shows the output:

```
no rows selected

```


It means that the `audit` role has been revoked from the user `audi`.

Seventh, from the audi’s session, try to execute the following query to verify if the role has been revoked completely:

```
SELECT * FROM sys.orders;
```


Oracle issued this output:

```
no rows selected
```


Now user `audi` couldn’t query data from the `sys.orders` anymore.

In this lab, you have learned how to use Oracle `DROP ROLE` statement to delete a role from the database.
