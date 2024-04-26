# Oracle ALTER USER Statement By Practical Scenarios
**Summary**: In this lab, you will learn how to use the Oracle `ALTER USER` statement to modify the authentication or database resource of a database user.

The `ALTER USER` statement allows you to change the authentication or database resource characteristics of a database user.

Generally speaking, to execute the `ALTER USER` statement, your account needs to have the `ALTER USER` system privilege. However,  you can change your own password using the `ALTER USER` statement without having the `ALTER USER` system privilege.

Let’s create a user named `dolphin` and grant the `CREATE SESSION` system privilege to `dolphin`:

```
CREATE USER dolphin IDENTIFIED BY abcd1234;

GRANT CREATE SESSION TO dolphin;

```


1) Using Oracle ALTER USER statement to change the password for a user
----------------------------------------------------------------------

The following example uses the `ALTER USER` statement to change the password for the user `dolphin`:

```
ALTER USER dolphin IDENTIFIED BY xyz123;

```


Log in to the Oracle Database using the dolphin user:

```
Enter user-name: dolphin@fenagodb1
Enter password: <dolphin password>

```


The user `dolphin` should be able to authenticate to the Oracle Database using the new password `xyz123`

2) Using Oracle ALTER USER statement to lock/unlock a user
----------------------------------------------------------

This example uses the `ALTER USER` statement to lock the user `dolphin`:

```
ALTER USER dolphin ACCOUNT LOCK;

```


If you use the user `dolphin` to log in to the Oracle Database, you should see a message indicating that the user is locked:

```
Enter user-name: dolphin@fenagodb1
Enter password: <dolphin password>
ERROR:
ORA-28000: the account is locked

```


To unlock the user `dolphin`, you use the following statement:

```
ALTER USER dolphin ACCOUNT UNLOCK;

```


Now, the user `dolphin` should be able to log in to the Oracle Database.

3) Using Oracle ALTER USER statement to set the user’s password expired
-----------------------------------------------------------------------

To set the password of the user `dolphin` expired, you use the following statement:

```
ALTER USER dolphin PASSWORD EXPIRE;
```


When you use the user `dolphin` to log in to the database, Oracle issues a message indicating that the password has expired and requests for the password change as follows:

```
Enter user-name: dolphin@orclpdb
Enter password: <dolphin password>
ERROR:
ORA-28001: the password has expired


Changing password for dolphin
New password: <new password>
Retype new password: <new password>
Password changed

```


4) Using Oracle ALTER USER statement to set the default profile for a user
--------------------------------------------------------------------------

This statement returns the profile of the user `dolphin`:

```
SELECT 
    username, 
    profile 
FROM
    dba_users 
WHERE 
    username ='DOLPHIN';

```


When you [create a new user] without specifying a profile, Oracle will assign the `DEFAULT` profile to the user.

Let’s [create a new user profile] called `ocean`:

```
CREATE PROFILE ocean LIMIT
    SESSIONS_PER_USER          UNLIMITED 
    CPU_PER_SESSION            UNLIMITED 
    CPU_PER_CALL               3000 
    CONNECT_TIME               60;

```


and assign it to the user `dolphin`:

```
ALTER USER dolphin
PROFILE ocean;
```


Now, the default profile of the user `dolphin` is `ocean`.

5) Using Oracle ALTER USER statement to set default roles for a user
--------------------------------------------------------------------

Currently, the user `dolphin` has no assigned roles as shown in the output of the following query when executing from the dolphin’s session:

```
SELECT * FROM session_roles;
```


First, [create a new role] called `rescue` from the user `OT`‘s session:

```
CREATE ROLES rescue;

GRANT CREATE TABLE, CREATE VIEW TO rescue;
```


Second, grant this role to `dolphin`:

```
GRANT rescue TO dolphin;
```


Third, use the user `dolphin` to log in to the Oracle Database. The default role of the user `dolphin` is `rescue` now.

```
SELECT * FROM session_roles;
```


Here is the output:

```
ROLE

RESCUE    

```


Fourth, create another role called `super` and grant all privileges to this role:

```
CREATE ROLE super;

GRANT ALL PRIVILEGES TO super;
```


Fifth, grant the role `super` to the user `dolphin`:

```
GRANT super TO dolphin;
```


Sixth, set the default role of the user `dolphin` to `super`:

```
ALTER USER dolphin DEFAULT ROLE super;
```


Seventh, disconnect the current session of the user dolphin and log in to the Oracle Database again. The default role of the user dolphin should be `super` as shown in the output of the following query:

```
SELECT * FROM session_roles;
```


The following shows the output:

```
ROLE

SUPER

```


In this lab, you have learned how to use the Oracle `ALTER USER` to change the authentication or database resource of a database user.
