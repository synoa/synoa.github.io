# How to setup a custom module in Magento

## Short overview

We will create a custom Module named HelloWorld in Magento with following features:

TODO awesome feature list goes here

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

** Activate our custom module

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

Now Our custom component is visible in Magento. Login in the backend of our magento store and click on the *system* tab. At the bottom you will find the section *Advanced* and an *Advanced* overview. There you can find all Modules which have an active tag with the value true. And also our custom Module Synoa_HelloWorld