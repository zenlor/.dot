;;; private/janet/config.el -*- lexical-binding: t; -*-

(load! "inf-janet")

(use-package! janet-mode
              :mode "\\.janet\\'"
              :interpreter "janet"
              :hook
              (janet-mode . inf-janet-minor-mode)
              (janet-mode . parinfer-mode)
              :config
              (set-repl-handler! 'janet-mode #'inf-janet))
