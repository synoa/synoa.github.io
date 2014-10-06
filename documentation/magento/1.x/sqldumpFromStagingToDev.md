# Database from Staging to Development

## Backups first

- [ ] Create an sql dump from your development database
- [ ] Create an sql dump from your staging database

## Import

We will replace all data in the development database with staging

- [ ] Drop all tables in development database
- [ ] Import SQL Dump to developmnt database

## Set base URL in development magento

All changes are made in table **core_config_data**

- [ ] Change the value to your development base url where column **path** is **web/unsecure/base_url**
- [ ] Change the value to your development base url where column **path** is **web/secure/base_url**

## Login in Backend and change following Options

- [ ] System -> Cache Management -> Select All -> Disable -> Submit
- [ ] System -> Configuration -> Developer -> Template Settings -> Allow Symlinks = **yes** (needed for templates with modman)
- [ ] System -> Configuration -> Developer -> Log Settings -> Enabled = **Yes**

## Optional

If you have multiple store views (mostly you will have)

- [ ] Check base URL for every single store view
- [ ] System->Configuration->Debug->Template Path Hints for prefered store view
- [ ] System->configuration->Debug->Add Block Names to Hints for prefered store view