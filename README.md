# DB-Homework

## Introduction
Database management has evolved from a specialized computer application to a
central component of a modern computing environment, and, as a result, knowledge
about database systems has become an essential part of an education in computer
science. In this text, we present the fundamental concepts of database management.
These concepts include aspects of database design, database languages, and
database-system implementation.

## Mysql Security

1. Install MySQL or MariaDB on your Linux Operating system
2. Start the service
3. Add two users to DBMS namely netsec1 and netsec2
4. Create a database named DBTest
5. Create two test tables named Table1 and Table2 each have two columns named username and password.
6. Insert some test records in these two tables.
7. Using the GRANT statement, secure the DBMS in a way that netsec1 has access to Table1 and netsec has access to Table2 but not vice versa.


```sh
mysql -u root -p
```

```sql
CREATE USER 'netsec1'@'%' IDENTIFIED BY '123';
CREATE USER 'netsec2'@'%' IDENTIFIED BY '123';

CREATE DATABASE DBTest;
USE DBTest;

CREATE TABLE Table1 (username varchar(4), password varchar(4));
CREATE TABLE Table2 (username varchar(4), password varchar(4));

INSERT INTO Table1 () VALUES ("u1", "p1");
INSERT INTO Table2 () VALUES ("u2", "p2");

GRANT ALL ON DBTest.Table1 TO 'netsec1';
GRANT ALL ON DBTest.Table2 TO 'netsec2';
```

8. Test your configuration using a number of INSERT and SELECT statements.

```sh
mysql -u netsec1 -p
```

```sql
USE DBTest;

INSERT INTO Table1 () VALUES ("1u1", "1p1"); /* this should work */
INSERT INTO Table2 () VALUES ("1u2", "1p2"); /* this shouldn't work */
/* ERROR 1142 (42000): INSERT command denied to user 'netsec1'@'localhost' for table 'Table2' */
```

```sh
mysql -u netsec2 -p
```

```sql
USE DBTest;

INSERT INTO Table1 () VALUES ("1u1", "1p1"); /* this shouldn't work */
/* ERROR 1142 (42000): INSERT command denied to user 'netsec2'@'localhost' for table 'Table1' */
INSERT INTO Table2 () VALUES ("1u2", "1p2"); /* this should work */
```

9. Revoke the INSERT permission from the users and recheck your configuration.

```sh
mysql -u root -p
```

```sql
REVOKE INSERT ON DBTest.Table1 FROM 'netsec1';
REVOKE INSERT ON DBTest.Table2 FROM 'netsec2';
```

```sh
mysql -u netsec1 -p
```

```sql
USE DBTest;

INSERT INTO Table1 () VALUES ("1u1", "1p1"); /* this shouldn't work */
/* ERROR 1142 (42000): INSERT command denied to user 'netsec1'@'localhost' for table 'Table1' */
```

```sh
mysql -u netsec2 -p
```

```sql
USE DBTest;

INSERT INTO Table2 () VALUES ("1u2", "1p2"); /* this shouldn't work */
/* ERROR 1142 (42000): INSERT command denied to user 'netsec2'@'localhost' for table 'Table2' */
```


## MySQL Script
for running mysql script use following command:
```sh
mysql -u root -p < scirpt.sql
```

## MySQL Docker

```sh
docker run --name db -e MYSQL_ROOT_PASSWORD=123 -d mysql
docker run -it --link db:mysql --rm mysql sh -c 'exec mysql -h"$MYSQL_PORT_3306_TCP_ADDR" -P"$MYSQL_PORT_3306_TCP_PORT" -uroot -p"$MYSQL_ENV_MYSQL_ROOT_PASSWORD"'
```
