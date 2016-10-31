# Run docker Container with pre-defined IP

To run a docker container in a certain IP range you'll need to create or define a network, either with `docker network create` or inside `docker-compose.yml`.

## docker-compose

To use a network with docker-compose, add the following top level directive to your `docker-compose.yml`.

```yaml
version: '2'

networks:
  my_network:
    driver: bridge
    ipam:
      driver: default
      config:
      - subnet: 173.20.0.0/24
        gateway: 173.20.0.1
```

This makes the container(s) use the network with IPs in the range of `173.20.0.0` to `173.20.0.24`. You can now assign fixed IPs to services, e.g.:

```yaml
services:
  db:
    image: mariadb:5.5
    volumes:
      - "./.db:/var/lib/mysql"
    ports:
      - 3306
    environment:
      MYSQL_ROOT_PASSWORD: root
      MYSQL_DATABASE: magento
      MYSQL_USER: root
      MYSQL_PASSWORD: ""
    networks:
      my_network:
        ipv4_address: 173.20.0.4

  magento:
    depends_on:
      - db
    build: .
    links:
      - db
    volumes:
      - ".:/var/www/html"
    ports:
      - "443:443"
      - "8080:80"
    networks:
      my_network:
        ipv4_address: 173.20.0.3
```

`my_network` is the name you used when setting up the network. The IPs are then bound to the containers, in this example for Magento and DB. You can then use [SSL](https://github.com/synoa/synoa.github.io/tree/master/docker/container/ssl.md) and named virtual hosts with it. To use a named virtual host make sure to add the IP address to your `/etc/hosts` file just like you would do with a local apache server.

```txt
# /etc/hosts
173.20.0.3 mysite.dev
```
