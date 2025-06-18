# Manual Union Based Exploitation

## **Step 1: Finding Vulnerable Website: Google Dorks**

Our best partner for SQL injection is Google. We can find the Vulnerable websites(hackable websites) using Google Dork list. google dork is searching for vulnerable websites using the google searching tricks. There is lot of tricks to search in google. But we are going to use “inurl:” command for finding the vulnerable websites.

Some Examples:

**`inurl:gallery.php?id=`**

**`inurl:article.php?id=`**

**`inurl:pageid=`**

Note: if you like to hack particular website, then try this:

**`site:www.victimsite.com inurl:index.php?id=`**

## **Step 2: Check for the Vulnerability:**

- Either trigger some error by applying single quote(‘) or double quote (“) to the input field
- Or you can try some of the true condition so that it will show all the database contents

```bash
' or 1=1;--
```

- Or you can use **`Burpsuite Intruder`** to apply all the payloads and notice them.
- If the database respond to the commands by error or anything, take it as a vulnerable website

## **Step 3: To get some data back from server:**

As you find that the website is vulnerable try this queries after the SQL expression/commands

```sql
UNION SELECT
UNION SELECT 1,2
UNION SELECT 1,2,3
```

- *Try this until you get some data back from web server*
- Suppose you get data back from server when you use 3
- It means the table we are working with has 3 columns.
- Sometimes not all the columns are publicly exposed, they are being private.
- Now the query depends on the SQL database type and version
- Try to find out the database type like My-SQL, Oracle, SQLITE etc.
- GOOGLE for the specific database type documentation and craft you payload
- Retrieve the version and database if needed
- You can retrieve the information by using the columns that are publicly exposed

```sql
' UNION SELECT 1,2,database()
```

```sql
' union select 1,2,group_concat(table_name) from information_schema.tables where table_schema=<database_name>
```

```sql
' union select 1,2,group_concat(column_name) from information_schema.columns where table_name = <the_table_name>
```
