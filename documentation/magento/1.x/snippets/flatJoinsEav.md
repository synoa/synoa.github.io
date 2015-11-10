# Flat Table joins EAV Table

So maybe you have a flat table in your custom module with an foreign key `product_id` to magento products and want some product data in your collection.

```php
// File: app/code/<codepool>/<vendor>/<modulename>/Model/Resource/<modelName>/Collection.php

public function addProductData()
    {
    	// alias then field name
    	$productAttributes = array('product_name' => 'name', 'product_price' => 'price', 'product_url_key' => 'url_key');
    	foreach ($productAttributes as $alias => $attributeCode) {
    		$tableAlias = $attributeCode . '_table';
    		$attribute = Mage::getSingleton('eav/config')
    		->getAttribute(Mage_Catalog_Model_Product::ENTITY, $attributeCode);
 
    		//Add eav attribute value
    		$this->getSelect()->joinLeft(
    				array($tableAlias => $attribute->getBackendTable()),
    				"main_table.product_id = $tableAlias.entity_id AND $tableAlias.attribute_id={$attribute->getId()}",
    				array($alias => 'value')
    		);
    	}
 
    	return $this;
    }
```
