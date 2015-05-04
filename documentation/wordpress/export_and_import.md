# Exporting and Importing Content with the WordPress Importer

One thing that WordPress is really good at is exporting and importing from one installation to
another. WordPress comes with a build-in Export tool and an optional Import Tool (officially). 

**If there's anything wrong during these steps, see the Troubleshooting section below!**

## Exporting
To export data from an existing WordPress installation go to **Tools -> Export Data** and select
what you want to export (*All Content*, *Posts*, *Pages*, etc.). Select what you want or need, most
likely it'll be **All Content**. 

WordPress will now generate an XML file containing all information it needs, save this file
somewhere, you'll need it in the next step.

## Importing
To import content, go to **Tools -> Import Data** and select the type of Import. Most likely, it is
a WordPress to WordPress import so you'll want to select **WordPress** from the table. This will
open a modal with a Plugin that you need to install. After installation and activation, let's import
the WordPress XML.

Select the File and click **Upload file and import** to import all your content from the old WordPress
installation. Next, you can assign the Authors from the old installation. They'll be able to log-in
to your new installation with their Log-in details from the old WordPress system. If you want to,
and most likely you will want to, you can check the "Download and import file attachments" checkbox
at the bottom. This will fetch all files from the old WordPress System and create the directories
under `wp-content/uploads` as needed. Now the importer will run and do all the magic.

## Troubleshooting

### Local Development
In local Development there is most likely no FTP user, however an FTP "Account" is normally needed
for Plugins to be installed. You could either try and setup and FTP user locally or define "direct
  upload" in WordPress (which is WAY easier). To enable direct Upload, add the following line to the
`wp-config.php`. This allows WordPress to download and extract Plugins directly to the file system.

```php 
// Direct install of Plugins instead of using FTP
define('FS_METHOD', 'direct');
```

### Maximum File size exceeded
It can (easily) happen that the default file size for uploads is exceeded. On Apache 2.4.7 running
on Ubuntu 14.04 with PHP 5.5.9 the default `max_upload_filesize` is 2MB. A XML file of a whole
WordPress installation is likely bigger than 2MB so we need to adjust the `max_upload_filesize`.
This can be done in the `php.ini` file located in `/etc/php5/apache2/php.ini`. 
**Note: This configuration will be available Apache-wide, so it effects all Virtual Hosts**.

Open the php.ini with your favorite editor and edit the following line
```
// Default value
upload_max_filesize = 2M
// Our new value, e.g. 5M = 5MB
upload_max_filesize = 5M
```
