**This documenation is for a review and it is not recommended to make upgrade with this documentation in its current state**

# Upgrade Magento

## Make sure no core files are touched

* Download your installed version of magento and unzip it to any location
* Make a pull to get actual version
```git
git pull
```
* create a branch in your local development environment
```
git checkout -b "/junk/diffCoreFiles"
```
* copy all files from downloaded package and overwrite your files in branch
* check git if core files are touched
```git
git status
```
* Diff every file which is touched
```
git diff filename.xxx
```

## Check issues with upgraded version

* It is recommended to check the internet for problems with upgrading to this version.

## Download actual magento version

Download the version you wish to upgrade to.

## Pre Upgrade Tasks on Production Server (recommended by magento)

* Enable Exception Logging
* Disable cron jobs
* Setting all Indexers to Update on Save and note the original values
* Flush the cache
* Make a backup of the database
---
* If you enabled exception logging maybe you want to enable it again
* If you changed Indexer settings maybe you want to  set Indexers back to other values if changed

## On development

### Magento Installation Files

* Unzip your magento installation files anywhere
* Remove files:
 * errors/local.xml.sample
 * index.php.sample
 * .htaccess.sample
 * php.ini.sample
 * favicon.ico

## Development Installation

* Make a pull to get actual version

```git
git pull
```
* create a branch in your local development environment

```
git checkout -b "/upg/#callId/upgradeToVersion_x.x.x"
```
* remove folder app/code/core

```bash
rm -rf app/code/core/
```

* Check community extensions which are in magento installation files
* remove all directories in **app/code/community/** which are also in the **app/code/community/** in your installation files
* copy all files from magento installation files and overwrite existing files
* Import Database

```bash
mysql -u dbuser -p dbname < dump.sql
```

### Change the URLs in database

base_url: unsecure

```sql
# Retrieve the old values
select * from core_config_data where path = "web/unsecure/base_url";

# Overwrite the old values
update core_config_data set value = "url" where config_id = x and path = "web/unsecure/base_url";
```

base_url: secure

```sql
# Retrieve the old values
select * from core_config_data where path = "web/secure/base_url";

# Overwrite the old values
update core_config_data set value = "url" where config_id = x and path = "web/secure/base_url";
```

cookie_domain

```sql
# Retrieve the old value
select * from core_config_data where path LIKE "web/cookie/cookie_domain";

# Overwrite the old value
update core_config_data set value = "url" where config_id = x and path = "web/cookie/cookie_domain";
```

admin

```sql
# Retrieve the old value
select * from core_config_data where path LIKE "admin/url/custom";

# Overwrite the old value
update core_config_data set value = "url" where config_id = x and path = "admin/url/custom";
```
Update Base URL for development
Check the local.xml configuration

### Set file permissions

Go into the root folder of your Magento installation and run the following:

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

### Enable Debug options

* Enable Exception Logging
* Set developer mode in .htaccess file
```apache
############################################
## Enable magento developer mode
SetEnv MAGE_IS_DEVELOPER_MODE true
```

* Set error reporting (best is all but if you get to many notices you can change to second line)
```php
Set error_reporting(E_ALL | E_STRICT);
// Set error_reporting(E_ERROR | E_WARNING | E_PARSE);
```

* Display PHP errors
```php
#ini_set('display_errors', 1);
```
* Tail log files
```shell
tail -f var/log/*
```
* Open Base URL in browser for development, this will run upgrade scripts which maybe change the database
* Check errors and exceptions and fix it
* Set up magento cron jobs
* Clear subdirectories
 * /var/cache/
 * /var/full_page_cache/
 * /var/locks/
* Check Indexers

### Testing

Testing your development all use cases. That means:

* all magento features 
* all custom features which are added with custom modules. 
* We have to ensure that all features which should be disabled are not enabled again with the upgrade

Best practice is automatic testing but if you have to test manually you should grab a list with tests and mark them as valid or invalid.

To get a good starting point you could use the Software Requirements Specification to define our first tests. While testing you should open log files and watch out for exceptions and have a look at the javascript console in your browser.

## Upgrade live

If all bugs are fixed and development and staging is working like expected you can push it to the live server and keeping fingers crossed.