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

;;
;; Extra packages
;;

;;
;; Systemd
;;
(def-package! systemd-mode
  :mode "\\.service$"
  :config
  (set! :company-backend 'systemd-mode '(systemd-mode-hook)))


;;
;; Carp Lang
;;
(add-to-list 'load-path "~/lib/src/github.com/carp-lang/Carp/emacs")

(def-package! carp-mode
  :mode "\\.carp$"
  :init)


;;
;; Fennel + Love2d
;;
(add-to-list 'load-path "~/lib/src/gitlab.com/technomancy/fennel-mode")

(defun run-love ()
  (interactive)
  (run-lisp "love ."))

(def-package! fennel-mode
  :mode "\\.fnl$"
  :hook (fennel-mode . lispy-mode)
  :interpreter "fennel"
  :config
  ;; By default fennel-mode moves focus to the \*inferior-lisp\* buffer
  ;; setting `fennel-mode-switch-to-repl-after-reload' to nil prevents this
  (customize-save-variable 'fennel-mode-switch-to-repl-after-reload nil)

  (map! :localleader
        (:map fennel-mode-map
          "'" #'run-love)))
