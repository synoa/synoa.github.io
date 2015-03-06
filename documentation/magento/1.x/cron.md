# Cronjob in Magento

## Cronjobs in Magento

There are several cron jobs in magento:

### Reports

cronjob|standard time|file
---|---|---
aggregate_sales_report_bestsellers_data|0 0 \* \* \*|sales/observer::aggregateSalesReportBestsellersData
aggregate_sales_report_coupons_data|0 0 \* \* \*|salesrule/observer::aggregateSalesReportCouponsData
aggregate_sales_report_invoiced_data|0 0 \* \* \*|sales/observer::aggregateSalesReportInvoicedData
aggregate_sales_report_order_data|0 0 \* \* \*|sales/observer::aggregateSalesReportOrderData
aggregate_sales_report_refunded_data|0 0 \* \* \*|sales/observer::aggregateSalesReportRefundedData
aggregate_sales_report_shipment_data|0 0 \* \* \*|sales/observer::aggregateSalesReportShipmentData
aggregate_sales_report_tax_data|0 0 \* \* \*|tax/observer::aggregateSalesReportTaxData

This cronjobs generate the reports in magento. If the reports are not used you can disable them. If you are using reports you could handle the cronjobs and get performance impacts you should generate the reports time delayed.

### Other cron jobs

#### aoescheduler_heartbeat
* **default cron expression:**<br> \*/5 \* \* \* \*
* **file:**<br>aoe_scheduler/heartbeatTask::run
* **What it does:**<br>This is a heartbeat cronjob of an extension we should use every time. It checks the cronjob settings.
* **Enable or disable:**<br>Enable if extension in use

#### captcha_delete_expired_images
* **default cron expression:**<br>\*/10 \* \* \* \*
* **file:**<br>captcha/observer::deleteExpiredImages
* **What it does:**<br>Removes old captcha images.
* **Enable or disable:**<br>Disable it if CAPTCHAS are not used in project
* **Configuration:**<br>System > Configuration > Advanced > Admin > CAPTCHA

#### captcha_delete_old_attempts
* **default cron expression:**<br>\*/30 \* \* \* \*
* **file:**<br>captcha/observer::deleteOldAttempts
* **What it does:**<br>Removes DB entries of failed captchas
* **Enable or disable:**<br>Can be disabled if CAPTCHAS are not used
* **Configuration:**<br>System > Configuration > Advanced > Admin > CAPTCHA

#### catalog_product_alert
* **default cron expression:**<br>0 0 \* \* \*
* **file:**<br>productalert/observer::process
* **What it does:**<br>sending mails like product is available again or price has changed
* **Enable or disable:**<br>Can be disabled if it is not used
* **Configuration:**<br>System > Configuration > Catalog > Catalog > Product Alerts” *and* “System > Configuration > Catalog > Catalog > Product Alerts Run Settings

#### catalog_product_index_price_reindex_all
* **default cron expression:**<br>0 2 \* \* \*
* **file:**<br>catalog/observer::reindexProductPrices
* **What it does:**<br>reindex the prices for the products
* **Enable or disable:**<br>Enable default - Disable if there are performance issues

#### catalogrule_apply_all
* **default cron expression:**<br>0 1 \* \* \*
* **file:**<br>catalogrule/observer::dailyCatalogUpdate
* **What it does:**<br>Calculates the price changes based on catalog rules. There is a three day interval (yesterday, today, tomorow)
* **Enable or disable:**<br>Enable

#### core_clean_cache
* **default cron expression:**<br>30 2 \* \* \*
* **file:**<br>core/observer::cleanCache
* **What it does:**<br>Removes old cache entries based on used caching technique and settings
* **Enable or disable:**<br>**TODO**

#### core_email_queue_clean_up
* **default cron expression:**<br>0 0 \* \* \*
* **file:**<br>core/email_queue::cleanQueue
* **What it does:**<br>Cleans the queue table maybe. Check code to be sure.
* **Enable or disable:**<br>Enable

#### core_email_queue_send_all
* **default cron expression:**<br>\* \* \* \* \*
* **file:**<br>core/email_queue::send
* **What it does:**<br>Send emails which are queued. (In default it will fetch max 100 e-mails per run)
* **Enable or disable:**<br>Enable

#### currency_rates_update
* **default cron expression:**<br>no default cron expression
* **file:**<br>directory/observer::scheduledUpdateCurrencyRates
* **What it does:**<br>Updates the currency rates
* **Enable or disable:**<br>Disable if not used
* **Configuration:**<br>System > Configuration > General > Currency Setup > Scheduler Import Settings

