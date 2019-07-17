;;; inf-clojure/config.el -*- lexical-binding: t; -*-


(load! "+joker")

(def-package! inf-clojure
  :hook (joker-mode . inf-clojure-minor-mode)
  :init
  (setq-local inf-clojure-generic-cmd "joker")
  :config)
