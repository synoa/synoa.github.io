# Standardfunktionen von Magento ausschalten

## Vorab ein paar Hinweise:

Ein Abschalten der Module in System > Konfiguration -> Erweitert -> Erweitert unterdrückt die Modulausgabe. Die Module bestehen weiterhin. 

Wenn Blöcke entfernt werden müssen, dann sollte man dies mit Hilfe der local.xml machen. Falls dies nicht möglich sein sollte, dann bitte
die Datei in eigenes Theme kopiere und kommentieren.

## Wunschzettel 
**System -> Konfiguration -> Kunden -> Wunschzettel -> Aktiviert -> nein**

## Send-a-friend
**System -> Konfiguration -> Katalog -> E-Mail an einen Freund -> Aktiviert -> nein**

## Tagging durch Kunden

### Modulausgabe deaktivieren
**System -> Konfiguration -> Erweitert -> Erweitert > Mage_Tag -> Disable**

### Blöcke entfernen
Vielleicht müssen auch einige Blöcke entfernt werden. Diese sind wohl hauptsächlich in der **base/default/layout/tag.xml** definiert

## Reviews von Kunden

### Modulausgabe deaktivieren
**System -> Konfiguration -> Erweitert -> Erweitert > Mage_Review -> Disable**

### Blöcke entfernen
Vielleicht müssen auch einige Blöcke entfernt werden. Diese sind wohl hauptsächlich in der **base/default/layout/tag.xml** definiert

## Produktvergleich

### Modul benötigt
Um den Produktvergleich zu deaktivieren benötigt man ein Modul, welcher die **getAddUrl()** Methode der Klasse **Mage_Catalog_Helper_Product_Compare** überschreibt. Dieses Modul sollte intern schon vorhanden sein und kann einfach mit modman zum Magento Projekt hinzugefügt werden. Diese Modul entfernt die Links "Produkt zur Vergleichliste hinzufügen"

### Blöcke ausblenden
Zusätzlich muss man Blöcke in der Sidebar mit der **local.xml** entfernen

Ein erster Ansatz
```xml
<layout>
    <default>
        <remove name="catalog.compare.sidebar"/>
        <remove name="right.reports.product.compared"/>
    </default>   
</layout>
``` 

## Footerlinks

### Link entfernen
Man kann in der local.xml Links im Footer entfernen mit

```xml
<reference name="footer_links">
	<action method="removeLinkByUrl"><url helper="catalog/map/getCategoryUrl" /></action>
	<action method="removeLinkByUrl"><url helper="catalogsearch/getSearchTermUrl" /></action>
	<action method="removeLinkByUrl"><url helper="catalogsearch/getAdvancedSearchUrl" /></action>
	<action method="removeLinkByUrl" ifconfig="contacts/contacts/enabled"><url>http://www.shop.url/contacts/</url></action>
	<action method="removeLinkByUrl" ifconfig="rss/config/active"><url>http://www.shop.url/rss/</url></action>
	<action method="removeLinkByUrl"><url helper="sales/guest_links" /></action>
</reference>
```

**Sonderfall Rücksende Link**

```xml
<remove name="return_link"/>
```

## Verfügbarkeiten im Shop ausblend

Es gibt im Shop die Anzeige *Verfügbarkeit: auf Lager* und diese kann man ausblenden in 

System -> Konfiguration -> Lagerverwaltung -> Lageroptionen -> Lagerbestand im Frontend anzeigen -> Nein