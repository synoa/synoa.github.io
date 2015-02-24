# i18n not showing

If i18n not showing make sure you set devleoper mode to off. If developer mode is on translations will be taken only from the module itself.

If you make a translation in the translate.csv in your theme and the translation is not shown in frontend you have to prepend the core translation file. 

## Example

Maybe you have a file *app/design/frontend/default/THEME/locale/de_DE/translate.csv* in 
```csv
"Add to Cart";"In den Warenkorb"
```

and the text is not translated with your translation change it to

```csv
"Mage_Catalog::Add to Cart","In den Warenkorb"
```