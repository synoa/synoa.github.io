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
