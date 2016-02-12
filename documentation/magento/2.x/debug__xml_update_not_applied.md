# Debugging: XML Update shows no effect

It might happen that an XML update, for example inside `2columns-left.xml` shows
no effect on the Front-End. In Magento 1.x this was either related to Cache
Issues, Wrong XML Nesting or invalid XML. In Magento 2.x, these issues are now
logged to the `system.log` inside `<magento_root>/var/log/system.log`. 

When developing Templates it is quite helpful to keep this look open with `tail`
([tail man page](http://man7.org/linux/man-pages/man1/tail.1.html)) so it shows
all issues related to XML configuration.

```bash
$ tail -f var/log/system.log
```
Example output: 
```txt
[2016-02-12 09:39:17] main.CRITICAL: Broken reference: the 'div.sidebar.main' tries to reorder itself towards 'main', but their parents are different: 'main.content' and 'columns' respectively. [] []

[2016-02-12 09:36:31] main.INFO: Theme layout update file 'app/design/frontend/Vendor/theme/Magento_Theme/page_layout/2columns-left.xml' is not valid. Double hyphen within comment: <!--  <referenceContainer name="page.main" htmlClass=" Line: 10 [] []
```

While still being rather cryptic this log can help a lot finding invalid XML or
logical issues within the construction of pages (see the first example: `Broken
reference: the 'div.sidebar.main' tries to reorder i    tself towards 'main',
but their parents are different: 'main.content' and 'columns' respectively`).

