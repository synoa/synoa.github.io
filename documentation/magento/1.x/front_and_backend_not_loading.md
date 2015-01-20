# Front- and Back-End not loading anymore

It can happen that the Front-End as well as the Back-End is unreachable. Inside the browser the page will continue to
load as if it would try to connect to the host. Here are a few things that can be tested to fix this.

### Clear Cookies/Browser data
This error can be tested agains easily by opening a new incognito tab (`CTRL+SHIFT+N` for Chrome) and trying to load the
front or backend URL. If the page loads normally you can clear your cookies and everything should work again.

### Checking URL inside the database
There are a few places inside the database where URLs are set, all we want are inside the table `core_config_data`.

```
$ mysql -uroot
> use projectDatabase;
> select * from core_config_data where path = "web/unsecure/url";
```
If the URL inside the value field is not the same as your local development URL, update it!
```
> update core_config_data url = "http://dev-system.local/" where id=x and path = "web/unsecure/url";
``` 
Do the same for `path = "web/secure/url"`. If they are all correct, continue with `web/cookie/domain`.
```
> select * from core_config_data where path LIKE "web/cookie/cookie_domain";
```

The `cookie_domain` entry should be `NULL`, everything else can produce errors (as of Magento 1.9.0.1). Update the value
as below if it is not null.

```
> update core_config_data set value = NULL where config_id = x and path = "web/cookie/cookie_domain";
```
### Permissions
Permissions can be tricky, make sure to set the permissions for files as explained [here in our
documentation](https://github.com/synoa/synoa.github.io/blob/master/documentation/magento/1.x/local_development.md#permissions).
Also make sure to configure git to ignore file modes and permissions.
```
git config core.fileMode false
```

### Server error logs
After all, it could be Apache is not working correctly so first test if the PHP file that's loaded is yours by adding the
following to the top of your index.php inside the Magento root folder. 
```
<?php
die('The correct file is loaded!`);
```
If you see this, at least the correct PHP file is loaded, if not - well, Apache seems to be stuck! 
However, make sure to look inside the error logs! Maybe the server can't access files? The server log is located in `/var/log/apache2/error.log`.

### Magento log
Maybe Magento is doing something wrong? See if there's something in the logs inside `$magentoroot/var/log/`.

