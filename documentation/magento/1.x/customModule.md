This file is still in development and not tested!!!

# How to setup a custom module in Magento

## Short overview

We will create a custom Module named HelloWorld in Magento with following features:

TODO awesome feature list goes here

## Before we begin

Disable your cache on if you are not developing on a live system what you should never do. Every magento developer runs in that situation that their last update is not shown and they spent one hour to find out the website is cached. 

* Go to the cache management overview **System > Cache Management**
* Click **Select all**
* Select in *Actions* on the right the value **disable** and click **Submit**

If you are developing you should also enable the *developer mode* and *display error messages* in browser.

First we will activate the developer mode for magento.

Add following to the end of the **.htaccess** in your document root folder:

```
############################################
## Enable magento developer mode
SetEnv MAGE_IS_DEVELOPER_MODE true
```

To display error messages remove the **#** in the index.php of the document root folder to uncomment following line

```php
ini_set('display_errors', 1);
```

## Setup a custom module

### File Structure of an magento module

The code of magento and his extensions is stored in *app/code*. There are three different folders:

* core
* community
* local

#### core

In the *core* folder is all the code of magento and we will not touch it, because it will be maybe overwritten with next update and then our custom changes are gone.

#### community 

You can download extensions with magento connect. The code of this extensions will be stored in this folder.

#### local

This is the place for our code. It should be empty afer an clean installation of magento.

### Create the module

A moudule needs a name and a namespace to avoid naming conflicts with other modules which has the same name.

Mostly you will take the name of your company as namespace. Our namespace will be *Synoa*.

Create a directory **Synoa** in **app/code/local**.

The name of our custom module will be *HelloWorld* so we have to create a folder **HelloWorld** in **app/code/local/Synoa**.

Every module needs an *config.xml* in which we configure many things like Controllers, Helpers, Layouts and so on. This file is stored in an *etc* folder and will be autoloaded by magento after we activated the module.

* Create a folder **etc** in **app/code/local/Synoa/HelloWorld/**
* Create a file **config.xml** in **app/code/local/Synoa/HelloWorld/etc**

In the first step we will create a module with no actions and add follwing code to the **app/code/local/Synoa/HelloWorld/etc/config.xml**

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

This code is the minimum of an custom module. We define where the code lives with the line *Synoa_HelloWorld*. Magento is build up on the Zend Framework and with *Synoa_HelloWorld* the Autoloader internally replaces the **_** with an directory seperator depending on which os you are. On Unix system it will be **/**. The autoloader tries to load the code from *Synoa/HelloWorld* in all defined include paths. Finally we define a version for our module.

### Activate our custom module

Every module has an xml file in *app/etc/modules*. The name of the xml file follows the naming convention *namespace_modulname*. 

Create **Synoa_HelloWorld.xml** in **app/etc/modules** with following content:

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

Magento will parse all xml files and read the config for our custom module which has the version *0.1.0*. The code can be found in the codepool *local* and we activate the module with the *active* tag. If we set the *active* tag to *false* our module would not be loaded.

Now Our custom component is visible in Magento. Login in the backend of our magento store and click on the *system* tab. At the bottom you will find the section *Advanced* and an *Advanced* overview. There you can find all Modules which have an active tag with the value true. And also our custom Module Synoa_HelloWorld.

### Disable an module

If an module in production environment is not working correctly we can disable it until we fixed the bug. In the **app/etc/modules** folder we will find an xml file for every module. Open the xml file of the module which you want to disable and set the *active* tag to *false*, clear your cache and the moudle will be disabled.

## Setting up an controller

The first simple action for our custom module: it should display *hello magento* in our browser. We will achive that with simple PHP Code which is placed in a controller class. I recommend to read about the MVC pattern on which Magento is build up.

All controllers are placed in the *controllers* folder in our module folder. 

Create a folder **controllers** in **app/code/local/Synoa/HelloWorld**
Create a file **IndexController.php** in **app/code/local/Synoa/HelloWorld/controllers** with following content:

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

