;;; private/cli/config.el -*- lexical-binding: t; -*-

;; app/email
(pcase (system-name)
       ("cli.mb") ;; (or "cli.mb" "meila")
       (after! 'mu4e
               (setq smtpmail-stream-type 'starttls
                     smtpmail-default-smtp-server "smtp.office365.com"
                     smtpmail-smtp-server "smtp.office365.com"
                     smtpmail-smtp-service 587)

               (set! :email "outlook"
                 '((mu4e-sent-folder       . "/Sent Items")
                   (mu4e-drafts-folder     . "/Drafts")
                   (mu4e-trash-folder      . "/Trash")
                   (mu4e-refile-folder     . "/INBOX")
                   (smtpmail-smtp-user     . "lorenzo@mobilebridge.com")
                   (user-mail-address      . "lorenzo@mobilebridge.com")
                   (mu4e-compose-signature . "---\nLorenzo")))))

;; (setq doom-theme 'doom-molokai)
;; (setq doom-theme 'doom-solarized-light)
(setq doom-theme 'doom-tomorrow-night)


;; host-specific settings
(pcase (system-name)
  ("cli.mb" ;; Low-dpi settings
   (setq doom-font (font-spec :family "Iosevka" :size 14))
   (setq doom-variable-font (font-spec :family "Iosevka" :size 14))
   (setq doom-unicode-font (font-spec :family "DejaVu Sans Mono" :size 14)))
  ("meila" ;; HiDPI (1440p monitor)
   (setq doom-font (font-spec :family "Monoid" :size 14))
   (setq doom-variable-font (font-spec :family "Monoid" :size 14))
   (setq doom-unicode-font (font-spec :family "DejaVu Sans Mono" :size 14))))

;; Custom bindings
(map! (:leader
        (:desc "Yank" :n "y" #'counsel-yank-pop)
        (:desc "buffer" :prefix "b"
               :desc "Delete buffer" :n "d" #'doom/kill-this-buffer))
      :nv "U" 'backward-up-list
      :nv "R" 'down-list
      :nv "L" 'sp-forward-sexp
      :nv "H" 'sp-backward-sexp

      ;; Easier window navigation
      :n "C-h"   #'evil-window-left
      :n "C-j"   #'evil-window-down
      :n "C-k"   #'evil-window-up
      :n "C-l"   #'evil-window-right)
