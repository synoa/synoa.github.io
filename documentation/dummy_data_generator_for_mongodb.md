* Open Studio 3T
* Select your database / collection
* Open IntelliShell
* Copy / pase the following code and execute it

```javascript

var collection = db.bettmer;

collection.remove({});


var amount_articles = 50000;
var amount_prices = 115;
var amount_attributes = 15;
var price_min = 1;
var price_max = 1000;
var attribute_value_max = 20;

function randomFloat(min, max) {
  return (Math.random() * (max - min) + min).toFixed(2);
}

function randomString(max) {
  var text = "";
  var possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

  for(var i = 0; i <= max; i++) {
    text += possible.charAt(Math.floor(Math.random() * possible.length));
  }

  return text;
}


for(var i = 0; i <= amount_articles; i++) {
  var article = {};
  
  for(var j = 0; j <= amount_prices; j++) {
    article["price" + j] = randomFloat(price_min, price_max);
  }
  
  for(var j = 0; j <= amount_attributes; j++) {
    article["attribute" + j] = randomString(attribute_value_max);
  }
  
  collection.insert(article);
}



```
