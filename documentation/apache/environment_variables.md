# Environment Variables

With the Apache server you can set [environment variables](https://httpd.apache.org/docs/2.2/de/env.html) in the `.htaccess` file or directly inside the Virtual Host Configuration. Those variables can then be accessed from within PHP with [`getenv()`](http://php.net/manual/en/function.getenv.php).

### Virtual Host
To configure a variable within the virtual host just add the following line to the configuration file.

```txt
<VirtualHost *:80>
  SetEnv my_variable my_value
</VirtualHost>
```
To configure a Magento Virtual Host into running in Developer Mode add the following to the host configuration:

```txt
<VirtualHost *:80>
  SetEnv MAGE_IS_DEVELOPER_MODE "true"
</VirtualHost>
```

The configuration is only scoped to its `VirtualHost` block. This means if you have  `<VirtualHost *:80>` and `<VirtualHost *:443>` you will need to add the line to both blocks.

To read the configuration use the [`getenv()`](http://php.net/manual/en/function.getenv.php) function.

```php
$myVar = getenv('MAGE_IS_DEVELOPER_MODE');
```

Using this technique the variable can be set without modifying the Magento `.htaccess` file, or any other Magento related file for that matter.

### htaccess

Setting a environment variable inside a `.htaccess` is equally straight forward.

```txt
# Inside the .htaccess file
SetEnv my_variable my_value
```
