# SERFLIX DB

It just managment about database for serflix, there are storage procedures and scripts to make structure or certain data that need it, the sp is based on Mysql, but if you want to use on Sql server or other RDBMS you change code's line for it to work 

this repository is for Serflix, but you can use for a User managment or something about it.

## Diagram

![Diagram of database](/assets/diagramDB.png)

> Some tables has unique constrain because some tuplas required non multiple same values like the user, scores about one movie or serie, match favorite movie, etc.

## Structure workspace

There are some directories to make something easier who each of them has an important role, such as save/load backups or storage procedure and other roles, but if you make a script to update your database, move into directory called ```db_updates```, that's to avoid share sensity data when you do a push to github.

Also, some storage procedure retrieved a same structure, like this:
```
{
  result: ...,
  error_code: number | null,
  message: string
}
```
A common problem is when coding to create or update a script and you need to update to database, but it's slow, however, some script are implemented to decrease time such as update all sp, start backup, etc., but watch out when you update storage procedure because some script need to have variables to function correctly, in aditional that, there is a script to save a backup in your database but it's very important assign variables correctly.

## Environment variables

One each of those variables is essential to function correctly because some bash's script needs it., **.env** has to have these variables to function correctly

- DB_HOST
- DB_PORT
- DB_USER
- DB_PASSWORD
- DB_NAME
- FILE_TO_APPLY_BACKUP
- FILE_SQL_TO_APPLY