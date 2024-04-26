# Oracle DROP DATABASE LINK By Practial Examples
**Summary**: In this lab, you will learn how to use the Oracle `DROP DATABASE LINK` statement to remove a database link from the database.

Introduction to the Oracle DROP DATABASE LINK statement
-------------------------------------------------------

The `DROP DATABASE LINK` statement allows you to drop a [database link] from the database. Here is the syntax of the `DROP DATABASE LINK` statement:

```
DROP DATABASE LINK dblink;
```


In this syntax, you specify the name of the database link ( `dblink`) that you want to remove after the `DROP DATABASE LINK` keywords.

The `DROP DATABASE LINK` statement can remove a private database link. To remove a public database link, you add the `PUBLIC` keyword as shown in the following statement:

```
DROP PUBLIC DATABASE LINK dblink;
```


Note that to drop a public database link, you need to have the `DROP PUBLIC DATABASE DATABASE LINK` system privilege.

### Restrictions of the DROP DATABASE LINK statement:

*   First, you cannot drop a database link in the schema of another user.
*   Second, you cannot qualify the `dblink` with the name of a schema like: `schema.dblink` because Oracle will interpret `schema.dblink` as the entire name of a database link in your own schema. Notice that the name of a database link can contain periods (.)

Oracle DROP DATABASE LINK statement example
-------------------------------------------

This example removes the `SALES` private database link created in the `CREATE DATABASE LINK` lab:

```
DROP DATABASE LINK sales;
```


In this lab, you have learned how to the Oracle `DROP DATABASE LINK` statement to remove a database link from the database.
