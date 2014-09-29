If you receive an 404 while trying to access the downloader (Magento Connect Manager), you have to add the following to `magento/downloader/.htaccess`:

```bash
<IfModule mod_rewrite.c>
    RewriteEngine On
    RewriteCond %{REQUEST_FILENAME} !-f
    RewriteCond %{REUEST_FILENAME} !-d
    RewriteRule . /index.php [L]
</IfModule>
```
