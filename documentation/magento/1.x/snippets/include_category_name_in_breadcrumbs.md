
# Add Category Names to Breadcrumbs

This snippet loads the current category and adds it to the breadcrumbs. It was taken from [this forum thread](http://www.kavoir.com/backyard/showthread.php?170-Add-categories-in-breadcrumbs-on-product-pages-in-Magento).
The code needs to be placed above-everything in the breadcrumbs layout file `app/design/frontend/[Namespace]/[Theme]/template/page/html/breadcrumbs.phtml`.

**Comments inside the code where added by myself (Kevin Gimbel). Feel free to change/correct them.**

```php
<?php

// First of all we need to check if there is a current product in the global Magento "Register". 
if ($product = Mage::registry('current_product')) {
    // if so, we can use the getCCategoryCollection on the product to get all its categories
    $categories = $product->getCategoryCollection()->load();

    // next, if there are any categories...
    if($categories) {
        // ... we loop through them...
        foreach ($categories as $category)
        {
            if($category) {
            // and load the category by ID.
            $category = Mage::getModel('catalog/category')->load($category->getId());
            break;
            }
        }
    }
    // the last crumb will be the product name
    $lastCrumbName = $product->getName();
    $lastCategoryAdjust = 0;
}
// if there's no product registered within the Magento Registry, we try to load the current category,
// assuming that we're on a category page.
else {
    // get the current category from the registry
    if($category = Mage::registry('current_category')) {
    // and assign the categoy name as last crumb
    $lastCrumbName = $category->getName();
    }
    $lastCategoryAdjust = 1;
}

if($category) {
    // $category->getPath() return the (frontend) path to the category
    if($path = $category->getPath()) {
        $path = explode('/', $path); // remove all / from the path
        $crumbs = array('home' => array('label' => 'Startseite',
        'title' => 'Startseite',
        'link' => Mage::getBaseUrl(Mage_Core_Model_Store::URL_TYPE_WEB),
        'first' => true,
        'last' => false
        ));
        // next, we loop through the available crumb-names, either category or category & product and assign them
        // to individual crumbs
        for($i = 2; $i < count($path) - $lastCategoryAdjust; $i++) {
            $cur_category = Mage::getModel('catalog/category')->load($path[$i]);
            if($cur_category && $cur_category->getIsActive()) {
                $crumbs['category' . $path[$i]] = array('label' => $cur_category->getName(),
                'title' => $cur_category->getName(),
                'link' => $cur_category->getUrl(),
                'first' => false,
                'last' => false
                );
            }
        }
        // lastly, the last and "current" crumb is assigned to whatever is stored in $lastCrumbName at that point.
        $crumbs['current'] = array('label' => $lastCrumbName,
        'title' => '',
        'link' => '',
        'first' => false,
        'last' => true
        );
    }
}
?>
```