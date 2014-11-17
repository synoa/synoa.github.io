# Wordpress from Staging to Dev

## Backups first

- [ ] Create an sql dump from your development database
- [ ] Create an sql dump from your staging database

## Import

We will replace all data in the development database with staging

- [ ] Drop all tables in development database
- [ ] Import SQL Dump to developmnt database

## Relocate the site

* Add following line to the wp-config.php just before the line "Thats all stop editing"
```php
define('RELOCATE',true);
```

* Goto *http://your_domain/wp-login.php*
* Login as normal
* Check the URL in the browser
* Goto Settings > General and verify that both the address settings are correct
* Save changes
* Remove the added line in the **wp-config.php**
* Test the wordpress installation on live server