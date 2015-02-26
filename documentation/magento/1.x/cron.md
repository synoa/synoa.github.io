# Cronjob in Magento

## Table Test

key1 | key2 | key3
- | - | -
value | value | value
value | value | value
value | value | value

key1|key2|key3
-|-|-
value|value|value
value|value|value
value|value|value

key1|key2|key3
-----|------|----
value|value|value
value|value|value
value|value|value

key1 | key2 | key3
-|-|-
value|value|value
value|value|value
value|value|value

key1 | key2 | key3
 - | - | - 
value|value|value
value|value|value
value|value|value

key1 | key2 | key3
 --- | --- | --- 
value|value|value
value|value|value
value|value|value

key1 | key2 | key3
 --- | ---- | --- 
value|value |value
value|value |value
value|value |value

## Cronjobs in Magento

There are several cron jobs in magento:

### Reports

cronjob|standard time|file
-|-|-
aggregate_sales_report_bestsellers_data|0 0 \* \* \*|sales/observer::aggregateSalesReportBestsellersData
aggregate_sales_report_coupons_data|0 0 \* \* \*|salesrule/observer::aggregateSalesReportCouponsData
aggregate_sales_report_invoiced_data|0 0 \* \* \*|sales/observer::aggregateSalesReportInvoicedData
aggregate_sales_report_order_data|0 0 \* \* \*|sales/observer::aggregateSalesReportOrderData
aggregate_sales_report_refunded_data|0 0 \* \* \*|sales/observer::aggregateSalesReportRefundedData
aggregate_sales_report_shipment_data|0 0 \* \* \*|sales/observer::aggregateSalesReportShipmentData
aggregate_sales_report_tax_data|0 0 \* \* \*|tax/observer::aggregateSalesReportTaxData

This cronjobs generate the reports in magento. If the reports are not used you can disable them. If you are using reports you could handle the cronjobs and get performance impacts you should generate the reports time delayed.

### Other cron jobs

