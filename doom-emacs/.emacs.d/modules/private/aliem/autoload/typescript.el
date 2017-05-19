;;; typescript.el --- Typescript private config
;;; Code:

(add-hook 'typescript-mode-hook
          (lambda ()
            (local-set-key "\M-j" 'js2-line-break)))

;; formats the buffer before saving
(add-hook 'before-save-hook 'tide-format-before-save)

(defun setup-tide-mode ()
  "Setup Tide."
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1))
(add-hook 'typescript-mode-hook #'setup-tide-mode)


;;; typescript.el ends here