The class name follows the naming convention for Zend Autoloading *namespace_modulname_controllername**Controller***. The classname ends always with **Controller**. We extend *Mage_Core_Controller_Front_Action* to inherit some functions which will be needed later on. 

We also define a public function *indexAction* which echoes *Hello magento*. To run this code we have to setup an route which leads to this simple PHP code and executes it. 

**Note: You should never output directly like in this example. Remember principle filter input and escape output. But we want to show a fast way to see some action and expand this exmaple later with the correct way.**

## Setting up an Route 

### Basics about routing

A route is a mapping between an URL and an module. If we call http://&lt;magento&gt;/helloworld magento (replace &lt;magento&gt; with your magento installation) looks in all module configurations if a route maps to an specific module. So far we have no route defined and if we request http://&lt;magento&gt;/helloworld we get a 404 Not Found page. 

### Magento Areas

There are three different Magento areas:

<dl>
  <dt>frontend</dt>
  <dd>The customer view of the magento store</dd>
  <dt>admin</dt>
  <dd>The backend of the magento store</dd>
  <dt>install</dt>
  <dd>The installation routine you done when you setup your magento instllation</dd>
</dl>

When we define a route we also have to map to a specific magento area

### Creating the route

Lets expand our **app/code/local/Synoa/HelloWorld/etc/config.xml** with

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
  <dd>Our route will map to the frontend.</dd>
  <dt>routers</dt>
  <dd>In this tag we place all our routes for the frontend magento area</dd>
  <dt>synoa_helloworld</dt>
  <dd>This is the name of our route (TODO is it better to set the namespace also in the name of the route like synoa_helloworld?)</dd>
  <dt>use</dt>
  <dd>TODO</dd>
  <dt>args</dt>
  <dd>TODO</dd>
  <dt>module</dt>
  <dd>This tag define which module should be mapped</dd>
  <dt>frontname</dt>
  <dd>this is the path of the url after http://&lt;magento&gt;/</dd>
</dl>

Now we mapped the route */helloworld* to our module Synoa_HelloWorld and if we call http://&lt;magento&gt;/helloworld we should see *Hello magento*.

### How this works?

If you request *http://&lt;magento&gt;/helloworld* magento will expand this URL to *http://&lt;magento&gt;/helloworld/index/index*. Lets have a closer look at this URL. It consists of 4 parts

http://**domain**/**route**/**controller**/**action**

1. Magento will look for an route with the value *helloworld* in the frontname tag. We defined it in *app/code/local/Synoa/HelloWorld/etc/config.xml*
2. Magento will look for an IndexController in our module folder app/code/local/Synoa/HelloWorld/controllers and yeah we have one.
3. Magento will call the indexAction method of the controller class.

So what happens if we call *http://&lt;magento&gt;/helloworld/index/goodbye*? We will get an 404 page because there is no *goodbyeAction* method in our *app/code/local/Synoa/HelloWorld/controllers/IndexController.php*

Lets expand it and add some code to the IndexController:

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

  ##### new code begin #####
  
  /**
   * Prints "Goodbye magento"
   * @return void
   */
  public function goodbyeAction() {
    echo 'Goodbye magento';
  }

  ##### new code end #####
}
?>
```

Now if you request *http://&lt;magento&gt;/helloworld/index/goodbye* you should see *Goodbye Magento*. 

If you change the third part of the URL (the controller) you have to create new controller. 

Example if you request *http://&lt;magento&gt;/helloworld/other/awesome* magento will look in *app/code/local/Synoa/HelloWorld/controllers/OtherController.php* for an *awesomeAction* method.

## Setup Layout and Templates

Our module outpouts *Hello magento* to a blank site with no structure and it outputs the message directly with echo. In the next steps we will see how we can render the message in the store website. 

### Basics

The layout and template is very complex and you need a little bit practice to achieve your goals. Lets have a look at some basic informations about layouts and templates.

#### Blocks

We can seperate every HTML page into several blocks like Header, Sidebar, Main, Footer and so on. But we can also seperate an component like an detail view of an product to several blocks like name, description, image, sizes and so on. An block can consists of several other nested blocks. This blocks are defined in a layout file which will be loaded and rendered from an controller. Blocks can be seen as little controllers which appeals templates with the data of the model. Templates should never contain any business logic.

#### Layouts

With layouts you can position your blocks on the right place. Layout XML files are stored in *app/design/&lt;magento area&gt;/&gt;package&lt;/&gt;theme&gt;/layout*. Every module may define its own layout.

An basic layout file starts with the *layout* tag and the first childs of this tag are called *layout handles*.

Example:

```xml
<layout version="1.0">
  <default>
    <!-- ... -->
  </default>
  <helloworld_index_index>
    <!-- ... -->
  </helloworld_index_index>
