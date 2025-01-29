* ## Injection Points
* * ## Parametes
* * ## Giving Inputs
     * Error Based
     * Tautology Based
     * Timing Attacks
     * Merging Characters
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
### Here is a list of parameters to check
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
- Simple characters

        '
        "
        ;
        )
- Simple characters encoded: `%27`, `%22`, `%23`, `%3B`, `%29` and `%2A`
- Multiple encoding: `%%2727`, `%25%27`
- Unicode characters: `U+02BA`, `U+02B9`







    
