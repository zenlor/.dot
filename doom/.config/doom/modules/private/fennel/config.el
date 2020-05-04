;;
;; Fennel + Love2d
;;
;(add-to-list 'load-path "~/lib/src/gitlab.com/technomancy/fennel-mode")

(defun run-love ()
  (interactive)
  (run-lisp "love ."))

(use-package! fennel-mode
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


