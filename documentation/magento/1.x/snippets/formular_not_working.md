If a form is not working in Magento >= 1.8, the form is propably missing the "form_key" input field. You can add the missing field like this:


```html
<form name="myform">
  <!-- Add the "formkey" block at the beginning of the form -->
  <?php echo $this->getBlockHtml('formkey'); ?>
</form>
```

The block / template itself is defined in the Magento-Core (design/frontend/base/default/template/core/formkey.phtml), so you just need to add the block and nothing else. 
