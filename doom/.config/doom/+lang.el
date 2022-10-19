;;; ~/.dot/doom/.doom.d/+lang.el -*- lexical-binding: t; -*-

;; JS2-Mode
(with-eval-after-load "js2-mode"
  (setq-default
   js2-ignored-warnings '("msg.return.inconsistent" "msg.anon.no.return.value" "msg.no.return.value" "msg.no.side.effects"))
  (setq js2-strict-trailing-comma-warning nil
        js2-strict-missing-semi-warning nil
        js2-strict-code-has-no-side-effects nil
        js2-missing-semi-one-line-override nil))

;; Tide/TypeScript
(setq company-tooltip-align-annotations t)
;(setq tide-tsserver-executable "node_modules/typescript/bin/tsserver")

(add-hook 'typescript-mode-hook
          (lambda ()
            (local-set-key (kbd "M-j") 'c-indent-new-comment-line)
            (local-set-key (kbd "RET") 'c-indent-new-comment-line)
            (add-hook 'before-save-hook 'tide-format-before-save)
            eldoc-mode
            flycheck-mode))

;; Markdown command
(setq markdown-command "marked")

;; Clojure+Cider
(map! :localleader
      (:map (clojure-mode-map clojurescript-mode-map clojurec-mode-map)
       "e g" #'cider-pprint-eval-last-sexp-to-comment))
