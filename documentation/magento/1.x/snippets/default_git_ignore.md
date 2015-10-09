
```txt
# ignore sample files not needed on server
.htaccess.sample
php.ini.sample
errors/local.xml.sample
index.php.sample

# ignore modman 
.modman/

# never put db credentials in git repo
app/etc/local.xml
app/etc/local.xml.additional
app/etc/local.xml.template

# ignore favicon
favicon.ico

# ignore license files
LICENSE_AFL.txt
LICENSE.html
LICENSE.txt
LICENSE_EE*
RELEASE_NOTES.txt

# ignore development tests
dev/*

# ignore product images
media/catalog/product/

# ignore placeholder image
media/catalog/product/placeholder/default/

# ignore uploads from user 
media/customer/*

# ignore downloadable products
media/downloadable/*

# ignore imports
media/import/

# ignore media xmlconnect
media/xmlconnect/

# ignore changes with wysiwyg
media/wysiwyg/*

# ignore includes/ but not config.php inside
includes/*
!includes/config.php

# ignore sitemap - it will be generated
sitemap.xml

# Kevin would ignore default themes and skins - gerhard would not

# app/design/frontend/default/blank/
# app/design/frontend/default/default/
app/design/frontend/default/iphone/
app/design/frontend/default/modern/
# skin/frontend/default/blank/
skin/frontend/default/blue/
# skin/frontend/default/default/
skin/frontend/default/french/
skin/frontend/default/german/
skin/frontend/default/iphone/
skin/frontend/default/modern/

# ignore everything in  var but not var/package/
var/*
!var/package/

# ignore magento connect download cache
downloader/.cache/

# ignore sass
.sass-cache/

# ignore node modules
node_modules/

# ignore error_log file
error_log

# ignore maintenance mode
maintenance.flag

# include all .htaccess files
!media/customer/.htaccess
!media/.htaccess
!media/downloadable/.htaccess
!downloader/.htaccess
!downloader/template/.htaccess
!skin/frontend/rwd/default/scss/.htaccess
!pkginfo/.htaccess
!.htaccess
!includes/.htaccess
!var/.htaccess
!lib/.htaccess
!errors/.htaccess
!app/.htaccess
!dev/.htaccess

# custom settings here, CHECK THAT YOU DONT IGNORE .htaccess FILES
