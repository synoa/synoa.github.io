# MySQL-Backup

## Export from production db

## Import into local db

## Clean up local db

```sql
TRUNCATE TABLE `log_customer`;
TRUNCATE TABLE `log_url`;
TRUNCATE TABLE `log_url_info`;
TRUNCATE TABLE `log_visitor`;
TRUNCATE TABLE `log_visitor_info`;
```

## Change the URLs

### base_url: unsecure

```sql
# Retrieve the old values
select * from core_config_data where path = "web/unsecure/base_url"

# Overwrite the old values
update core_config_data set value = "url" where config_id = x and path = "web/unsecure/base_url";
```

### base_url: secure

```sql
# Retrieve the old values
select * from core_config_data where path = "web/secure/base_url";

# Overwrite the old values
update core_config_data set value = "url" where config_id = x and path = "web/secure/base_url";
```

### cookie_domain

```sql
# Retrieve the old value
select * from core_config_data where path LIKE "web/cookie/cookie_domain"

# Overwrite the old value
update core_config_data set value = "url" where config_id = x and path = "web/cookie/cookie_domain";
```

### admin

```sql
# Retrieve the old value
select * from core_config_data where path LIKE "admin/url/custom"

# Overwrite the old value
update core_config_data set value = "url" where config_id = x and path = "admin/url/custom";
```

# Permissions

Move into the root folder of your Magento installation and run the following:

```bash
find . -type f \-exec chmod 644 {} \;
find . -type d \-exec chmod 755 {} \;
find ./var -type d \-exec chmod 777 {} \;
find ./var -type f \-exec chmod 666 {} \;
find ./media -type d \-exec chmod 777 {} \;
find ./media -type f \-exec chmod 666 {} \;
chmod 777 ./app/etc
chmod 644 ./app/etc/*.xml
```

# Host
