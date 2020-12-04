;;; private/janet/config.el -*- lexical-binding: t; -*-

(load! "inf-janet")

(use-package! janet-mode
  :mode "\\.janet\\'"
  :interpreter "janet"
  :hook
  (janet-mode . inf-janet-minor-mode)
  (when (featurep! :editor lispy)
    (janet-mode . lispy-mode))
  (when (featurep! :editor parinfer)
    (janet-mode . parinfer-mode))
  :config
  (set-repl-handler! 'janet-mode #'inf-janet))
