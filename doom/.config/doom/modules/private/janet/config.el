;;; private/janet/config.el -*- lexical-binding: t; -*-

(def-package! janet-mode
              :mode "\\.janet\\'"
              :interpreter "janet"
              :hook (janet-mode . parinfer-mode))
