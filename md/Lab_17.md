# How to Unlock a User in Oracle
**Summary**: In this lab, you will learn how to unlock a user in Oracle by using the `ALTER USER ACCOUNT UNLOCK` statement.

To unlock a user in Oracle, you follow these steps:

*   First, log in to the Oracle Database as a `SYS` user.
*   Then, use `ALTER USER` statement to unlock the user as follows:

```
ALTER USER username IDENTIFIED BY password ACCOUNT UNLOCK;

```


![oracle unlock user](./images/oracle-unlock-user-300x230.png "oracle unlock user")

Note that if you unlock an account without resetting the password, then the password remains expired, therefore, the `IDENTIFIED BY password` clause is necessary. The first time the user logs in to the Oracle Database, he needs to change his password.

Let’s see an example of unlocking a user.

Suppose a user `alice` is locked. When `alice` logs in, she will see the following message:

```
Enter user-name: alice@fenagodb1
Enter password:
ERROR:
ORA-28000: the account is locked

```


To unlock the user `alice`, you use these steps:

First, log in to the Oracle Database using the`ot` user:

```
Enter user-name: ot@orclpdb
Enter password: <ot_password>
```


Then, use the `ALTER USER` statement to unlock the user `alice`:

```
 ALTER USER alice IDENTIFIED BY abcd1234 ACCOUNT UNLOCK;

```


Note that `abcd1234` is the new password that `alice` will be used to log in to the Oracle Database.

Now the user `alice` should be able to log in to the database with the new password.

In this lab, you have learned how to unlock a user in the Oracle Database by using the `ALTER USER ACCOUNT UNLOCK` statement.
