# SQL Update problems

On our last update we got problems with an new unique index in magento database.

We could not create an entry with an email which is stored already

## Dropping the index

Check the indexes on table customer_entity
```sql
# show indexes from customer_entity
SHOW INDEXES FROM customer_entity;
```

Drop the index
```sql
# drop unique index email and website_id
DROP INDEX UNQ_CUSTOMER_ENTITY_EMAIL_WEBSITE_ID ON customer_entity;
```

Check again. Index should be removed
```sql
# show indexes from customer_entity
SHOW INDEXES FROM customer_entity;
```

## Reset emails

All emails which are duplicated are rewritten by magento sql upgrade script to ```(duplicate1234)johndoe@example.com``` 

Check this emails
```sql
# show emails with '(duplicate'
SELECT email, SUBSTRING(email, 11)
FROM customer_entity
WHERE email REGEXP '^\\(duplicate[0-9]';
```

Remove ```(duplicate```
```sql
# remove '(duplicate'
UPDATE customer_entity
SET email = SUBSTRING(email, 11)
WHERE email REGEXP '^\\(duplicate[0-9]';
```

Remove numbers ```1234```

We can not say how many numbers will be there so this should be run until no row has matched 
```sql
# remove numbers very often until only char ) is present
SELECT email
FROM customer_entity
WHERE email REGEXP '^[0-9]+)';

UPDATE customer_entity
SET email = SUBSTRING(email, 2)
WHERE email REGEXP '^[0-9]+)';

UPDATE customer_entity
SET email = SUBSTRING(email, 2)
WHERE email REGEXP '^[0-9]+)';

UPDATE customer_entity
SET email = SUBSTRING(email, 2)
WHERE email REGEXP '^[0-9]+)';

UPDATE customer_entity
SET email = SUBSTRING(email, 2)
WHERE email REGEXP '^[0-9]+)';

UPDATE customer_entity
SET email = SUBSTRING(email, 2)
WHERE email REGEXP '^[0-9]+)';

UPDATE customer_entity
SET email = SUBSTRING(email, 2)
WHERE email REGEXP '^[0-9]+)';

UPDATE customer_entity
SET email = SUBSTRING(email, 2)
WHERE email REGEXP '^[0-9]+)';

UPDATE customer_entity
SET email = SUBSTRING(email, 2)
WHERE email REGEXP '^[0-9]+)';

UPDATE customer_entity
SET email = SUBSTRING(email, 2)
WHERE email REGEXP '^[0-9]+)';

UPDATE customer_entity
SET email = SUBSTRING(email, 2)
WHERE email REGEXP '^[0-9]+)';

UPDATE customer_entity
SET email = SUBSTRING(email, 2)
WHERE email REGEXP '^[0-9]+)';

UPDATE customer_entity
SET email = SUBSTRING(email, 2)
WHERE email REGEXP '^[0-9]+)';

UPDATE customer_entity
SET email = SUBSTRING(email, 2)
WHERE email REGEXP '^[0-9]+)';
```

Check all emails with ```)``` at the beginning
```sql
# check all emails with ')' at beginning
SELECT email
FROM customer_entity
WHERE email REGEXP '^\\)';
```

Remove last char ```)```
```sql
# remove last char ')'
UPDATE customer_entity
SET email = SUBSTRING(email, 2)
WHERE email REGEXP '^\\)';
```

Check emails there are no ```(duplicate1234)``` entries any more
```sql
# Check emails from synoa if there are no '(duplicate' emails
SELECT email FROM customer_entity WHERE email LIKE '%example%';
```

Yout got it :+1: