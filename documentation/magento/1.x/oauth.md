# REST API Authorization wiht OAuth

## Create OAuth Consumer in Magento

Go to `System -> Webservices -> Rest - OAuth Consumers` in Backend and create an new consumer and you will get

* consumer_key
* consumer_secret

## Create an user

TODO

## Create REST Role

TODO

## Initiate the OAuth process

Call `http://<magento>/oauth/initiate` with following GET params:

| Param | Description |
| ------------- |-------------|
| oauth_callback | This URL will be called by magento at last and the finale token and secret will be GET params |
| oauth_consumer_key | The consumer key |
| oauth_signature_method | The method of the signature e. g. `HMAC-SHA1` |
| oauth_timestamp | The actual timestamp |
| oauth_nonce | nonce (Number used once) in combination with timestamp prevents replay attacks. You can not use the same nonce twice for the same timestamp |
| oauth_version | The version (1.0) for magento REST API |
| oauth_signature | TODO |

This request will give you

* oauth_token
* oauth_token_secret

Keep this values, which will be needed later.

## Authorize the App

Call `http://<magento>/oauth_authorize?oauth_token=<oauth_token>

This will lead you to an login form in which you authorize the app to gather your user date from magento

If you are already logged in in backend of magento you will only see an authorize form.

After you authorized the app the callback URL, which we provided in first request will be called with following GET params:

* oauth_token
* oauth_verifier

## Get the persistent token and secret

Call `http://<magento>/oauth/token` with following GET params:

| Param | Description |
| ------------- |-------------|
|oauth_verifier|The verifier from last request|
|oauth_consumer_key|The consumer key|
|oauth_token|The token|
|oauth_signature_method|The method of the signature e. g. `HMAC-SHA1`|
| oauth_timestamp | The actual timestamp |
| oauth_nonce | nonce (Number used once) in combination with timestamp prevents replay attacks. You can not use the same nonce twice for the same timestamp |
| oauth_version | The version (1.0) for magento REST API |
| oauth_signature | TODO |

This last request will give us

* oauth_token
* oauth_token_secret

which will never expire to create requests on REST API.

## Calling REST API

### get products

Call `http://<magento>/api/rest/products` with following **Header** 
```
Authorization:OAuth oauth_consumer_key="<consumer_key>",oauth_token="<oauth_token>",oauth_signature_method="<signature_method>",oauth_timestamp="<timestamp>",oauth_nonce="<nonce>",oauth_version="<oauth_version",oauth_signature="<oauth_signature>"
```
