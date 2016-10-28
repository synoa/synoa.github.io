# Using SSL with Docker

To use SSL with Docker and Apache2 you need to create a SSL certificate and key and add it to your Docker Container. In this example all files are stored inside a `.docker` directory in the root of our project. The image from which we build the Container is [synoa/php-apache](https://hub.docker.com/r/synoa/php-apache/) which comes with PHP and Apache installed.

### Creating the SSL key and cert (self-signed)

If you do not have a "real" certificate, e.g. because you use the Container for local development, create a self-signed SSL key. You can find a script to create self-signed certificate inside the `scripts` folder of this Docker documentation. This guide assumes you are using the script and it is located inside your projects `/.docker` folder.

First, make the file executable and create a new certificate, key and default apache config.
```sh
# inside .docker
$ ./ssl.sh -v myapp
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

That's it! Now our container nows about the certificate and key and is using out `000-default` configuration file. All that is left now is to add the name and IP to our `/etc/hosts` file. For this you must know the IP address of your Docker container. I have not yet found a good way to get the IP, other than running `ifconfig | grep docker -A 8` to get the "base" IP of docker, e.g.

```txt
docker0   Link encap:Ethernet  HWaddr 02:42:9b:d2:f6:48  
          inet addr:172.17.0.1  Bcast:0.0.0.0  Mask:255.255.0.0
          inet6 addr: fe80::42:9bff:fed2:f648/64 Scope:Link
          UP BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:33 errors:0 dropped:0 overruns:0 frame:0
          TX packets:13 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:2424 (2.4 KB)  TX bytes:2342 (2.3 KB)

```

When you start the container with `docker-compose up`, however, the apache log will tell you the IP. In my case it was always `173.20.0.3` which results in the following hosts entry:

```
# /etc/hosts
172.20.0.3 myapp.local
```

To use the self-signed certificate in Chrome see [Add self signed certificate in chrome](https://github.com/synoa/synoa.github.io/blob/master/documentation/apache/ssl.md#add-self-signed-certificate-in-chrome). 
