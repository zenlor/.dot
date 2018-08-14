;;; config.el -*- lexical-binding: t; -*-

(defvar xdg-data (getenv "XDG_DATA_HOME"))
(defvar xdg-bin (getenv "XDG_BIN_HOME"))
(defvar xdg-cache (getenv "XDG_CACHE_HOME"))
(defvar xdg-config (getenv "XDG_CONFIG_HOME"))

;;
;; User Interaface
;;

;; theme
(setq doom-theme 'doom-city-lights)

;; Markdown
(setq markdown-command "marked")

;; Fonts
(setq doom-font (font-spec :family "Iosevka" :size 14))
(setq doom-variable-font (font-spec :family "Iosevka" :size 14))
(setq doom-unicode-font (font-spec :family "DejaVu Sans Mono" :size 14))
(setq doom-big-font (font-spec :family "Iosevka" :size 16))


(load! "+bindings")
(load! "+email")
(load! "+org")
(load! "+lang")
