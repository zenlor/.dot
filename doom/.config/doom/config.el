;;; config.el -*- lexical-binding: t; -*-

(defvar xdg-data (getenv "XDG_DATA_HOME"))
(defvar xdg-bin (getenv "XDG_BIN_HOME"))
(defvar xdg-cache (getenv "XDG_CACHE_HOME"))
(defvar xdg-config (getenv "XDG_CONFIG_HOME"))

(setenv "PATH"
        (concat
          (getenv "HOME") "/lib/bin" ":"
          (getenv "HOME") "/.local/bin" ":"
          (getenv "HOME") "/.luarocks/bin" ":"
          (getenv "PATH")))

(add-to-list 'exec-path
                (concat (getenv "HOME") "/.local/bin"))
(add-to-list 'exec-path
                (concat (getenv "HOME") "/lib/bin"))
(add-to-list 'exec-path
                (concat (getenv "HOME") "/.luarocks/bin"))

(load! "+bindings")
;(load! "+email")
(load! "+org")
(load! "+lang")
(load! "+ui")

