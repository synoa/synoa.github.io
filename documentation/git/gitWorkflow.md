# GIT Workflow (WIP)

## Feature Branch erstellen

`git status`

sollte ausgeben

```
Auf Branch develop
nichts zu committen, Arbeitsverzeichnis unverändert
```

Wenn hier doch Dateien sind, dann ist zu klären wieso.

`git checkout -b feat/####/description`

gibt aus

```
Gewechselt zu einem neuen Branch 'feat/####/description'
```

### Feature Branch im Remote Repo bereitstellen

`git push origin feat/####/description`

gibt aus 

```
Username for 'https://github.com': 
Password for 'https://xxxxxx@github.com': 
Total 0 (delta 0), reused 0 (delta 0)
To https://github.com/synoa/customer.shop.git
 * [new branch]      feat/####/description -> feat/####/description
```

## Das übliche coden, stylen, committen

`git add someFile.php`

`git commit -m "commit message goes here"`

`git add anotherFile.php`

`git commit -m "commit message goes here"`

## Für andere zur Verfügung stellen

`git push origin feat/####/description`

## Fertig für Review auf Staging

Wenn man fertig ist dann macht man einen merge in den review branch.

Review auschecken

`git checkout review`

Mergen (kein Fast Forward)

`git merge --no-ff feat/####/description`

Ins Remote Repo

`git push review`

Auf Server wechseln und schnell mal prüfen ob man im review ist

`git status`

Alles okay dann pullen mit

`git pull review`

## Review wurde abgenommen

Jetzt mergen wir den Feature Branch in den **develop** Branch **nicht** in den review (dort ist er ja schon)

`git checkout develop`

`git merge --no-ff feature/####/description`

`git push origin develop`

Jetzt den feature branch löschen

Lokalen Branch löschen mit

`git branch -d feature/####/description`

Remote Branch löschen mit

`git push origin :feature/####/description`