Document is still in development

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

## Authorize the token

Call `http://<magento>/oauth_authorize?oauth_token=<oauth_token>
