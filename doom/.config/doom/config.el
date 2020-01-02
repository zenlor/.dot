;;; config.el -*- lexical-binding: t; -*-

(defvar xdg-data (getenv "XDG_DATA_HOME"))
(defvar xdg-bin (getenv "XDG_BIN_HOME"))
(defvar xdg-cache (getenv "XDG_CACHE_HOME"))
(defvar xdg-config (getenv "XDG_CONFIG_HOME"))

(setenv "PATH"
        (concat
          (getenv "HOME") "/lib/bin" ";"
          (getenv "HOME") "/.local/bin" ";"
          (getenv "PATH")))

(add-to-list 'exec-path
                (concat (getenv "HOME") "/.local/bin"))
(add-to-list 'exec-path
                (concat (getenv "HOME") "/lib/bin"))

; load private-env if the file exists
(doom-load-envvars-file "~/.ssh/.env")

(load! "+bindings")
;(load! "+email")
(load! "+org")
(load! "+lang")
(load! "+ui")

