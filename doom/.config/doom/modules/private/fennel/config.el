;;
;; Fennel + Love2d
;;
;(add-to-list 'load-path "~/lib/src/gitlab.com/technomancy/fennel-mode")


(defun run-love ()
  (interactive)
  (run-lisp "love ."))

(use-package! fennel-mode
  :mode "\\.fnl$"
  :interpreter "fennel"
  :config
  ;; By default fennel-mode moves focus to the \*inferior-lisp\* buffer
  ;; setting `fennel-mode-switch-to-repl-after-reload' to nil prevents this
  (customize-save-variable 'fennel-mode-switch-to-repl-after-reload nil)

  ;; (customize-save-variable 'fennel-program
  ;;   (concat (executable-find "fennel") " --correlate --repl"))


  (map! :localleader
        (:map fennel-mode-map
         "'" #'run-love))

  (when (featurep! :editor lispy)
    (add-hook 'fennel-mode 'lispy-mode))
  (when (featurep! :editor parinfer)
    (add-hook 'fennel-mode 'parinfer-mode)))
