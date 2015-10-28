# DB Transactions

I you have multiple SQL Statements and need a rollback if one fails

```php
$connection = Mage::getSingleton('core/resource')->getConnection('core_write');
try {
    $connection->beginTransaction();

    // Make saves and other actions that affect the database

    $connection->commit();
} catch (Exception $e) {
    $connection->rollback();
}
```
