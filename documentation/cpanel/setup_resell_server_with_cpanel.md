# Setup a new customer on the resell server with cPanel

Staging systems are created on our own Resell Server using the cPanel Backend. cPanel can be quite overwhelming with all its functions which is why documenting the steps needed is not a bad idea.

### Create a new customer

Login to cPanel (if you haven't received login credentials ask a your project manager). On the cPanel Home select "Account functions" (`Kontofunktionen`), then click "Create new Account" (`Neues Konto erstellen`). Enter the credentials as follows:

Field | Field EN | Value Description | Example |
--------|----------|-------------------|---------|
Domäne | Domain |A valid domain - can be random, e.g. dev.example.com Domain MUST NOT exist! | stage.customer.com
Benutzername | User | Main user for the account, e.g. the customers' name | myuser
Kennwort | Password | The passsword for the new host. Use the generator and save the password in the password manager | -
E-Mail | E-Mail | Your e-Mail address or the address of the project manager | -
Paket | Package | Select the package to create the server from - ask your PM if unsure | Synoa_Cloud-M

Now following is what to check or uncheck.

**Settings**
- [ ] CGI
- Localization: German (or English, depends on the client)

**DNS Settings**

- [x] DKIM
- [x] SPF
- [ ] Use DNS from registrar

**E-Mail**

Select "Detect configuration (recommended)"

Click on "Create" (`Erstellen`) to create the new server. You'll see some information printed to the site, copy the Server Info Block into the original Call-Tracker Entry.
```txt
+===================================+
| New Account Info                  |
+===================================+
| Domain: example-shop.de
| Ip: XXX.XXX.XXX.XXX (n)
| HasCgi: n
| UserName: hereIsTheUserName
| PassWord: hereIsThePassword
| CpanelMod: paper_lantern
| HomeRoot: /home
| Quota: 100 GB
| NameServer1: ns1.speedserver.agency
| NameServer2: ns2.speedserver.agency
| NameServer3: ns3.speedserver.agency
| NameServer4:
| Contact Email: your-user@host.com
| Package: synoa_Cloud M
| Feature List: default
| Language: de
+===================================+
```

### Confiure the (real) domain

After setting everything up you can login to the cPanel of the host. If you do not know the URL click "Account overview" in the sidebar to see a list of all accounts. Here you'll find a link to the cPanel.

Login with the username and password previously assigned during creation and click "Addon Domains" (`Add-on Domänen`). Here you can assign a Domain and map it to a specific folder, e.g. `customer.staging.synoa.net` to the server path `home/customer/public_html/customer`. Save and test your configuration by visiting http://customer.staging.synoa.net

### Enable htaccess protection

From the cPanel home screen, click "Directory security" (`Datenschutz für Verzeichnis`). Here you can choose a folder from the server and assign a username and password to it. This will create a `passwd` file which holds the `user:password` configuration. To make htaccess protection work add the following to the top of the htaccess file.

```txt
############################################
##
## Protect Access to website

   AuthType Basic
   AuthName "Password Protected Area"
   AuthUserFile "/home/customer/.htpasswds/public_html/stage/passwd"
   Require valid-user

```

Update the `post-receive` hook to pre-pand this block to the htaccess file for staging areas.

### Import SSH Keys

From the cPanel home screen click "SSH Access" (`SSH-Zugriff`). Here you can import the public keys from all developers. You can either take them from the `~/.ssh` directory of an existing server you have access to or ask your colleages to send them in. To grab the public key run the following command.

```sh
$ cat ~/.ssh/id_rsa.pub
```

Click "Manage SSH keys" (`SSH-Schlüssel verwalten`) and then "Import key" (`Schlüssel importieren`). Assign a name to the key and paste the SSH keys into the last text box titled "Paste public key into this field" (`Fügen Sie den öffentlichen Schlüssel in das folgende Textfeld ein`). Click import and the key is imported to the server.

On the SSH overview page you can now manage the keys. Click "manage" (`Verwalten`) and then "autorize". This tells the Server to accept this key for SSH connection. Test your connection with the following command.

```sh
$ ssh user@IP
```
You can find the IP in the server information you copied into the call in the first step. You may get an error message stating your account doesn't allow SSH access. According to our hosting partner this is due to a bug in cPanel. Notify your PM and they will reach out to the hosting partner.
