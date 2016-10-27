# Apache Camel Misc Section

## Difference direct and seda

* direct component is blocking in route
* seda is non-blocking in route

## Start on local machine

```
mvn camel run
```

## Start on local machine with hawtio
This works only on cli at the moment

```
mvn hawtio:camel
```

## Deploy to server

In project root

```
mvn clean install
```

You need the ```*.jar``` files in every project in ```target``` folder and upload them to the server

### Show log

You can connect to karaf and show logs with

```
log:tail
```

Copy the ```*.jar files``` to ```deploy``` Folder in karaf installation and check the log files

## List Bundles

Connect to karaf and list bundles with ```list```

## Restart Application (Bundle)

You can restart application (bundle) with

```
bundle:restart [ID in list]
```
