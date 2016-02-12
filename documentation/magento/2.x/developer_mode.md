# Turning on Developer Mode in Magento 2.x

In Magento 1.x Developer Mode could be turned on by setting the Server
Environment variable `MAGE_IS_DEVELOPER_MODE` to true OR editing the
`index.php`. In Magento 2 this has changed a bit.

### CLI

The easiest way is to use the Magento CLI (located in `<magento_root>/bin/`) and
"deploying" developer mode. 

```bash
$ ./bin/magento deploy:mode:set developer

```
That's it. The Mode of the Magento Application is now set to "developer" which
will show all errors that might occure. 

### .htaccess
It can also still be set inside the `.htaccess` file. Important is - compared to
Magento 1.x - that the new Variable Name is just `MAGE_MODE` instead of
`MAGE_IS_DEVELOPER_MODE`.

```txt
# Inside the .htaccess
# Set Magento to developer mode
SetEnv MAGE_MODE developer
```

