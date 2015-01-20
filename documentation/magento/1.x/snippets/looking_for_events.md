# What events are triggered

If you want to know which events are triggered in a request you can add a line to *app/code/Mage.php* in function *dispatchEvent*

```php
public static function dispatchEvent($name, array $data = array())
{
    // remove me when done
    Mage::log($name, null, 'events.log', true);

    Varien_Profiler::start('DISPATCH EVENT:'.$name);
    $result = self::app()->dispatchEvent($name, $data);
    Varien_Profiler::stop('DISPATCH EVENT:'.$name);
    return $result;
}
```

Proceed your request and have a look in *var/log/events.log*

Example *events.log*

```
2014-10-02T08:26:12+00:00 DEBUG (7): core_locale_set_locale
2014-10-02T08:26:12+00:00 DEBUG (7): resource_get_tablename
2014-10-02T08:26:12+00:00 DEBUG (7): controller_action_predispatch
2014-10-02T08:26:12+00:00 DEBUG (7): customer_session_init
2014-10-02T08:26:12+00:00 DEBUG (7): controller_action_predispatch_cms
2014-10-02T08:26:12+00:00 DEBUG (7): controller_action_predispatch_cms_index_index
2014-10-02T08:26:12+00:00 DEBUG (7): model_load_before
2014-10-02T08:26:12+00:00 DEBUG (7): cms_page_load_before
2014-10-02T08:26:12+00:00 DEBUG (7): resource_get_tablename
2014-10-02T08:26:12+00:00 DEBUG (7): resource_get_tablename
2014-10-02T08:26:12+00:00 DEBUG (7): model_load_after
2014-10-02T08:26:12+00:00 DEBUG (7): cms_page_load_after
2014-10-02T08:26:12+00:00 DEBUG (7): cms_page_render
```