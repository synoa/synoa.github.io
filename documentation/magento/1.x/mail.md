# eMails
## Setting up eMails with Magento on Ubuntu 14.04/Apache2

To set up emails with Magento on Ubuntu (or Unix) using Apache2 and `sendmail` there's actually not that much to do, yet
there's a lot to do wrong. First of all sendmail must be installed.

```
$ sudo apt-get update
$ sudo apt-get install sendmail
```

After the installation is completed, you can run the initial setup with `$ sudo sendmailconfig`. Basically, I said "Yes"
to everything it needs to setup. Afterwards, sendmail is installed and should work. 

First of all you can test `sendmail` from the command line by using the following. HINT: When starting `sendmail -t` the
cursor goes to the next line and blinks. This is the normal behavior and you can start writing everything (To:, From:,
etc.) there.

```
$ sendmail -t
To: yourmail@yourhost.com
From: cmd@localhost
Subject: Hello there

This is my test message!
```
Now all you need to do is hit `CTRL+D` to sent the email. This may take a while.
**Note:** Your message will most likly be inside the Spam folder since "cmd@localhost" is most likly flagged as spam (at
least in GMail).


To test if it works with PHP, too, put the following in a php file and open it on your localhost.
```php
$to = 'k.gimbel@synoa.de';                                     
$subject = 'testing PHP eMails';
message = 'Lorem Ipsum Dolor email Yo hi there.';                                                                      
                                                                                                                        
if(mail($to, $subject, $message, null, '-something@example.com')) {                                                    
   echo 'eMail was sent successfully!';                                                                                  
} else {                                                                                                                
   echo 'nope';                                                                                                          
}  
```
**Note:** The last parameter (`-something@example.com`) is needed, otherwise newer PHP versions won't sent the email. 

So now everything is setup and good to go! Last thing you need to configure is in the Magento Backend. Get to
`System->Configuration->Advanced->Mail Sending Settings` and make sure 1) "Set Return Path" is set to "Specified" and
the new field, which shows if it is set to Specified, has a value of basically any eMail. This is the eMail to which not
dilivered eMails will be sent. (The parameter from the Note above!). 


### Fixin issues

You'll maybe get an error saying `client denied by server configuration` in `/var/log/apache2/error.log`, to
prevent this add the following to `apache2.conf`.

```xml
 <Directory "/path/to/project/">                                                                           
  AllowOverride all                                                                                                     
  Order allow,deny                                                                                       
  Allow from all                                                                                          
</Directory> 
```
