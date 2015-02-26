# Setting up multisites

Multisites are by default available in WordPres >= 3.0 but must be enabled via
the `wp-config.php`. To do so, open up `wp-config.php` and place the following
snippet anywhere.

```php
define( 'WP_ALLOW_MULTISITE', true );
```

After doing so there's a point `Network Setup` under `Tools` in the backend.
From her on, Multisites can be configured. 

### Sub-directories

When using sub-directories it is important to activate multisites *before*
creating posts or pages, otherwise the option of using sub-directories will be
gone and you're left with the only other option: Sub-Domains.
