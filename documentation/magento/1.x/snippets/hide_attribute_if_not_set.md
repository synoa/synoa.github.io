# Hide attribute if not set

## Problem example

Example: We have two products A and B and three attributes:

* chipSize (textfield)
* system (multi select)
* wdr (select)

Product A has this attributes but none attribute are set to an value

Product B has this attributes and all attributes are set

We have several ways to get the value

```php
var_dump($_product->getData('chip_size'));
var_dump($_product->getChip_size());
var_dump($_product->getResource()->getAttribute('chip_size')->getFrontend()->getValue($_product));

var_dump($_product->getData('system'));
var_dump($_product->getSystem());
var_dump($_product->getResource()->getAttribute('system')->getFrontend()->getValue($_product));

var_dump($_product->getData('system'));
var_dump($_product->getSystem());
var_dump($_product->getResource()->getAttribute('system')->getFrontend()->getValue($_product));
```

### Product A

If we check Product A we will see interesting values

```php
null
null
null

null
null
boolean false

null
null
string 'No' (length=4)
```

### Product B

```php
string ' mini' (length=5)
string ' mini' (length=5)
string ' mini' (length=5)

string '4,3' (length=3)
string '4,3' (length=3)
string 'Farbe, Tag/Nacht' (length=16)

string '5' (length=1)
string '5' (length=1)
string 'Ja' (length=2)
```

## Interesting Facts

If we use getData() on multiple selects we get the index of the options as value (see values on product B). So we have to use the other method. But this delivers value "No" for normal selects (see values on Product A).

## Problem

We should use the getFrontend()->getValue() Method but this delivers "No" for normal select fields if the value is not set. Maybe our Select Field has the options Yes/No. We can not say if the value is set to No or it is not set. If we want to hide the values in frontend which are not set this is a real problem.

## Solution

Check first getData() and get the frontend value afterwards.

```php
// check if data is not null
if ($_product->getData('attributeName') !== null) {
  // get the frontend value
  $value = $_product->getResource()->getAttribute('attributeName')->getFrontend()->getValue($_product);
}
```
