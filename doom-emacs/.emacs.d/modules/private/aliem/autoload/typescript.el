;;; private/aliem/autoload/typescript.el
;;; Code:

(add-hook 'typescript-mode-hook
          (lambda ()
            (local-set-key "\M-j" 'js2-line-break)))
