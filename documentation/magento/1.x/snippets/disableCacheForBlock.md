# How to disable cache for specific block

You can disable caching for an block in xml with

```xml
<block type="page/html_topmenu" name="catalog.topnav" template="page/html/topmenu.phtml">
	<action method="unsetData"><key>cache_lifetime</key></action>
</block>
```