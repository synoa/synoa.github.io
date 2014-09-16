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

You can write to your own log file with **Mage::log($logmessage, $logLevel, $filename)**;

TODO check $logLevel

Example:

```php
Mage::log('I want to log this message', null, 'namespace_module.log');
```

If this line is executed the text *I want to log this message* is appended to *var/log/namespace_module.log*. If the file not exists it will be created.

Note: Some tutorials in the wild are sending e-mails as they ovserved an mangeto event. If you have not setup an mail server on your development machine this tutorials will not work. 

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

### Code pools in magento

The code of magento and his extensions is stored in *app/code*. There are three different folders:

* core
* community
* local

#### core

In the *core* folder is all the code of magento and **we will not touch it**, because it will be maybe overwritten with next update and then our custom changes are gone.

#### community 

You can download extensions with magento connect. The code of this extensions will be stored in this folder.

#### local

This is the place for our code. It should be empty afer an clean installation of magento.

### Namespacing

A module needs a name and a namespace to avoid naming conflicts with other modules which maybe has the same name.

Mostly you will take the name of your company as namespace. Our namespace will be *Synoa*.

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

Magento will parse all xml files in *app/etc/modules* and get informations about the name of the modules, their version, where the code lives and if the module is active or not. In our xml file define our module with the *&lt;modules&gt;* tag. It is called *HelloWorld* and its namespace is *Synoa*. This information magento will get with the *&lt;Synoa_HelloWorld&gt;* tag. The seperator between namespace and module name is an underscore which will be converted internally to an directory seperator. The codepool is *local*, the version is *0.1.0* and our module is active.

Now Our custom module is visible in Magento. Login in the backend of our magento store and click on the *system* tab. At the bottom you will find the section *Advanced* and an *Advanced* overview. There you can find all Modules which have an active tag with the value true. And also our custom Module Synoa_HelloWorld.

Note: There are strict naming conventions in magento and you see camelCase in the *codePool* tag. Please make sure you have written all your tags in the right way if you get unexpected errors. It costs hours to find theese typos. 

### Disable an module

If an module in production environment is not working correctly we can disable it until we fixed the bug. In the *app/etc/modules* folder we will find an xml file for every module. Open the xml file of the module which you want to disable and set the *active* tag to *false* and the module will be disabled.

## Create Hello Magento

Our module should display *Hello Magento* in the first step. To achieve this we have to define a route which leads to an controller in which we will echo the string. 

### The config.xml

Every module needs an *config.xml* in which we configure many things like routes, controllers, helpers, layouts and so on. This file is stored in an *etc* folder and will be autoloaded.

### Lets create some module definitions and a route

#### Basics about routing

A route is a mapping between an URL and an module. If we call http://&lt;magento&gt;/helloworld magento (replace &lt;magento&gt; with your magento installation) looks in all module configurations if a route maps to an specific module. So far we have no route defined and if we request http://&lt;magento&gt;/helloworld we get a 404 Not Found page.

Note: Magento loads the different XML files in alphabetical order and looks for routes. If an route is defined multiple times the first module in the alphabetical order will get this route. Maybe an route which worked perfectly will work not any more if a new module takes the same route and is in the alphabetical order above our module. 

### Create the config.xml

