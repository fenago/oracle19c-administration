# An Essential Guide To Oracle ALTER DATABASE LINK By Examples
**Summary**: In this lab, you will learn how to use the Oracle `ALTER DATABASE LINK` statement to update the current password of a remote user of a database link.

Introduction to Oracle ALTER DATABASE LINK statement
----------------------------------------------------

Typically, when you [create a database link] that connects to a remote database via a user, the user is dedicated and not used by anyone else.

However, if the user is also used by someone, then the password of the user may change, which causes the database link broken.

When the password of the user of a database link changes, you need to use the `ALTER DATABASE LINK` statement to update the database link.

The following statement updates the new password for the remote user of a private database link:

```
ALTER DATABASE LINK private_dblink 
CONNECT TO remote_user IDENTIFIED BY new_password;
```


The following statement updates the new password of the remote user of a public database link:

```
ALTER PUBLIC DATABASE LINK public_dblink
CONNECT TO remote_user IDENTIFIED BY new_password;
```


To execute the `ALTER DATABASE LINK` and `ALTER PUBLIC DATABASE LINK` statements, your account needs to have the `ALTER DATABASE LINK SYSTEM` and `ALTER PUBLIC DATABASE LINK` system privilege respectively.

Oracle ALTER DATABASE LINK statement example
--------------------------------------------

This example uses the `ALTER DATABASE LINK` statement to update the password for the user `bob` of the `sales` database link:

```
ALTER DATABASE LINK sales 
CONNECT TO bob IDENTIFIED BY xyz@123!;
```


In this lab, you have learned how to use the Oracle `ALTER DATABASE LINK` statement to update the current password of the user of a database link.