</layout>
```

*default* and *helloworld_index_index* are layout handles.

Each layout handle updates the website layout. It may define new blocks, move or remove blocks which are included by other layout xml files or modificate existing blocks.

Here is a tricky part in magento: If you request a site magento will parse all xml files and look for the default update handle and will execute it. Then magento will look for the update handle matching with the route, controller and action. So if we request http://&lt;magento&gt;/helloworld it would also call the layout handle *helloworld_index_index*

### Layout elements Reference

A layout handle may contain following elements:

<dl>
  <dt>label</dt>
  <dd>Defines the label which is shown as a descriptive message in some areas of the admin panel</dd>
  <dt>reference</dt>
  <dd>You can reference a block which is defined in an other xml layout file to add blocks, modify attributes or to perform an action. The reference element must have a name attribute</dd>
  <dt>block</dt>
  <dd>Mostly it is used in a reference to create a new child block. It must have a name and a type attrbute. If it is of type core/template it can also has an template attribute</dd>
  <dt>remove</dt>
  <dd>Removes a block specified by the name attribute</dd>
  <dt>action</dt>
  <dd>Is placed in references or blocks to perform an action (TODO how to find out which actions are available)</dd>
  <dt>update</dt>
  <dd>Loads an existing handle into the current handle and it is like a kind of inheritance (TODO example here?)</dd>
</dl>

Puh! Many new informations here but still not enough.

### Where to start?

In Magento 1.9 default installation the package rwd (responsive web design) is used with the theme default. Lets have a look in the *app/design/frontend/rwd/default/layout/page.xml* file

```xml
<layout version="0.1.0">
    <!--
    Default layout, loads most of the pages
    -->

    <default translate="label" module="page">
        <label>All Pages</label>
        <block type="page/html" name="root" output="toHtml" template="page/3columns.phtml">
        <!-- ... -->
```

We see a default layout handler (which says it is on every page) with an block named *root* with an template *page/3columns.phtml*

That is our root block and this block contains many other blocks like head, after_body_start, header, breadcrumbs, left, right, content, footer and so on.

In our layout we can reference this blocks and add new blocks to it. Or we can change the template of an block, but an example says more than 1000 words. 

### Create the layout

TODO how should we extend the layout? copy paste the old one and change it in pasted folder? With right naming convention an update should not destroy the original one.

TODO the naming of layout files. 

Create the file **synoa_helloworld.xml** in **app/design/frontend/rwd/default/layout** with

```xml
<?xml version="1.0"?>
<layout version="1.0">
  <helloworld_index_index>
    <reference name="root">
      <action method="setTemplate">
        <template>synoa/helloworld/simple_page.phtml</template>
      </action>
    </reference>
  </helloworld_index_index>
</layout>
```

### Create the template

### Load the layout

We have a controller which extends *Mage_Core_Controller_Front_Action* and now its the time to call some inherited methods.

We replace the code of our **app/code/local/Synoa/HelloWorld/controllers/IndexController.php** to 

```php
<?php

class Synoa_HelloWorld_IndexController extends Mage_Core_Controller_Front_Action {

  public function indexAction() {
    $this->loadLayout();
    $this->renderLayout();
  }
}
?>
```

###############

## Setting up an helper class

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

If we request now *http://&lt;magento&gt;/helloworld* we should see "HELLO MAGENTO";

