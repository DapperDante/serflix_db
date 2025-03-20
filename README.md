# SERFLIX DB

This repository is about how a serflix database works like structure, basic objectives and sp, this version is initial so we could have some problems but it will be solved

## Diagram

![Diagram of database](/assets/diagramDB.png)

> Some tables has unique constrain because some tuplas required non multiple same values like the user, scores about one movie or serie, match favorite movie, etc.

## Structure workspace

There are some directories who each of them has an important rol like save backups or storage procedure and other roles, but if you make a script to update your database, you will moved it into directorie called ```db_updates``` to avoid when you do a push to github, those scripts go together.

In another hand, some storage procedure retrieved a same structure that other sp, this way to retrieved to do better error's control.
```
{
  result: ...,
  error_code: number | null,
  message: string
}
```
A common problem is when coding to create or update a script and you need to update to database, but it's slow, however, some script are implemented to decrease time such as update all sp, start backup, etc., but watch out when you update storage procedure because some script need to have variables to function correctly, in aditional that
there is a script to save a backup in your database but it's very important assign variables correctly.

## Environment variables

One each of those variables is essential to function correctly becase some script of bash need it., Your file has to have these variables to function correctly

- DB_HOST
- DB_PORT
- DB_USER
- DB_PASSWORD
- DB_NAME
- FILE_TO_APPLY_BACKUP