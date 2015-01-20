# Wordpress Installation

## Install Wordpress on local machine

### Create database on local machine

* If you got a database from hosting partner create a new database on local machine with same user and pass and grant rights to this database
* If you have to create a new one than create it locally and on live server with an user which has only rights to this single database

### Install wordpress on local machine

* Install wordpress on a new vhost
* Change the database table prefix while installation

## After installation

### Remove user with id 1

When you install wordpress the user with the id 1 has admin rights

* Create a new user with admin rights
* Login with this new user
* Delete the first user with id 1

* Create other users if needed

### Remove all plugins

* Remove all default plugins from wordpress

### Install plugins

Note: Check if there are better plugins

* Install plugin for [maintenance](https://wordpress.org/plugins/wp-maintenance-mode/)
* Install plugin for [seo](https://wordpress.org/plugins/wordpress-seo/)
* Install plugin for [forms](https://wordpress.org/plugins/contact-form-7/)

### Activate plugins and change settings

* Activate all installed plugins
* Set right settings for maintenance mode

## Move wordpress to live server

### Puhs and pull code

* Push code to repo
* login in server and pull from repo

### Import database

* Create a SQL dump from your local database
* Import the dump on live server

## Final setup on live server

### Create a wp-config.php

The wp-config.php should never be in the repository. In this file the database user is stored. So you have to create it on live server with the content of the wp-config.php on your local machine

### Set file permission of wp-config.php

* Set file permission to 640 for **wp-config.php**

```bash
chmod 640 wp-config.php
```

Note: If 640 is not possible set it to 644

### htaccess
Create an .htaccess file with
```apache
<files wp-config.php>
	order allow, deny
	deny from all
</files>
```

### Relocate the site

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