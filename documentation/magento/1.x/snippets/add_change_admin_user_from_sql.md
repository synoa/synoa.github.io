To add or change an admin user directly from SQL you can use the following SQL commands.

### Change admin Password
```sql
  UPDATE admin_user SET password=CONCAT(MD5('qXpassword'), ':qX') WHERE username='admin'
```
Change `qX` and `password`  to whatever should be the new password. 

### Add new admin user
There's a handy [tool available](http://m4tt.io/tools/magento-admin-generator/) to generate the SQL command for adding
new users to the `admin_user` table. Select the Version of Magento and you should be good to go. (Tested with Magento
1.9)
