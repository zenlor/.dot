;;; private/janet/config.el -*- lexical-binding: t; -*-

(load! "inf-janet")

(use-package! janet-mode
  :mode "\\.janet\\'"
  :interpreter "janet"
  :hook (janet-mode . inf-janet-minor-mode)
  :config
  (when (featurep! :editor parinfer)
    (janet-mode . parinfer-mode))
  ;(when (featurep! :editor lispy)
  ;  (janet-mode . lispy-mode))
  (set-repl-handler! 'janet-mode #'inf-janet))