#### log_clean
* **default cron expression:**<br>no default cron expression
* **file:**<br>log/cron::logClean
* **What it does:**<br>Cleans log DB tables from old entries.
* **Enable or disable:**<br>Enable default. <br><br>**If you need this data you should write own jobs which will make a backup of this data**
* **Configuration:**<br>System > Configuration > Advanced > System > Log Cleaning

#### newsletter_send_all
* **default cron expression:**<br>\*/5 \* \* \* \*
* **file:**<br>newsletter/observer::scheduledSend
* **What it does:**<br>Newsletter will be sent by Magento in a cron job to protect the server that it is not considered as a spam server.**Note: It is hard coded in magento that 20 mails will be sent in one run. Big mail lists will take a while**
* **Enable or disable:**<br>Enable it if this feature should be used in project.<br>**Code changes have to be done if there are many receivers**

#### paypal_fetch_settlement_reports
* **default cron expression:**<br>no default cron expression
* **file:**paypal/observer::fetchReports
* **What it does:**<br>Fetch paypal settlement reports automatically
* **Enable or disable:**<br>Can be disabled if not in use
* **Configuration:**<br>System > Configuration > Sales > Payment Methods > PayPal All-in-One Payment Solutions > PayPal Payments Advanced (Includes Express Checkout) > Required PayPal Settings > Basic Settings <br>**and**<br>PayPal Payments Advanced > Advanced Settings > Settlement Report Settings

#### persistent_clear_expired
* **default cron expression:**<br>0 0 \* \* \*
* **file:**<br>persistent/observer::clearExpiredCronJob
* **What it does:**<br>If persistent cart is enabled this will remove the carts which sessions are expired
* **Enable or disable:**<br>Enable if persisten cart is enabled
* **Configuration:**<br>System > Configuration > Customers > Persistent Shopping Cart

#### sales_clean_quotes
* **default cron expression:**<br>0 0 \* \* \*
* **file:**<br>sales/observer::cleanExpiredQuotes
* **What it does:**<br>Removes Quotes which have led to an order
* **Enable or disable:**<br>**TODO**
* **Configuration:**<br>System > Configuration > Sales > Checkout > Shopping Cart > Quote Lifetime (days)

#### sitemap_generate
* **default cron expression:**<br>0 0 \* \* \*
* **file:**<br>sitemap/observer::scheduledGenerateSitemaps
* **What it does:**<br>Generates the sitemap file for search engines
* **Enable or disable:**<br>depends on project
* **Configuration:**<br>Catalog > Google Sitemap<br>**and**<br>System > Configuration > Catalog > Google Sitemap

#### system_backup
* **default cron expression:**<br>no default cron expression
* **file:**<br>backup/observer::scheduledBackup
* **What it does:**<br>Make backups of db, media folder and/or project files
* **Enable or disable:**<br>Disable if not used
* **Configuration:**<br>System > Configuration > Advanced > System > Scheduled Backup Settings

#### factfinder_scic_queue_processing
* **default cron expression:**<br>\* \* \* \* \*
* **file:**<br>factfinder/observer::processScicOrderQueue
* **What it does:**<br>Send files to fact finder for checkout tracking
* **Enable or disable:**<br>Not sure
* **Configuration:**<br>Nothing found maybe you should check again backend and change this line if you have found something

#### turpentine_crawl_urls
* **default cron expression:**<br>0,10,20,30,40,50 \* \* \* \*
* **file:**<br>turpentine/observer_cron::crawlUrls
* **What it does:**<br>Crawling URLs but not sure, nothing found maybe check code if needed
* **Enable or disable:**<br>Not sure
* **Configuration:**<br>Nothing found maybe you should check again backend and change this line if you have found something

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
|---|---|
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


## Setup cron on server

Set the permissions for `cron.php` and `cron.sh`:

```bash
chmod 644 cron.sh cron.php
```

Add the following job via `crontab -e`:

```bash
*/5 * * * * /bin/sh /pathToMagento/cron.sh
```

### Cron is not working

If you are sure the cron job is added correctly, but nothing is happening, you have to do the following:

* Login to the server via SSH to use the command line
* Execute `which php`, which tells you where php (e.g. `/usr/local/bin/php`) is installed for the current user you used to login to the server
* Edit `cron.sh` and change the following line (+ replace `phpInstallDir` with the path to your php installation)
  
  ```bash
    # Remove this line
    PHP_BIN=`which php`
    
    # Add this line instead
    PHP_BIN=phpInstallDir
  ```

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
