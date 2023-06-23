(setq flG.NumberingActualValue 1)
(setq flG.NumberingValuesCount 1)
(setq flG.NumberingType fl.NUMBERING_TYPE_MAX)

(setq flC.NumberingLeadingZeros 4)


(defun fl.loopNewDialog (/ dclID) 
  (setq dclID (load_dialog (strcat PATH_SCRIPT "app\\Dialogs\\LoopAdd.dcl")))
  (new_dialog "dclLoopAdd" dclID)

  (set_tile "eBlockScale" (rtos CONF_SCALE_DEFAULT))
  (set_tile "eAttribName" CONF_ATTRIB_OPERATION)

  (action_tile "accept" 
               "
               (setq CONF_SCALE_DEFAULT (atof (get_tile \"eBlockScale\")))
				       (setq CONF_ATTRIB_OPERATION (get_tile \"eAttribName\"))
               (done_dialog 0)
			"
  )

  (action_tile "bDefaultPLAN" 
               "
               (set_tile \"eAttribName\" \"PLAN\")
			"
  )

  (action_tile "bDefaultCENTRALA" 
               "
               (set_tile \"eAttribName\" \"CENTRALA\")
			"
  )

  (action_tile "bDefaultRAW" 
               "
               (set_tile \"eAttribName\" \"RAW\")
			"
  )

  (start_dialog)
  (unload_dialog dclID)
)



(defun c:foo () 
  (setq koniec nil)

  (while (not koniec) 
    (initget "Nastepny Poprzedni poJedynczy poDwojny Konfiguracja konieC")
    (print 
      (strcat "Nastepna wartosc; " 
              (itoa w)
              ", numer automatyczny: "
              (fl.getNumberingAutoValue flG.NumberingActualValue)
      )
    )

    (setq ans (entsel "\nWybierz blok [Nastepny/Poprzedni/poJedynczy/poDwojny/Konfiguracja/konieC]: "))

    (if 
      (or (null ans) 
          (= "konieC" ans)
      )
      (progn 
        (setq koniec T)
      )
      (progn 
        (print (strcat "Wybrana opcja: " ans))
        (if (= "poJedynczy" ans) (fl.numberingSetValuesCount 1))
        (if (= "poDwojny" ans) (fl.numberingSetValuesCount 2))

        (if (= "Wartosc+1" ans) 
          (progn 
            (setq flG.NumberingActualValue (1+ flG.NumberingActualValue))
          )
        )

        (if (= "wArtosc-1" ans) 
          (progn 
            (setq flG.NumberingActualValue (1- flG.NumberingActualValue))
          )
        )
      )
    )
  )
  (princ)
)

(defun fl.numberingSetValuesCount (value) 
  (setq flG.numberingValuesCount value)
)

(defun fl.numberingPrepareValue () 
  (setq valuesList (list))
  (repeat flg.NumberingValuesCount 
    (setq valuesList (append valuesList (list (fl.numberingGetCurrentValue))))
  )
  valuesList
)

(defun fl.numberingGetCurrentValue () 
  12
)


(defun fl.numberingNextValue ())

(defun fl.getNumberingAutoValue (value) 
  (strcat (fl.leadingZeros value flC.NumberingLeadingZeros))
)

(defun fl.increaseNumberingValue (value) 
  (strcat (fl.leadingZeros value flC.NumberingLeadingZeros))
)

(defun fl.leadingZeros (value totalLength / zerosCount zeros) 
  (setq zerosCount (- totalLength (strlen (itoa value)))
        zeros      ""
  )
  (repeat zerosCount 
    (setq zeros (strcat zeros "0"))
  )
  (strcat zeros (itoa value))
)

(defun fl.list2string (lst del / str) 
  (setq str (car lst))
  (foreach itm (cdr lst) (setq str (strcat str del itm)))
  str
)

(defun fl.string2list (str del / len lst pos) 
  (setq len (1+ (strlen del)))
  (while (setq pos (vl-string-search del str)) 
    (setq lst (cons (substr str 1 pos) lst)
          str (substr str (+ pos len))
    )
  )
  (reverse (cons str lst))
)
(setq lst '("A" "B" "C" "D" "E" "F" "G" "H"))


(defun c:tttest (/ *error* dch dcl dcl-list des key-mode) 

  (defun *error* (msg) 
    (if (< 0 dch) (unload_dialog dch))
    (if (= 'file (type des)) (close des))
    (if (and (= 'str (type dcl)) (findfile dcl)) (vl-file-delete dcl))
    (if (and msg (not (wcmatch (strcase msg t) "*break,*cancel*,*exit*"))) 
      (princ (strcat "\nError: " msg))
    )
    (princ)
  )


  (if 
    (and 
      (setq dcl (vl-filename-mktemp nil nil ".dcl"))
      (setq des (open dcl "w"))
      (foreach str 
        '("listbox : dialog" "{" "    label = \"List Box Example\";" "    spacer;" 
          "    : row" "    {" "        : list_box" "        {" 
          "            key = \"lst\";" "            width = 35;" 
          "            height = 15;" "            fixed_width = true;" 
          "            fixed_height = true;" "            multiple_select = true;" 
          "        }" "        : column" "        {" 
          "            fixed_height = true;" 
          "            : button { key = \"top\";    label = \"Top\";    }" 
          "            : button { key = \"up\";     label = \"Up\" ;    }" 
          "            : button { key = \"down\";   label = \"Down\";   }" 
          "            : button { key = \"bottom\"; label = \"Bottom\"; }" "        }" 
          "    }" "    spacer;" "    ok_only;" "}"
         )
        (write-line str des)
      )
      (not (setq des (close des)))
      (< 0 (setq dch (load_dialog dcl)))
      (new_dialog "listbox" dch)
    )
    (progn 
      (defun dcl-list (key lst) 
        (start_list key)
        (foreach itm lst (add_list itm))
        (end_list)
      )
      (defun key-mode (idx lst / foo) 
        (setq foo (lambda (a b / r) (repeat a (setq r (cons (setq b (1- b)) r)))))
        (cond 
          ((or (null idx) (= (length idx) (length lst)))
           '(1 1 1 1)
          )
          ((equal idx (foo (length idx) (length idx)))
           '(1 1 0 0)
          )
          ((equal idx (foo (length idx) (length lst)))
           '(0 0 1 1)
          )
          ('(0 0 0 0))
        )
      )
      (dcl-list "lst" lst)
      (mapcar 'mode_tile '("top" "up" "down" "bottom") '(1 1 1 1))
      (mapcar 
        (function 
          (lambda (key fun) 
            (action_tile key 
                         (vl-prin1-to-string 
                           (list 'if 
                                 'idx
                                 (list 'apply 
                                       '
                                       '(lambda (idx lst) 
                                          (dcl-list "lst" lst)
                                          (set_tile "lst" 
                                                    (vl-string-trim "()" 
                                                                    (vl-princ-to-string 
                                                                      idx
                                                                    )
                                                    )
                                          )
                                          (mapcar 'mode_tile 
                                                  '("top" "up" "down" "bottom")
                                                  (key-mode idx lst)
                                          )
                                        )
                                       (list 'mapcar 
                                             '
                                             'set
                                             '
                                             '(idx lst)
                                             (list fun 'idx 'lst)
                                       )
                                 )
                           )
                         )
            )
          )
        )
        '("top" "up" "down" "bottom")
        '(LM:listtop LM:listup LM:listdown LM:listbottom)
      )
      (action_tile "lst" 
                   (vl-prin1-to-string 
                     '(progn
                       (setq idx (read (strcat "(" $value ")")))
                       (mapcar 'mode_tile 
                               '("top" "up" "down" "bottom")
                               (key-mode idx lst)
                       )
                      )
                   )
      )
      (start_dialog)
    )
    (princ "\nUnable to write/load/display dialog.")
  )
  (*error* nil)
  (princ)
)

(defun c:ttest (/ *error* dch dcl dcl-list des key-mode) 

  (defun *error* (msg) 
    (if (< 0 dch) (unload_dialog dch))
    (if (= 'file (type des)) (close des))
    (if (and (= 'str (type dcl)) (findfile dcl)) (vl-file-delete dcl))
    (if (and msg (not (wcmatch (strcase msg t) "*break,*cancel*,*exit*"))) 
      (princ (strcat "\nError: " msg))
    )
    (princ)
  )


  (if 
    (and 
      (setq dcl (vl-filename-mktemp nil nil ".dcl"))
      (setq des (open dcl "w"))
      (foreach str 
        '("listbox : dialog" "{" "    label = \"List Box Example\";" "    spacer;" 
          "    : row" "    {" "        : list_box" "        {" 
          "            key = \"lst\";" "            width = 35;" 
          "            height = 15;" "            fixed_width = true;" 
          "            fixed_height = true;" "            multiple_select = true;" 
          "        }" "        : column" "        {" 
          "            fixed_height = true;" 
          "            : button { key = \"top\";    label = \"Top\";    }" 
          "            : button { key = \"up\";     label = \"Up\" ;    }" 
          "            : button { key = \"down\";   label = \"Down\";   }" 
          "            : button { key = \"bottom\"; label = \"Bottom\"; }" "        }" 
          "    }" "    spacer;" "    ok_only;" "}"
         )
        (write-line str des)
      )
      (not (setq des (close des)))
      (< 0 (setq dch (load_dialog dcl)))
      (new_dialog "listbox" dch)
    )
    (progn 
      (defun dcl-list (key lst) 
        (start_list key)
        (foreach itm lst (add_list itm))
        (end_list)
      )
      (defun key-mode (idx lst / foo) 
        (setq foo (lambda (a b / r) (repeat a (setq r (cons (setq b (1- b)) r)))))
        (cond 
          ((or (null idx) (= (length idx) (length lst)))
           '(1 1 1 1)
          )
          ((equal idx (foo (length idx) (length idx)))
           '(1 1 0 0)
          )
          ((equal idx (foo (length idx) (length lst)))
           '(0 0 1 1)
          )
          ('(0 0 0 0))
        )
      )
      (dcl-list "lst" lst)
      (mapcar 'mode_tile '("top" "up" "down" "bottom") '(1 1 1 1))
      (mapcar 
        (function 
          (lambda (key fun) 
            (action_tile key 
                         (vl-prin1-to-string 
                           (list 'if 
                                 'idx
                                 (list 'apply 
                                       '
                                       '(lambda (idx lst) 
                                          (dcl-list "lst" lst)
                                          (set_tile "lst" 
                                                    (vl-string-trim "()" 
                                                                    (vl-princ-to-string 
                                                                      idx
                                                                    )
                                                    )
                                          )
                                          (mapcar 'mode_tile 
                                                  '("top" "up" "down" "bottom")
                                                  (key-mode idx lst)
                                          )
                                        )
                                       (list 'mapcar 
                                             '
                                             'set
                                             '
                                             '(idx lst)
                                             (list fun 'idx 'lst)
                                       )
                                 )
                           )
                         )
            )
          )
        )
        '("top" "up" "down" "bottom")
        '(LM:listtop LM:listup LM:listdown LM:listbottom)
      )
      (action_tile "lst" 
                   (vl-prin1-to-string 
                     '(progn
                       (setq idx (read (strcat "(" $value ")")))
                       (mapcar 'mode_tile 
                               '("top" "up" "down" "bottom")
                               (key-mode idx lst)
                       )
                      )
                   )
      )
      (start_dialog)
    )
    (princ "\nUnable to write/load/display dialog.")
  )
  (*error* nil)
  (princ)
)

;; List Box: List Up  -  Lee Mac
;; Shifts the items at the supplied indexes by one position to a lower index
;; idx - [lst] List of zero-based indexes
;; lst - [lst] List of items
;; Returns: [lst] List of ((idx) (lst)) following operation

(defun LM:listup (idx lst / foo) 
  (defun foo (cnt idx lst idx-out lst-out) 
    (cond 
      ((not (and idx lst))
       (list (reverse idx-out) (append (reverse lst-out) lst))
      )
      ((= 0 (car idx))
       (foo 
         (1+ cnt)
         (mapcar '1- (cdr idx))
         (cdr lst)
         (cons cnt idx-out)
         (cons (car lst) lst-out)
       )
      )
      ((= 1 (car idx))
       (foo 
         (1+ cnt)
         (mapcar '1- (cdr idx))
         (cons (car lst) (cddr lst))
         (cons cnt idx-out)
         (cons (cadr lst) lst-out)
       )
      )
      ((foo (1+ cnt) (mapcar '1- idx) (cdr lst) idx-out (cons (car lst) lst-out)))
    )
  )
  (foo 0 idx lst nil nil)
)

;; List Box: List Down  -  Lee Mac
;; Shifts the items at the supplied indexes by one position to a higher index
;; idx - [lst] List of zero-based indexes
;; lst - [lst] List of items
;; Returns: [lst] List of ((idx) (lst)) following operation

(defun LM:listdown (idx lst / bar foo len) 
  (setq len (length lst)
        foo (lambda (x) (- len x 1))
        bar (lambda (a b) (list (reverse (mapcar 'foo a)) (reverse b)))
  )
  (apply 'bar (apply 'LM:listup (bar idx lst)))
)

;; List Box: List Top  -  Lee Mac
;; Shifts the items at the supplied indexes to the lowest index
;; idx - [lst] List of zero-based indexes
;; lst - [lst] List of items
;; Returns: [lst] List of ((idx) (lst)) following operation

(defun LM:listtop (idx lst / i) 
  (setq i -1)
  (list 
    (mapcar '(lambda (x) (setq i (1+ i))) idx)
    (append (mapcar '(lambda (x) (nth x lst)) idx) (LM:removeitems idx lst))
  )
)

;; List Box: List Bottom -  Lee Mac
;; Shifts the items at the supplied indexes to the highest index
;; idx - [lst] List of zero-based indexes
;; lst - [lst] List of items
;; Returns: [lst] List of ((idx) (lst)) following operation

(defun LM:listbottom (idx lst / i) 
  (setq i (length lst))
  (list 
    (reverse (mapcar '(lambda (x) (setq i (1- i))) idx))
    (append (LM:removeitems idx lst) (mapcar '(lambda (x) (nth x lst)) idx))
  )
)

;; Remove Items  -  Lee Mac
;; Removes the items at the supplied indexes from a given list
;; idx - [lst] List of zero-based indexes
;; lst - [lst] List from which items are to be removed
;; Returns: [lst] List with items at the supplied indexes removed

(defun LM:removeitems (idx lst / i) 
  (setq i -1)
  (vl-remove-if '(lambda (x) (member (setq i (1+ i)) idx)) lst)
)