* Create a directory **Synoa** in **app/code/local**.
* Create a folder **etc** in **app/code/local/Synoa/HelloWorld/**
* Create a file **config.xml** in **app/code/local/Synoa/HelloWorld/etc**

```xml
<?xml version="1.0"?>
<config>
  <modules>
    <Synoa_HelloWorld>
      <version>0.1.0</version>
    </Synoa_HelloWorld>
  </modules>
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
</config>
```

The tag *&lt;modules&gt;* are the same as in the *app/etc/modules/Synoa_HelloWorld.xml* which we created and used to merge the xml files internally. 

Explanation of the new tags

<dl>
  <dt>frontend</dt>
  <dd>Our route will map to the frontend which an user will see.</dd>
  <dt>routers</dt>
  <dd>In this tag we place all our routes for the frontend magento area</dd>
  <dt>helloworld</dt>
  <dd>Lowercase module name.</dd>
  <dt>use</dt>
  <dd>TODO</dd>
  <dt>args</dt>
  <dd>TODO</dd>
  <dt>module</dt>
  <dd>This tag define which module should be mapped</dd>
  <dt>frontName</dt>
  <dd>this is the path of the url after http://&lt;magento&gt;/</dd>
</dl>

### Setting up an controller

We recommend to read about the MVC pattern on which Magento is build up if you dont know what a controller is.

All controllers are placed in the *controllers* folder in our module folder. 

Create a folder **controllers** in **app/code/local/Synoa/HelloWorld**
Create a file **IndexController.php** in **app/code/local/Synoa/HelloWorld/controllers** with following content:

```php
<?php
class Synoa_HelloWorld_IndexController extends Mage_Core_Controller_Front_Action {
  
  public function indexAction() {
    echo 'Hello Magento';
  }
}
?>
```

Magento is build up on the Zend Framework and the Autoloader internally replaces the **_** with an directory seperator depending on which os you are. On Unix system it will be **/**. The autoloader tries to load the code from *Synoa/HelloWorld* in all defined include paths. 

The class name follows the naming convention *namespace_modulname_controllernameController*. The classname for an controller ends always with **Controller**. We extend *Mage_Core_Controller_Front_Action* to inherit some functions which will be needed later.

We also define a public function *indexAction* which echoes *Hello Magento*.

If we call http://&lt;magento&gt;/helloworld now we should see *Hello Magento*

**Note: You should never output directly like in this example. Remember principle: Filter input and escape output. But we want to show a fast way to see some action and expand this exmaple later the correct way.**

### How this works?

If you request *http://&lt;magento&gt;/helloworld* magento will expand this URL to *http://&lt;magento&gt;/helloworld/index/index*. Lets have a closer look at this URL. It consists of 4 parts

http://**domain**/**route**/**controller**/**action**

1. Magento will look for an route with the value *helloworld* in the *frontName* tag in every module. We defined it in *app/code/local/Synoa/HelloWorld/etc/config.xml*
2. Magento will look for an IndexController in our module folder app/code/local/Synoa/HelloWorld/controllers and yeah we have one.
3. Magento will call the indexAction method of the controller class.

So what happens if we call *http://&lt;magento&gt;/helloworld/index/goodbye*? We will get an 404 page because there is no *goodbyeAction* method in our *app/code/local/Synoa/HelloWorld/controllers/IndexController.php*

