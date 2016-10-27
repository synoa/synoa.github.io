# Problem

If you upgraded to Ubuntu version 16.04 there is PHP7 installed in default and activated every now and then by system updates

## Install PHP 5.6 besides and change versions

See this link http://askubuntu.com/questions/761713/how-can-i-downgrade-from-php-7-to-php-5-6-on-ubuntu-16-04

## Switch versions

### From php5.6 to php7.0 :

#### Apache:

```
sudo a2dismod php5.6 ; sudo a2enmod php7.0 ; sudo service apache2 restart
```

#### CLI:

```
sudo ln -sfn /usr/bin/php7.0 /etc/alternatives/php
```

### from php7.0 to php5.6:

#### Apache:

```
sudo a2dismod php7.0 ; sudo a2enmod php5.6 ; sudo service apache2 restart
```

#### CLI:

```
sudo ln -sfn /usr/bin/php5.6 /etc/alternatives/php
```
