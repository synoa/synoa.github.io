## Create self signed certificate

Generate a private / public key [as described here](https://github.com/synoa/synoa.github.io/blob/master/documentation/apache/ssl.md). 

## Convert the private key to DER

```
openssl pkcs8 -topk8 -nocrypt -in <path to apache.key> -inform PEM -out apache.der -outform DER
```

## Convert the public certificate to DER

```
openssl x509 -in <path to certificate.pem> -inform PEM -out <certificate.der> -outform DER
```

## Create the KeyStore

[Download the `ImportKey.java`](https://github.com/synoa/synoa.github.io/blob/master/documentation/java/ImportKey.java) class and compile it:

```
javac ImportKey.java
```

Now you can use ImportKey to import the generated DER files into the KeyStore:

```
java ImportKey apache.der <certificate.der>
```

This generated a keystore file with the default password `importkey`. 

@see [Further information](http://www.agentbob.info/agentbob/79-AB.html).


## Create a truststore by using your `<certificate.pem>`: 

```
keytool -import -file <certificate.pem> -alias CAAlias -keystore truststore.ts -storepass StorePass
```

@see [Further information](https://access.redhat.com/documentation/en-US/Fuse_Message_Broker/5.3/html/Security_Guide/files/i379776.html).

## Use the generated keystore & truststore files as java parameters

```
-Djavax.net.ssl.trustStore=<path to truststore.ts>
-Djavax.net.ssl.trustStorePassword=<truststore password>
-Djavax.net.ssl.keyStore=<path to keystore file> 
-Djavax.net.ssl.keyStorePassword=<keystore password>
```
