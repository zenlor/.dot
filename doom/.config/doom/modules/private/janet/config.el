;;; private/janet/config.el -*- lexical-binding: t; -*-

(load! "inf-janet")

(use-package! janet-mode
  :mode "\\.janet\\'"
  :interpreter "janet"
  :hook ((inf-janet-minor-mode
          parinfer-mode
          lispy-mode
          ) . janet-mode)
  :config
  (set-repl-handler! 'janet-mode #'inf-janet))