Lets expand it and add some code to the IndexController:

 ```php
<?php
class Synoa_HelloWorld_IndexController extends Mage_Core_Controller_Front_Action {
  
  public function indexAction() {
    echo 'Hello magento';
  }

  ### new code begin ###
  public function goodbyeAction() {
    echo 'Goodbye magento';
  }
  ### new code end ###
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

With layouts you can position your blocks on the right place. Layout XML files are stored in *app/design/&lt;magento area&gt;/&lt;package&gt;/&lt;theme&gt;/layout*. Every module may define its own layout.

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

### Fallback mechanic

TODO

### Layout elements Reference

A layout handle may contain following elements:

<dl>
  <dt>label</dt>
  <dd>Defines the label which is shown as a descriptive message in some areas of the admin panel</dd>
  <dt>reference</dt>
  <dd>You can reference a block which is defined in an other xml layout file to add blocks, modify attributes or to perform an action. The reference element must have an name attribute</dd>
  <dt>block</dt>
  <dd>Mostly it is used in a reference to create a new child block. It must have a unique name and a type attribute. If it is of type *core/template* it can also has an template attribute</dd>
  <dt>remove</dt>
  <dd>Removes a block specified by the name attribute</dd>
  <dt>action</dt>
  <dd>Is placed in references or blocks to perform an action (TODO how to find out which actions are available)</dd>
  <dt>update</dt>
  <dd>Loads an existing handle into the current handle and it is like a kind of inheritance</dd>
</dl>

#### Mostly used actions for layout handle type *action*:

<dl>
  <dt>setTemplate</dt>
  <dd>To change the template file</dd>
  <dt>addCss</dt>
  <dd>To add a custom CSS file</dd>
  <dt>addJs</dt>
  <dd>To add a custom JS file</dd>
  <dt>setContentType</dt>
  <dd>To override the default default header *Content-Type: text/html* to a value we wish e. g. *text/xml*</dd>
  <dt>setCharset</dt>
  <dd>To override the default charset</dd>
  <dt>addLink</dt>
  <dd>To set a setting to which we can refer in our template file</dd>
</dl>

Puh! Many new informations here so lets start.

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

Create the file **synoa_helloworld.xml** in **app/design/frontend/rwd/default/layout** with

```xml
<?xml version="1.0"?>
<layout version="1.0">
  <helloworld_index_index>
    <reference name="root">
      <action method="setTemplate">
        <template>page/1column.phtml</template>
      </action>
      <reference name="content">
        <block type="core/template" name="synoa.helloworld.helloworld" template="synoa/helloworld/helloworld.phtml"></block>
      </reference>
    </reference>
  </helloworld_index_index>
</layout>
``` 

We start with an *layout* tag followed by our frontName (TODO it is not frontName what is it???) route which we defined in our config.xml of our module in *app/code/local/Synoa/HelloWorld/etc/config.xml*. Than we reference the root Element and setting the template to a template withouth sidebars. After this we reference a block called *content* and create a new block of type *core/template*, set the name to *synoa.helloworld.helloworld* to can reference it in any other layout handles and finally we set the template to *synoa/helloworld/helloworld.phtml*;

### Create the template

Magento uses PHP as template engine. The template files are a mix of HTML and PHP code and the file ending will *.phtml.

We referenced in our layout file to *synoa/helloworld/helloworld.phtml*. Lets create this file.

Create a directory **synoa** in **app/design/frontend/rwd/default/template** in which we will store our templates
Create a directory **helloworld** in app/design/frontend/rwd/default/template/synoa in which we store our templates for the *helloworld* module.
Create the file **helloworld.phtml** in **app/design/frontend/rwd/defaul/template/synoa/helloworld** and add an simple paragraph with *Hello Magento*.

```html
<h4>Hello Magento</h4>
```

Next we have to load the layout in the controller and render it.

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

Now we should see just our *Hello world* in the store website with no columns on the left or right if we request http://&lt;magento&gt;/helloworld 

### Layout Block types

Show overview of layout block types in magento:

<dl>
  <dt>core/template</dt>
  <dd>A block which uses a template file to show content</dd>
  <dt>page/html_head</dt>
  <dd>The HTML HEAD section of our page which contains elements to add CSS and JS</dd>
  <dt>page/html_header</dt>
  <dd>The header part of our page with content like logo, navigation and so on</dd>
  <dt>page/template_links</dt>
  <dd>This is used to creat a list of links. Links in the header or footer are made with this block type</dd>
  <dt>core/text_list</dt>
  <dd>Some blocks like content, left, right etc. are of this type. If this blocks are rendered, all of their child blocks are rendered automatically with no need to call *getChildHtml()*</dd>
  <dt>page/html_wrapper</dt>
  <dd>To create a wrapper block which renders its child blocks inside an HTML tag. The HTML tag *div* is used as default but can specified with *setHtmlTagName*</dd>
  <dt>page/html_breadcrumbs</dt>
  <dd>The breadcrumbs on the page</dd>
  <dt>page/html_footer</dt>
  <dd>Defines the footer area with footer links, copyright etc</dd>
  <dt>core/messages</dt>
  <dd>Renders error/success/notice messages</dd>
  <dt>page/switch</dt>
  <dd>Can be used to switch the language or store</dd>
</dl>

## Create a custom table

Next we want to load some data from the database and show it in our *Hello Magento* site.

### sql scripts

First we need an table in our DB, but we do not open our command line tool or somehtings like phpMyAdmin. The table should be created by the module itself. We can do this with sql setup scripts.

Create an folder **sql** in **app/code/local/Synoa/HelloWorld/
Create an folder **helloworld_setup** in **app/code/local/Synoa/HelloWorld/sql**
Create an file **mysql4-install-0.1.0.php** in **app/code/local/Synoa/HelloWorld/sql/helloworld_setup**

Lets have a look at the filename:
*mysql4-install-[moudule version].php*

TODO upgrade changes to mysql4-upgrade

```php
<?php 

