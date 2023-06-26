# FireLisp2

## 2023-06-26

#### function _fl.selectionSetFromLayersList (layersList)_

Zwraca selection set zawierający wszystkie encje znajdujące się na layersList

przykład:

```
(setq ll (list "l1" "l2" "8"))
(setq ss fl.selectionSetFromLayersList (ll))
```

#### function _fl.getEntityType (entityName)_
Zwraca zawatość tablicy o index'ie 0 czyli nazwę elementu

przykład:

```
(setq en (car (entsel)))
(setq et (fl.getEntityType en))
```

#### function _fl.isBlock (entityName)_
Zwraca zawatość T jeśli encja jest blokiem w przciwnym wypadku nil

przykład:

```
(setq en (car (entsel)))
(fl.isBlock en)
```

#### function _fl.printElementsBySelectionSet (ss)_
Konsoluje (entget) dla każdego elementu z ss

przykład:

```
(setq en (car (entsel)))
(setq ss fl.isBlock en)
```
