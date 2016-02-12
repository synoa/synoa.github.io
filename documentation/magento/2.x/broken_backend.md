# Fix broken backend

As of Magento 2.0.2 it appears that the less Compilation settings are kind of
broken. When switching from "Server side less compilation" to "Client side less
compilation" the backend can be broken - either just visually or entirely (See
[Issue #3325](https://github.com/magento/magento2/issues/3325)).

When visually broken there is currently no fix other than switching back to
Server side compilation. When everything is broken and no styles are loaded,
however, there is only one way to fix it. 

Login to the broken backend and Navigate to `Stores -> Configuration`. Once the
page has reloaded stop the browser from finishing the page. Otherwise parts of
the JavaScript will be executed and remove the sidebar menu. Locate the Link to
"Developers" and click it. Now you should see a broken Developer Setting Screen
where the first point is "Workflow type". Change the Select to "Server side less
compilation" and open the Developer Tools (`F12` or `CTRL + I`). In the console
tab enter the following and hit enter.

```js
document.getElementById('config-edit-form').submit();
```

This will submit the form and save the configuration. Hitting the "Save Config"
Button won't do anything because the JavaScript needed for it is not executed
due to the Issues with the Less Compilation. 

The Backend should look normal now, but you might need to clear caches anyway.
Execute the following from the Magento Root directory.

```bash
$ ./bin/magento cache:clean && ./bin/magento cache:flush
```
