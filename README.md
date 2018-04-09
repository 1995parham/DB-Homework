# DB-Homework

## Introduction
Database management has evolved from a specialized computer application to a
central component of a modern computing environment, and, as a result, knowledge
about database systems has become an essential part of an education in computer
science. In this text, we present the fundamental concepts of database management.
These concepts include aspects of database design, database languages, and
database-system implementation.

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
