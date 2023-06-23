; sciezka dostepu do skryptu
(setq PATH_SCRIPT "c:\\firelisp2\\")

; includowanie konfiguracji
(load (strcat PATH_SCRIPT "config\\config.lsp"))
(load (strcat PATH_SCRIPT "config\\consts.lsp"))

; serwisy
(load (strcat PATH_SCRIPT "app\\Services\\Layers.lsp"))


; kontrolery
(load (strcat PATH_SCRIPT "app\\Controllers\\Test.lsp"))



(print)
(princ "  88888888b dP  888888ba   88888888b    dP        dP .d88888b   888888ba   ")
(print)
(princ " 88        88  88    `8b  88           88        88 88.    \"'  88    `8b  ")
(print)
(princ "a88aaaa    88 a88aaaa8P' a88aaaa       88        88 `Y88888b. a88aaaa8P'   ")
(print)
(princ " 88        88  88   `8b.  88           88        88       `8b  88          ")
(print)
(princ " 88        88  88     88  88           88        88 d8'   .8P  88    ...loaded      ")
(print)
(princ " dP        dP  dP     dP  88888888P    88888888P dP  Y88888P   dP    version ")
(princ (strcat APP_VERSION " @ " APP_DATE))
(print)
