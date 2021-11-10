;;; private/janet/config.el -*- lexical-binding: t; -*-

(use-package! janet-mode
  :mode "\\.janet\\'"
  :interpreter "janet"
  :hook ((inf-janet-minor-mode
          parinfer-mode
          lispy-mode)
         . janet-mode)
  :config
  (setq inf-janet-program '("localhost" . 5555))
  (set-repl-handler! 'janet-mode #'inf-janet))
