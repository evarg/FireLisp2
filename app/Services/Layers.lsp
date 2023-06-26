; =======================================================================
; Documented
; =======================================================================

(defun fl.selectionSetFromLayersList (layerList / layersQuery) 
  (setq layersQuery '((-4 . "OR>")))
  (foreach layerName layerlist 
    (setq layersQuery (cons (cons 8 layerName) layersQuery))
  )
  (setq layersQuery (cons '(-4 . "<OR") layersQuery))
  (ssget "X" layersQuery)
)

; --------------------------------------------------------------------------------------------------------

(defun fl.getEntityType (entityName / return) 
  (setq return nil)
  (if entityName 
    (setq return (cdr (assoc 0 (entget entityName))))
    return
  )
)

; --------------------------------------------------------------------------------------------------------

(defun fl.isBlock (entityName / return) 
  (setq return nil)
  (if entityName 
    (if (= "INSERT" (fl.getEntityType entityName)) 
      (setq return T)
    )
  )
  return
)

; --------------------------------------------------------------------------------------------------------

(defun fl.printElementsBySelectionSet(ss / i entityName) (setq i 0) 
  (repeat (sslength ss) 
    (setq entityName (ssname ss i))
    (print (entget entityName))
    (setq i (1+ i))
  )
)

; =======================================================================
; Temporary
; =======================================================================


(defun fl.canBlockAutoNumeration (entityName blocksList))



(defun fl.layerOff (layerName) 
  (command "_layer" "_off" layerName "")
)

  ; --------------------------------------------------------------------------------------------------------
(defun fl.layerOn (layerName) 
  (command "_layer" "_on" layerName "")
)

  ; --------------------------------------------------------------------------------------------------------
(defun fl.layerNew (layerName) 
  (command "_layer" "_new" layerName "")
)

  ; --------------------------------------------------------------------------------------------------------
(defun fl.layerSetActive (layerName) 
  (command "_layer" "s" layerName "")
)

  ; --------------------------------------------------------------------------------------------------------
(defun fl.layerRename (layerName layerNameNew / obj state) 
  (if (setq obj (tblobjname "Layer" layerName)) 
    (progn 
      (entmod 
        (subst 
          (cons 2 layerNameNew)
          (assoc 2 (entget obj))
          (entget obj)
        )
      )
      (print 
        (strcat " *** INFO *** Nazwa warstwy zostala zmieniona na: '" 
                layerNameNew
                "'."
        )
      )
    )
    (print 
      (strcat " ### ERROR ### Nie znaleziono warstwy o nazwie '" layerName "'.")
    )
  )
  (princ)
)

  ; --------------------------------------------------------------------------------------------------------
(defun fl.layerSetColor (layerName color / obj) 
  (if (setq obj (tblobjname "Layer" layerName)) 
    (progn 
      (entmod 
        (subst 
          (cons 62 color)
          (assoc 62 (entget obj))
          (entget obj)
        )
      )
      (print 
        (strcat " *** INFO *** Kolor warstwy '" 
                layerName
                "' zostal zmieniony na kolor o numerze: '"
                (itoa color)
                "'."
        )
      )
    )
    (print 
      (strcat " ### ERROR ### Nie znaleziono warstwy o nazwie '" layerName "'.")
    )
  )
  (princ)
)

  ; --------------------------------------------------------------------------------------------------------
(defun fl:layer:getByName (layerName) 
  (setq ssBlocks (ssget "_X" '((0 . "LAYER"))))
  (setq i 0)

  (repeat (sslength ssBlocks) 
    (progn 
      (setq entityName (ssname ssBlocks i))
      (print entityName)
      ;      (setq blockFID (fl:attrib:content:get entityName "FID"))
      ;      (if (= blockFID fid)
      ;        (progn
      ;          (setq returnValue entityName)
      ;        )
      ;      )
      (setq i (+ i 1))
    )
  )
  returnValue
)