$installer = $this;

$installer->startSetup();

$installer->run("
  -- DROP TABLE IF EXISTS `superheroes`;

  CREATE TABLE `superheroes` (
    `superheroes_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL,
    `message` text NOT NULL,
    PRIMARY KEY (`superheroes_id`)
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8;

  INSERT INTO `superheroes`
    (`name`, `message`)
  VALUES 
    ('Batman', 'I am Batman'),
    ('Heman', 'By the power of grayskull, i have the power'),
    ('Hulk', 'Whoaaaaaa');
");

$installer->endSetup();
?>
```

We start with *$installer* and the method *->startSetup()*. This will turn off some checks in magento which will may fail while installation. After this we execute some SQL code wiht method *->run(SQL code)*. Finally we turn the checks on by executing mehtod *->endSetup()*. The SQL code is simple. We create a table superheroes  with an id, an name and an message. We set the primary key to id and want to use InnoDB as storage engine. Than we add some rows to the created table with example data. 

### Run the sql setup script

To run this setup script we have to add some lines to our **config.xml** file in **app/code/local/Synoa/HelloWorld/etc**

```xml
<?xml version="1.0"?>
<config>
  <modules>
    <Synoa_HelloWorld>
      <version>0.1.0</version>
    </Synoa_HelloWorld>
  </modules>
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
    <layout>
      <updates>
        <synoa_helloworld>
          <file>synoa_helloworld.xml</file>
        </synoa_helloworld>
      </updates>
    </layout>
  </frontend>
  <!-- new code begin -->
  <global>
    <resources>
      <helloworld_setup>
        <setup>
          <module>Synoa_HelloWorld</module>  
        </setup>
      </helloworld_setup>
    </resources>
  </global>
  <!-- new code end -->
</config>
```

Refresh your magento site and the script will be executed and the table will be created.

NOTE: if someting goes wrong with the creation of the table and you have to rerun it search for the table *core_resource* in your database and remove the row with *helloworld_setup* with the right version.

Check in your database for the table creation and the example data with:

```sql
select * from superheroes;
```

and you should see
```
+----------------+--------+---------------------------------------------+
| superheroes_id | name   | message                                     |
+----------------+--------+---------------------------------------------+
|              1 | Batman | I am Batman                                 |
|              2 | Heman  | By the power of grayskull, i have the power |
|              3 | Hulk   | Whoaaaaaa                                   |
+----------------+--------+---------------------------------------------+
```

### Create the model

We do not want to write SQL commands and use magentos magic methods and a collection to load the data. But first we need a model which will provide this magic methods.

Create a folder **Model** in **app/code/local/Synoa/HelloWorld**
Create a file **SuperHeroes.php** in **app/code/local/Synoa/HelloWorld/Model**

```php
<?php

class Synoa_HelloWorld_Model_Superheroes extends Mage_Core_Model_Abstract {
  
  protected function _construct() {
    $this->_init('helloworld/superheroes');
  }
}
?>
```

Create a folder **Mysql4** in **app/code/local/Synoa/HelloWorld/Model**
Create a file **SuperHeroes.php** in **app/code/local/Synoa/HelloWorld/Model/Mysql4**

```php
<?php

class Synoa_HelloWorld_Model_Mysql4_Superheroes extends Mage_Core_Model_Mysql4_Abstract {

  protected function _construct() {
    $this->_init('helloworld/superheroes', 'superheroes_id');
  }
}
?>
```

### Define model and resource model in config.xml

```xml
<?xml version="1.0"?>
<config>
  <modules>
    <Synoa_HelloWorld>
      <version>0.1.0</version>
    </Synoa_HelloWorld>
  </modules>
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
    <layout>
      <updates>
        <synoa_helloworld>
          <file>synoa_helloworld.xml</file>
        </synoa_helloworld>
      </updates>
    </layout>
  </frontend>
  <global>
    <resources>
      <helloworld_setup>
        <setup>
          <module>Synoa_HelloWorld</module>  
        </setup>
      </helloworld_setup>
    </resources>
    <!-- new code begin -->
    <models>
      <helloworld>
        <class>Synoa_HelloWorld_Model</class>
        <resourceModel>helloworld_superheroes</resourceModel>
      </helloworld>
      <helloworld_superheroes>
        <class>Synoa_HelloWorld_Model_Mysql4</class>
        <entities>
          <superheroes>
            <table>superheroes</table>
          </superheroes>
        </entities>
      </helloworld_superheroes>
    </models>
    <!-- new code end -->
  </global>
</config>
```

### Test the models

Okay just to test our models we change the **app/code/local/Synoa/HelloWorld/controllers/IndexController.php** to:

```php
<?php

class Synoa_HelloWorld_IndexController extends Mage_Core_Controller_Front_Action {

  public function indexAction() {
    $superHeroModel = Mage::getModel('helloworld/superheroes');

    $superHeroModel->load(1);

    var_dump($superHeroModel->getData());


    // load the layout
    $this->loadLayout();
    // render the layout
    $this->renderLayout();
  }
}
?>
```

You should see some data on the top of your site with the values from the database. Nice but we want to display all data and for this we create an colleciton.

### Create an collection

To get some more magic methods create an folder ** in **app/code/local/Synoa/HelloWorld/Models/Mysql4**

```php
<?php

class Synoa_HelloWorld_Model_Mysql4_Superheroes_Collection extends Mage_Core_Model_Mysql4_Collection_Abstract {
  
  protected function _construct() {
    $this->_init('helloworld/superheroes');
  }
}
?>
```

With a collection we can get the whole data. The collection also provides methods of the Iterator pattern.

### load the data

We change our **app/code/local/Synoa/HelloWorld/controllers/IndexController.phh** to

```php
<?php

class Synoa_HelloWorld_IndexController extends Mage_Core_Controller_Front_Action {

  public function indexAction() {
    $superHeroes = Mage::getModel('helloworld/superheroes')->getCollection();

    // load the layout
    $this->loadLayout();

  // assign values to template
    $this->getLayout()
         ->getBlock('synoa.helloworld.helloworld')
         ->assign('heroes', $superHeroes);

    // render the layout
    $this->renderLayout();
  }
}
?>
```

Okay what have we done? We load all data with *Mage::getModel('helloworld/superheroes')->getCollection()* to the variable *$superheroes*. Next we load the layout like before. Now before we render the layout we get the block inside ** and assign the value of *superheroes* to the variable *heroes* in the template. Finally we render the layout like before.

In the template the variable *heroes* will contain the data. Lets test it. Change the content of **** to:

```phtml
<h4>Hello Magento</h4>
<table>
  <thead>
    <tr>
      <th>Id</th>
      <th>Name</th>
      <th>Message</th>
    </tr>
  </thead>
  <tbody>
  <?php
  foreach ($heroes as $hero) {
    // create HTML
    echo '<tr>'
      . '<td>' . $this->escapeHtml($hero->getSuperheroes_id()) . '</td>'
      . '<td>' . $this->escapeHtml($hero->getName()) . '</td>'
      . '<td>' . $this->escapeHtml($hero->getMessage()) . '</td>'
      . '</tr>';
  }
  ?>
  </tbody>
</table>
```

If we request *http://&lt;magento&gt;/helloworld* we should see an HTML table with our example data which comes from our database.

## Configuration variables for your module

Sometimes we want some configuration variables for an module. Magento provides an technique to store configuration variables and provides xml structures to create fields in the backend to edit this variables.

### Create default value

Lets create a defaul value first and extend our *app/code/local/Synoa/HelloWorld/etc/config.xml* file a little bit

```xml
<?xml version="1.0"?>
<config>
  <modules>
    <Synoa_HelloWorld>
      <version>0.1.0</version>
    </Synoa_HelloWorld>
  </modules>
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
    <layout>
      <updates>
        <synoa_helloworld>
          <file>synoa_helloworld.xml</file>
        </synoa_helloworld>
      </updates>
    </layout>
  </frontend>
  <global>
    <resources>
      <helloworld_setup>
        <setup>
          <module>Synoa_HelloWorld</module>  
        </setup>
      </helloworld_setup>
    </resources>
    <models>
      <helloworld>
        <class>Synoa_HelloWorld_Model</class>
        <resourceModel>helloworld_superheroes</resourceModel>
      </helloworld>
      <helloworld_superheroes>
        <class>Synoa_HelloWorld_Model_Mysql4</class>
        <entities>
          <superheroes>
            <table>superheroes</table>
          </superheroes>
        </entities>
      </helloworld_superheroes>
    </models>
  </global>
  <!-- new code begin -->
  <default>
    <synoa>
      <whatsyourname>
        <name>Dagobert</name>
      </whatsyourname>
    </synoa>
  </default>
  <!-- new code end -->
</config>
```

### Load it

We want to load the default value in the controller and assign it to the template. Lets change our **app/code/local/Synoa/HelloWorld/controllers/IdexController.php** to:

```php
<?php

class Synoa_HelloWorld_IndexController extends Mage_Core_Controller_Front_Action {

  public function indexAction() {
    $superHeroes = Mage::getModel('helloworld/superheroes')->getCollection();

    // load the layout
    $this->loadLayout();

  // assign values to template
    $this->getLayout()
         ->getBlock('synoa.helloworld.helloworld')
         ->assign('name', Mage::getStoreConfig('synoa/whatsyourname/name')) // new code
         ->assign('heroes', $superHeroes);

    // render the layout
    $this->renderLayout();
  }
}
?>
```

And we have to change our template **app/design/frontend/rwd/default/template/synoa/helloworld/helloworld.phtml** too:

```php
<h4>Hello <?php echo $this->escapeHtml($name) ?></h4>
<table>
  <thead>
    <tr>
      <th>Id</th>
      <th>Name</th>
      <th>Message</th>
    </tr>
  </thead>
  <tbody>
  <?php
  foreach ($heroes as $hero) {
    // create HTML
    echo '<tr>'
      . '<td>' . $this->escapeHtml($hero->getSuperheroes_id()) . '</td>'
      . '<td>' . $this->escapeHtml($hero->getName()) . '</td>'
      . '<td>' . $this->escapeHtml($hero->getMessage()) . '</td>'
      . '</tr>';
  }
  ?>
  </tbody>
</table>
```

We replaced *Magento* in *Hello Magento* with *$name* and if we request now our site we should see *Hello Dagobert* instead of *Hello Magento*.

### Create backend section

Now we want to change this configuration variable in the backend. Magento provides some xml which we can use to create a section, a group and a field and will save it in the database in the table *core_config_data*

We create a file **system.xml** in **app/code/local/Synoa/HelloWorld/etc**

```xml
<?xml version="1.0"?>
<config>
  <sections>
    <synoa translate="label">
      <label>Synoa</label>
      <tab>general</tab>
      <frontend_type>text</frontend_type>
      <sort_order>1000</sort_order>
      <show_in_default>1</show_in_default>
      <show_in_website>1</show_in_website>
      <show_in_store>1</show_in_store>
    </synoa>
  </sections>
</config>
```

TODO explanation here of new tags see magento wiki

If we go into our magento backend now and click the **System** tab we should see a new section *Synoa* in the *General* group.

If we click on it we should get an 404 or access denied error. We have to create another file to set the rights of this system configuration. 

Create a file **adminhtml.xml** in **app/code/local/Synoa/HelloWorld/etc**

```xml
<?xml version="1.0"?>
<config>
  <acl>
    <resources>
      <all>
        <title>Allow Everything</title>
      </all>
      <admin>
        <children>
          <system>
            <children>
              <config>
                <children>
                  <synoa translate="title">
                    <title>Synoa</title>
                    <sort_order>100</sort_order>
                  </synoa>
                </children>
              </config>
            </children>
          </system>
        </children>
      </admin>
    </resources>
  </acl>
</config>
```

If you click now on *Synoa* in *General* section you will also get an 404 or access denied error.

**YOU HAVE TO LOG OUT AND LOG IN AGAIN**

If you logged in again you will get the page with no content besides an header with *synoa* but without an error.

### Create a group

We extend our backend section with a group *whatsyourname*. We change our **app/code/local/Synoa/HelloWorld/etc/system.xml** to

<?xml version="1.0"?>
<config>
  <sections>
    <synoa translate="label">
      <label>Synoa</label>
      <tab>general</tab>
      <frontend_type>text</frontend_type>
      <sort_order>1000</sort_order>
      <show_in_default>1</show_in_default>
      <show_in_website>1</show_in_website>
      <show_in_store>1</show_in_store>
      <!-- new code begin -->
      <groups>
        <whatsyourname translate="label">
          <label>Whats your name</label>
          <frontend_type>text</frontend_type>
          <sort_order>100</sort_order>
          <show_in_default>1</show_in_default>
          <show_in_website>1</show_in_website>
          <show_in_store>1</show_in_store>
        </whatsyourname>
      </groups>
      <!-- new code end -->
    </synoa>
  </sections>
</config>

Now we should see in our backend a gray bar with *What is your name* and we can collapse it.

### Create field

We want to create a text field where we can save our name to the config store. 

Lets add an field to our group *whatsyourname*

We change the **app/code/local/Synoa/HelloWorld/etc/system.xml** to

```xml
<?xml version="1.0"?>
<config>
  <sections>
    <synoa translate="label">
      <label>Synoa</label>
      <tab>general</tab>
      <frontend_type>text</frontend_type>
      <sort_order>1000</sort_order>
      <show_in_default>1</show_in_default>
      <show_in_website>1</show_in_website>
      <show_in_store>1</show_in_store>
      <groups>
        <whatsyourname translate="label">
          <label>Whats your name</label>
          <frontend_type>text</frontend_type>
          <sort_order>100</sort_order>
          <show_in_default>1</show_in_default>
          <show_in_website>1</show_in_website>
          <show_in_store>1</show_in_store>
          <!-- new code begin -->
          <fields>
            <name translate="label">
              <label>Name</label>
              <frontend_type>text</frontend_type>
              <sort_order>10</sort_order>
              <show_in_default>1</show_in_default>
              <show_in_website>1</show_in_website>
              <show_in_store>1</show_in_store>
            </name>
          </fields>
          <!-- new code end -->
        </whatsyourname>
      </groups>
    </synoa>
  </sections>
</config>
```

### Test it

Now if we collapse our group *What is your name* we can see a text input field in which we will store the value **Donald**.

Request *http://&lt;magento&gt;/helloworld and we should see *Hello Donald* and if we look in the database in the table *core_config_data* we should see an entry with an pathvalue of *synoa/whatsyourname/name* and the value *Donald*



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

NOTE for me

if you extend the backend you have to log out and log in again for the section you setup the acl.