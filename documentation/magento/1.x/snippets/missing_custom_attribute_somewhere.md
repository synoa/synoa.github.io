# Missing custom attribute

If you are missing an custom attribute, e. g. custom product attribute in checkout/cart try something like this

During the checkout process we have to deal with quotes, so our goal is to add an attribute to the list of attributes that are loading with quote object.

In *etc/config.xml*:

```xml
<global>
    <sales>
        <quote>
            <item>
                <product_attributes>
                    <attribute1 />
                    <attribute2 />
                </product_attributes>
            </item>
        </quote>
    </sales>
</global>
```

In your code: 

```php
$item->getData('attribute1');
//if you use observer or quote object:
$item->getProduct()->getData('attribute1');
```