|cronjob|standard time|file|what it does|enable or disable|configuration|
|-|
|aoescheduler_heartbeat|\*/5 \* \* \* \*|aoe_scheduler/heartbeatTask::run|This is a heartbeat cronjob of an extension we should use every time. It checks the cronjob settings.|Enable if extension in use|
|captcha_delete_expired_images|\*/10 \* \* \* \*|captcha/observer::deleteExpiredImages|Removes old captcha images.|Disable it if CAPTCHAS are not used in project|System > Configuration > Advanced > Admin > CAPTCHA|
|captcha_delete_old_attempts|\*/30 \* \* \* \*|captcha/observer::deleteOldAttempts|Removes DB entries of failed captchas|Can be disabled if CAPTCHAS are not used|System > Configuration > Advanced > Admin > CAPTCHA|
|catalog_product_alert|0 0 \* \* \*|productalert/observer::process|sending mails like product is available again or price has changed|Can be disabled if it is not used|System > Configuration > Catalog > Catalog > Product Alerts” *and* “System > Configuration > Catalog > Catalog > Product Alerts Run Settings|
|catalog_product_index_price_reindex_all|0 2 \* \* \*|catalog/observer::reindexProductPrices|reindex the prices for the products|Enable default - Disable if there are performance issues|
|catalogrule_apply_all|0 1 \* \* \*|catalogrule/observer::dailyCatalogUpdate|Calculates the price changes based on catalog rules. There is a three day interval (yesterday, today, tomorow)|Enable
|core_clean_cache|30 2 \* \* \*|core/observer::cleanCache|Removes old cache entries based on used caching technique and settings|
|core_email_queue_clean_up|0 0 \* \* \*|core/email_queue::cleanQueue|
|core_email_queue_send_all|\*/1 \* \* \* \*|core/email_queue::send|
|currency_rates_update| |directory/observer::scheduledUpdateCurrencyRates|Updates the currency rates|Disable if not used|System > Configuration > General > Currency Setup > Scheduler Import Settings|
|log_clean| |log/cron::logClean|Cleans log DB tables from old entries.|Enable default. <br><br>**If you need this data you should write own jobs which will make a backup of this data**|System > Configuration > Advanced > System > Log Cleaning|
|newsletter_send_all|\*/5 \* \* \* \*|newsletter/observer::scheduledSend|Newsletter will be sent by Magento in a cron job to protect the server that it is not considered as a spam server. <br><br>**Note: It is hard coded in magento that 20 mails will be sent in one run. Big mail lists will take a while**|Enable it if this feature should be used in project.<br><br>**Code changes have to be done if there are many receivers**|
|paypal_fetch_settlement_reports| |paypal/observer::fetchReports|Fetch paypal settlement reports automatically|Can be disabled if not in use|System > Configuration > Sales > Payment Methods > PayPal All-in-One Payment Solutions > PayPal Payments Advanced (Includes Express Checkout) > Required PayPal Settings > Basic Settings – PayPal Payments Advanced > Advanced Settings > Settlement Report Settings|
|persistent_clear_expired|0 0 \* \* \*|persistent/observer::clearExpiredCronJob|If persistent cart is enabled this will remove the carts which sessions are expired|Enable if persisten cart is enabled|System > Configuration > Customers > Persistent Shopping Cart
|sales_clean_quotes|0 0 \* \* \*|sales/observer::cleanExpiredQuotes|Removes Quotes which have led to an order|**TODO**|System > Configuration > Sales > Checkout > Shopping Cart > Quote Lifetime (days)
|sitemap_generate|0 0 \* \* \*|sitemap/observer::scheduledGenerateSitemaps|Generates the sitemap file for search engines|depends on project|Catalog > Google Sitemap *and* System > Configuration > Catalog > Google Sitemap|
|system_backup| |backup/observer::scheduledBackup|Make backups of db, media folder and/or project files|Disable if not used|System > Configuration > Advanced > System > Scheduled Backup Settings

## What means the stars

```
* * * * *  command to execute
│ │ │ │ │
│ │ │ │ │
│ │ │ │ └───── day of week (0 - 6) (0 to 6 are Sunday to Saturday, or use names; 7 is Sunday, the same as 0)
│ │ │ └────────── month (1 - 12)
│ │ └─────────────── day of month (1 - 31)
│ └──────────────────── hour (0 - 23)
└───────────────────────── min (0 - 59)
```

### Examples

|value|result|
|-|
|0 0 \* \* \*|daily|
|0 0 \* \* \*|midnight|
|0 \* \* \* \*|hourly|
|0 0 \* \* 0|weekly|
|0 0 1 \* \*|monthly|
|0 0 1 1 \*|yearly|

## Setup cron in local development

### Make it executable

Check that the **cron.sh** file is executable for your user in magento root folder

```bash
ls -ahl
```

should show

```bash
...
-rwxr--r--  1 user  user   717 Feb 26 14:36 cron.sh
...
```
If not executable make it with

```bash
chmod 744 cron.sh
```

### Setting up a cron

Edit your crontab

```bash
crontab -e
```

This opens your default editor on command line editor

add following line to the end:

```bash
*/5 * * * * /pathToMagento/cron.sh
```
This line calls the cron.sh file every 5 minutes.

**Note: Make sure there is a new line at the end of the file**

Exit editor and save the file

## Recommended Extensions

### Aoe_Scheduler

source: https://github.com/AOEpeople/Aoe_Scheduler

#### Features:
* Allow to enable/disable crons in backend
* Shows nice schedule list
* Shows a nice timeline with status of crons

### Aoe_QuoteCleaner

source: https://github.com/AOEpeople/Aoe_QuoteCleaner

#### Feature
* Removes old carts and quotes regardless of whether they have led to an order or not.

## Extension which could be interesting

### Aoe_AsyncCache

https://github.com/AOEpeople/Aoe_AsyncCache
