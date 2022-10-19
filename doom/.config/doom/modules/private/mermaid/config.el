;;; private/mermaid/config.el -*- lexical-binding: t; -*-

(use-package! mermaid-mode
  :mode "\\.mmd\\'"
  :config
  (map! :localleader
        (:map mermaid-mode-map
         "c" 'mermaid-compile
         "f" 'mermaid-compile-file
         "b" 'mermaid-compile-buffer
         "r" 'mermaid-compile-region
         "o" 'mermaid-open-browser
         "d" 'mermaid-open-doc)))
