# How to create and use own signed SSL certificate

How to setup a vhost to use only https traffic with self-signed certificate

## Install openssl

Install openssl package in Ubuntu if you have not installed it before

```bash
sudo apt-get install openssl
```

## Generate private key

Private keys are stored in */etc/ssl/private/*

You can generate a key but you should switch to root user first with

```bash
sudo -i
```

Now generate your key named *apache.key*

```bash
openssl genrsa -out /etc/ssl/private/apache.key 2048 
```

You can change the value 2048 to 4096 if you want

Note: There is no passphrase here because if you set a passphrase apache will ask for it every restart or it have to be provided in plain text in configuration.

## Generate self signed certificate

Certificates are stored in */etc/ssl/certs/*

Create a self signed certificate with

```bash
openssl req -new -x509 -key /etc/ssl/private/apache.key -days 365 -sha256 -out /etc/ssl/certs/apache.crt 
```

You have to provide some infos. Important is the *Common Name* this should be your domain. E. g. *my-site.dev*

Now you can close the root terminal with

```bash
exit
```

## Enable module in apache

Apache have to listen to port 443 check if the following lines are uncommented in */etc/apache2/ports.conf*

```apache
<IfModule mod_ssl.c>
    Listen 443
</IfModule>
```

Reload the apache configuration

```bash
sudo service apache2 reload 
```

Enable module with

```bash
sudo a2enmod ssl
sudo service apache2 force-reload 
```

## Edit vhost

Edit your vhost config

```apache
<VirtualHost *:443>
    SSLEngine on
    SSLCertificateFile /etc/ssl/certs/apache.crt
    SSLCertificateKeyFile /etc/ssl/private/apache.key
    
    # Path to doc root
    DocumentRoot /var/www/
</VirtualHost>
```

## Change all traffic to https

In your *.htaccess* file you can add to change all http requests to https

```apache
# HTTPS everywhere
RewriteCond %{HTTPS} !=on
RewriteRule .* https://%{SERVER_NAME}%{REQUEST_URI} [R=301,L]
```

## Add self signed certificate in chrome

Okay jetzt auf deutsch weil sonst versteht man es nicht mit den Übersetzungen in Chrome

Ruft man den vhost auf, bekommt man ein durchgekreuztes Schlosssymbol.

Man lässt sich die Zertifikatinformationen anzeigen und exportiert dieses als Datei mit der Endung *.pem* 

Anschließend öffnet man in den Einstellungen die Zertifikatsverwaltung

Im dritten Tab *Zertifizierungsstellen* wählt man Importieren und wählt seine Datei. 

Nach einem Browserneustart sollte jetzt ein grünes Schloss kommen. 
