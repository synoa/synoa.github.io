# How to disable cache for specific block

You can disable caching for an block in xml with

```xml
<block type="page/html_topmenu" name="catalog.topnav" template="page/html/topmenu.phtml">
	<action method="setCacheLifetime"></action>
</block>
```
for more info see
http://fbrnc.net/blog/2015/06/cache-and-layout-xml-tricks
