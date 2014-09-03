# How to setup a custom module in Magento

## Short overview

We will create a custom Module named HelloWorld in Magento with following features:

TODO awesome feature list goes here

## Before we begin

Disable your cache on if you are not developing on a live system what you should never do. Every magento developer runs in that situation that their last update is not shown and they spent one hour to find out the website is cached. 

* Go to the cache management overview **System > Cache Management**
* Click **Select all**
* Select in *Actions* on the right the value **disable** and click **Submit**

## Creating the custom module

The code for our customer module goes to *app/code/local* folder which is empty after clean installation of Magento

There are two other folders *core* and *community*. In *core* we can find the magento source code which will be overwritten if we update our magento. So we should not store our code here. In *community* we can find the source code of modules which we downloaded with magento connect.

Imagine somebody has also an idea for an *HelloWorld* module and names it also *HelloWorld*. We will get conflicts if we do not care about namespaces.

Our vendor is *Synoa* so we create an own namespace for it.

Create a directory named **Synoa** in **app/code/local**

Our custom module is called *HelloWorld* to start with it we have to 
create a directory named **HelloWorld** in our new **namespace app/code/local/Synoa**

Every custom module has a folder called *etc* with an *config.xml* file.

* Create a folder **etc** in **app/code/local/Synoa/HelloWorld**
* Create a file **config.xml** in **app/code/local/Synoa/HelloWorld/etc**

Lets start with some code in the *config.xml* 

```xml
<?xml version="1.0"?>
<config>
  <modules>
    <Synoa_HelloWorld>
      <version>0.1.0</version>
    </Synoa_HelloWorld>
  </modules>
</config>
```

This lines describes our custom module. It is called *HelloWorld* in *Synoa* Namespace. The namespace and module name are connected with an underscore and the Autoloading Feature of Zend Framework will know where to find the code. Next we define the version of our custom module.

We succesfully created our first custom module in magento. Needs a little bit more action in next chapters.

## Activate our custom module

Every module has an xml file in *app/etc/modules*. In this place you can also turn off an module if it is not working correctly after an update.

Create an xml file called **Synoa_HelloWorld.xml** in **app/etc/modules** with following content

```xml
<?xml version="1.0"?>
<config>
  <modules>
    <Synoa_HelloWorld>
      <version>0.1.0</version>
      <codePool>local</codePool>
      <active>true</active>
    </Synoa_HelloWorld>
  </modules>
</config>
```

Here we tell Magento to activate our new customer module called *Synoa_HelloWorld* in the version 0.1.0. We have to tell magento where to find the code. Remember we have three code pools:

* core
* community
* local

We set the codepool to *local* and an *active* tag with the value *true*

Now Our custom component is visible in Magento. Login in the backend of our magento store and click on the *system* tab. At the bottom you will find the section *Advanced* and an *Advanced* overview. There you can find all Modules which have an active tag with the value true. And also our custom Module Synoa_HelloWorld.

## Add some action to our custom module

To see some Action, our custom module should display *Hello magento* if we call the url http://&lt;magento&gt;/helloworld. Replace &lt;magento&gt; with your magento installation.

First we have to define the route *http://&lt;magento&gt;/helloworld* which is calling our module

We expand our app/code/local/Synoa/etc/config.xml with a route
```xml
<?xml version="1.0"?>
<config>
  <modules>
    <Synoa_HelloWorld>
      <version>0.1.0</version>
    </Synoa_HelloWorld>
  </modules>
  <!-- new code begin -->
  <frontend>
    <routers>
      <helloworld>
        <use>standard</use>
        <args>
          <module>Synoa_HelloWorld</module>
          <frontName>helloworld</frontName>
        </args>
      </helloworld>
    </routers>
  </frontend>
  <!-- new code end -->
</config>
```
### Explanation of the new tags

<dl>
  <dt>frontend</dt>
  <dd>There are three diffenterent magento areas (frontend, admin and install). Our route map to the frontend.</dd>
  <dt>routers</dt>
  <dd>In this tag we place all our routes</dd>
  <dt>synoa_helloworld</dt>
  <dd>This is the name of our route (TODO is it better to set the namespace also in the name of the route like synoa_helloworld?)</dd>
  <dt>use</dt>
  <dd>TODO</dd>
  <dt>args</dt>
  <dd>TODO</dd>
  <dt>module</dt>
  <dd>This tag define which module should be used</dd>
  <dt>frontname</dt>
  <dd>this is the path of the url after http://&lt;magento&gt;/</dd>
</dl>

Now we mapped the route */helloworld* to our module Synoa_HelloWorld.

### Notes about Routing

If you call *http://&lt;magento&gt;/route* magento will internally handle it like you requested *http://&lt;magento&gt;/route/index/index* The */index/index* thing will load the Index Controller and execute the index action method. That is an new file we need. An Index Controller with and index action method.

## Controllers

The route maps to our module and will call the Index Controller but it is not available yet. Lets create it in **app/code/local/Synoa/controllers** and name the file **IndexController.php** with following code:

```php
<?php
class Synoa_HelloWorld_IndexController extends Mage_Core_Controller_Front_Action {
  
  /**
   * Prints "Hello magento"
   * @return void
   */
  public function indexAction() {
    echo 'Hello magento';
  }
}
?>
```

Magento needs to autoload this class and todo this the classname follows an naming convention: *Namespace_ModuleName_ControllerName*. We extend Mage_Core_Controller_Front_Action to inherit functions for laoyut and templating. We will dive into that later. For now we just want to print "Hello magento". Second we need a function named *indexAction* which echoes *Hello magento*. Simple.

Request with your browser **http://&lt;magento&gt;/helloworld** and you should see *Hello magento*. Great.

TODO some infos more about routing and the index/index thing maybe another controller or multiple actions

### Helpers

Lets write an helper class with a function *upper* which takes a string and returns this string in uppercase. We know there is a PHP function for this use case, but it is a simple example.

First we create a new folder named **Helper** in **app/code/local/Synoa/HelloWorld**

In this folder we create a file **Data.php**

```php
<?php
class Synoa_HelloWorld_Helper_Data extends Mage_Core_Helper_Abstract {
  /**
   * Returns the first param in uppercase
   * @param  String $str
   * @return String
   */
  public function upper($str) {
    return strtoupper($str);
  }
}
?>
```

Okay now we will use this helper in our IndexController to print *HELLO MAGENTO*. 

We change the code of **app/code/local/Synoa/HelloWorld/controllers/IndexController.php** to

```php
<?php
class Synoa_HelloWorld_IndexController extends Mage_Core_Controller_Front_Action {
  
  /**
   * Prints "Hello magento"
   * @return void
   */
  public function indexAction() {
    // echo 'Hello magento';
    echo Mage::helper('helloworld')->upper('Hello Magento');
  }
}
?>
```

If we request now *http://&gt;magento&lt;/helloworld* we should see "HELLO MAGENTO";