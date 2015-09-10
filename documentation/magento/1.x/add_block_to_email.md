# Add block to email

In Magento a Block with a specific template can be added to any E-Mail. To do so, one needs to define a Template first.
In this example the defined template is located in `app/design/frontend/[PACKAGE]/[THEME]/synoa/email`.

```php
// app/design/frontend/[PACKAGE]/[THEME]/synoa/email/hello_world.phtml
<?php
  echo "HELLO WORLD!";
?>
```

This template simply prints "HELLO WORLD". To include it inside an E-Mail we need to open the E-Mail in the Magento Backend,
for example the "New Account" E-Mail, in `System -> Transactual E-Mails`. The template may look something like this.

```html
{{template config_path="design/email/header"}}
{{inlinecss file="email-inline.css"}}

<table cellpadding="0" cellspacing="0" border="0">
    <tr>
        <td class="action-content">
            <h1>Welcome to {{var store.getFrontendName()}}.</h1>
            <p>To login to our shop simply click <a href="{{store url="customer/account/"}}">Login</a> or <a href="{{store url="customer/account/"}}">My Account</a> in the upper right of any page with the following credentials:</p>
            <p class="highlighted-text">
                <strong>E-Mail-Adresse:</strong> {{var customer.email}}<br/>
                <strong>Password:</strong> {{htmlescape var=$customer.password}}
            </p>
        </td>
    </tr>
</table>
```

Let's add the new block to the top of this template. To do so we'll include another tag like this:

```mustache
{{block type="core/template" area="frontend" template="synoa/email/hello_world.phtml"}}
```
```html
{{template config_path="design/email/header"}}
{{inlinecss file="email-inline.css"}}

{{block type="core/template" area="frontend" template="synoa/email/hello_world.phtml"}}
<table cellpadding="0" cellspacing="0" border="0">
    <tr>
        <td class="action-content">
            <h1>Welcome to {{var store.getFrontendName()}}.</h1>
            <p>To login to our shop simply click
            <a href="{{store url="customer/account/"}}">Login</a> or <a href="{{store url="customer/account/"}}">My Account</a>
            in the upper right of any page with the following credentials:</p>
            <p class="highlighted-text">
                <strong>E-Mail-Adresse:</strong> {{var customer.email}}<br/>
                <strong>Password:</strong> {{htmlescape var=$customer.password}}
            </p>
        </td>
    </tr>
</table>
```

Our E-Mail will now render the string "HELLO WORLD" on top. Nothing fancy, so how can this be useful? By passing variables and objects.

When an Object is available inside an E-Mail we can pass it to the Block. This is the case inside the "New Order" E-Mail, for example.

```mustache
<!-- Inside the New Order E-Mail -->
{{block type="core/template" area="frontend" template="synoa/email/hello_world.phtml" order=$order}}
```

Now inside the Template we can access this variable.
```php
// app/design/frontend/[PACKAGE]/[THEME]/synoa/email/hello_world.phtml
<?php
  // Two ways of accessing the passed variable: Magic Getter or getData
  $order = $this->getOrder();
  $order = $this->getData('order');

  // Verify it really is an order to prevent issues
  if($order instanceof Mage_Sales_Model_Order) {
    // Do something with your order.
  }
?>
```

Both calls will return the same reference, from here on it's up to once imagination what can be done with the Data.

What kind of Objects are available depends on the E-Mail Type. All data, however, can be accessed the same way by calling `$this->getProp()` or `$this->getData('prop')`.
