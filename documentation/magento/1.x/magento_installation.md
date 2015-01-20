# Magento Installation

## Create vhost on locale machine
Example for Ubuntu:

vhost should be reachable under http://vhost.dev

### Create vhost configuration
Datei anlegen unter **/etc/apache2/sites-available/vhost.dev.conf**

```apache
<VirtualHost *:80>
	ServerName vhost.dev
	ServerAdmin webmaster@localhost
	DocumentRoot /var/www/vhost.dev
	<Directory /var/www/vhost.dev>
                Options Indexes FollowSymLinks MultiViews
                AllowOverride all
                Order allow,deny
                allow from all
        </Directory>
	ErrorLog /var/log/apache2/vhost.dev/error.log
	CustomLog /var/log/apache2/vhost.dev/access.log combined
</VirtualHost>
```

### Create needed folders
Create folder in **/var/log/apache2/vhost.dev/**

Create folder in **/var/www/vhost.dev/**

### Create index HTML file
Create file **/var/www/vhost.dev/index.html**
```html
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>Hello vhost.dev</title>
</head>
<body>
	<p>Hallo vhost.dev</p>
</body>
</html>
```

### Create PHPinfo
Create file **/var/www/vhost.dev/phpinfo.php**
```php
<?php
phpinfo();
?>
```

### Edit hosts file
Insert in **/etc/hosts** following line
```sh
127.0.0.1 vhost.dev
```

### Enable site and apache restart
Enable site with
```sh
sudo a2ensite vhost.dev.conf
```

Restart apache with
```sh
sudo service apache2 restart
```

You should see no errors

## Test vhost

Reqeust in browser http://vhost.dev. It should display **Hallo vhost**

Reqeust in browser http://vhost.dev/phpinfo.php should display PHPinfo

Remove index files

```sh
rm /var/www/vhost.dev/index.html
rm /var/www/vhost.dev/index.php
```

## Create private GIT repository
Create on GIT website a private repository

Change to vhost folder
```
cd /var/www/vhost.dev/
```

### init GIT
```
git init /var/www/vhost.dev/
```

### Add GIT repository
```
git add remote <url>
```

### Create recommended files
Create file **var/www/vhost.dev/.gitignore**
```
.DS_Store
media/catalog/product/cache/*
media/customer/*
media/dhl/*
media/downloadable/*
media/import/*
media/xmlconnect/*
var/cache/*
var/locks/*
var/log/*
var/session/*
var/resource_config.json
app/etc/local.xml
downloader/.cache/*
.modman/
```

Create file **var/www/vhost.dev/README.md**
```
# Vhost Projekt
```

### Commit and push

Add this files to next commit
```
git add *
```

Commit
```
git commit -m "<nice commit message goes here>"
```

Push
```
git push origin
```

## Create Database

If you have no hosting data create a database and a user with all privileges on created database and no other rights. 

If you have hosting data create a database named like hosting data and create user with all privileges on this created database. Username and pass should follow hosting data.

## Install magento
### Copy files
Copy **all** (also hidden files) files from magento in **/var/www/vhost.dev**

Change owner and rights:
```
sudo chown -R www-data:www-data /var/www/vhost
sudo chmod 775 /var/www/vhost
sudo find /var/www/vhost -type d -exec chmod 775 {} \;
sudo find /var/www/vhost -type f -exec chmod 664 {} \;
```

### Install script
Request with your browser http://vhost.dev

Follow install script

### Create admin accounts for everyone

Admin Accounts anlegen

## Install extensions

Maybe installation will fail with magento connect. If it fails you can try to get the souce files with http://freegento.com/ddl-magento-extension.php

### Store maintenance

Install it from http://www.magentocommerce.com/magento-connect/store-maintenance.html

Go to Backend -> System -> Configuration -> Store Maintenance and change the values that the store is in maintenance but reachable for logged in admin users.

If it is installed succesfully commit it.

### German Setup

Install it from http://www.magentocommerce.com/magento-connect/german-setup.html

If it is installed successfully commit it. 

## Final Push

First check if files are all commited and your branch is up to date
```sh
git status
```

You can add files with
```sh
git add <filename>
```

Push it
```
git push origin
```

## Go live

Login with ssh to the live server.

### Clone repository
```sh
git clone <url> <document root>
```