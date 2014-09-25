If the shipping method for the onepage-checkout is not working, you have to edit `checkout/onepage/payment.phtml` and look for this:

```html
<fieldset>
    <?php echo $this->getChildHtml('methods') ?>
</fieldset>
```

and add the id `checkout-payment-method-load` to the `fieldset`

```html
<fieldset id="checkout-payment-method-load">
    <?php echo $this->getChildHtml('methods') ?>
</fieldset>
```

[Source](http://www.magentocommerce.com/boards/viewthread/441003/#t460203)
