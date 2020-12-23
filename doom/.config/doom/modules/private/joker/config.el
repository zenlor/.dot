;;; inf-clojure/config.el -*- lexical-binding: t; -*-


(load! "+joker")

(use-package! inf-clojure
  :hook
  (joker-mode . inf-clojure-minor-mode)
  :config
  (when (featurep! :editor lispy)
    (joker-mode . lispy-mode))
  (when (featurep! :editor parinfer)
    (joker-mode . parinfer-mode))
  :init
  (setq-local inf-clojure-generic-cmd "joker"))
