# Code

Clone the project you want to work with to your local machine. 

```bash
# Example
cd /home/user/Development
git clone git@github.com:synoa/myproject
```

# Host

## Local host

```bash

# Create the host
sudo nano /etc/hosts

# Example
127.0.0.1 myproject.local
```

## VHost

```bash

# Create the VHost
sudo nano /etc/apache2/sites-enabled/myproject.local

# Example
<VirtualHost *:80>
    ServerAlias myproject.local
    DocumentRoot /home/user/Development/myproject
</VirtualHost>
```

## Reload apache

```bash
sudo service apache2 reload
```

If your `DocumentRoot` exists and you open `myproject.local/` in your browser, you should see something. 


# MySQL-Backup

## Export from production db

```sql
# Create the backup
mysqldump -p --create-options --lock-tables=false myproject_magento > myproject_magento_production.sql
```

```bash
# Create an archive from your backup
tar -czf myproject_magento_production.sql.tgz myproject_magento_production.sql

# Copy the backup to your machine
scp user@ip:/myproject_magento_production.sql .
```

## Import into local db

```sql
mysql -uroot -p myproject_magento_local < myproject_magento_production.sql
```

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
select * from core_config_data where path = "web/unsecure/base_url";

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
select * from core_config_data where path LIKE "web/cookie/cookie_domain";

# Overwrite the old value
update core_config_data set value = "url" where config_id = x and path = "web/cookie/cookie_domain";
```

### admin

```sql
# Retrieve the old value
select * from core_config_data where path LIKE "admin/url/custom";

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
