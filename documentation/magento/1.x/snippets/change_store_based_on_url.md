Use this if you want to change the store based on the current URL. 

* **[ 1 ]** Open `index.php`
* **[ 2 ]** Replace everything after `umask(0);` with this:
```php
/*
 * Start Magento using the provided <CODE>$code</CODE> and <CODE>$type</CODE>. 
 *
 * @parameter String $code
 * @parameter String $type
 */
function _start($code, $type) {
  Mage::run($code, $type);
}

// Call the _start() function in dependence on the current URL.
switch($_SERVER['HTTP_HOST']) {
  // Description
  case 'page.tld' : 
  case 'www.page.tld' : 
    _start('store_code', 'store');
    break;

  // Use the base website if nothing matches
  default : 
    _start('base', 'website');
    break;
}
```
* **[ 3 ]** Replace `description` with a short description of the store, replace `page.tld` with the URL you want and replace `store_code` with the code of the store you want to start. 
