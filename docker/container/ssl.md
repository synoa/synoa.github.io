# Using SSL with Docker

To use SSL with Docker and Apache2 you need to create a SSL certificate and key and add it to your Docker Container. In this example all files are stored inside a `.docker` directory in the root of our project. The image from which we build the Container is [synoa/php-apache](https://hub.docker.com/r/synoa/php-apache/) which comes with PHP and Apache installed.

### Creating the SSL key and cert (self-signed)

If you do not have a "real" certificate, e.g. because you use the Container for local development, create a self-signed SSL key. You can find a script to create self-signed certificate inside the `scripts` folder of this Docker documentation. This guide assumes you are using the script and it is located inside your projects `/.docker` folder.

First, make the file executable and create a new certificate, key and default apache config.
```sh
# inside .docker
$ ./vhost.sh -v myapp
```
You will be asked some questions during the creation of your certificate. Basically they are not important expect for "Common Name" - this must be the URL on which you want your website to be reached. By default it will be whatever you passed as argument followed by `.local`, so in this example `myapp.local`. After answering the questions you will find the following files: `myapp.cert`, `myapp.key` and `000-default.conf`. Next, these need to be added to your container with the Dockerfile.

### Dockerfile

Next is the Dockerfile. Here we will use the [synoa/php-apache](https://hub.docker.com/r/synoa/php-apache/) image and add out certficiate, key, and apache configuration to it.

```dockerfile
FROM synoa/php-apache:5.6.23
MAINTAINER "Synoa GmbH" <info@synoa.de>

COPY ./.docker/myapp.crt /etc/ssl/certs/
COPY ./.docker/myapp.key /etc/ssl/private/
COPY ./.docker/000-default.conf /etc/apache2/sites-enabled/

RUN a2enmod rewrite
RUN a2enmod ssl
RUN service apache2 restart

EXPOSE 443
```

That's it! Now our container nows about the certificate and key and is using out `000-default` configuration file. All that is left now is to add the name and IP to our `/etc/hosts` file.  Read our docs on how to [manage IP addresses with docker](https://github.com/synoa/synoa.github.io/tree/master/docker/container/ip.md) to setup and adjust your `docker-compose.yml`

To use the self-signed certificate in Chrome see [Add self signed certificate in chrome](https://github.com/synoa/synoa.github.io/blob/master/documentation/apache/ssl.md#add-self-signed-certificate-in-chrome).
