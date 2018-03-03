;;; private/cli/config.el -*- lexical-binding: t; -*-

(defvar xdg-data (getenv "XDG_DATA_HOME"))
(defvar xdg-bin (getenv "XDG_BIN_HOME"))
(defvar xdg-cache (getenv "XDG_CACHE_HOME"))
(defvar xdg-config (getenv "XDG_CONFIG_HOME"))

;; app/email
(after! mu4e
  (setq mu4e-bookmarks
        `(("\\\\Inbox" "Inbox" ?i)
          ("\\\\Draft" "Drafts" ?d)
          ("flag:unread AND \\\\Inbox" "Unread messages" ?u)
          ("flag:flagged" "Starred messages" ?s)
          ("date:today..now" "Today's messages" ?t)
          ("date:7d..now" "Last 7 days" ?w)
          ("mime:image/*" "Messages with images" ?p)))

  (setq smtpmail-stream-type 'starttls
        smtpmail-default-smtp-server "smtp.gmail.com"
        smtpmail-smtp-server "smtp.gmail.com"
        smtpmail-smtp-service 587)

  (set! :email "gmail.com"
    '((mu4e-sent-folder       . "/aliem13@gmail.com/Sent Mail")
      (mu4e-drafts-folder     . "/aliem13@gmail.com/Drafts")
      (mu4e-trash-folder      . "/aliem13@gmail.com/Trash")
      (mu4e-refile-folder     . "/aliem13@gmail.com/All Mail")
      (smtpmail-smtp-user     . "aliem13@gmail.com")
      (user-mail-address      . "aliem13@gmail.com")
      (mu4e-compose-signature . "---\nLor")))

  (set! :email "frenzart.com"
    '((mu4e-sent-folder       . "/lorenzo@frenzart.com/Sent Mail")
      (mu4e-drafts-folder     . "/lorenzo@frenzart.com/Drafts")
      (mu4e-trash-folder      . "/lorenzo@frenzart.com/Trash")
      (mu4e-refile-folder     . "/lorenzo@frenzart.com/All Mail")
      (smtpmail-smtp-user     . "lorenzo@frenzart")
      (user-mail-address      . "lorenzo@frenzart")
      (mu4e-compose-signature . "---\nLorenzo Giuliani"))
    t))

;; theme
(setq doom-theme 'doom-one)

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
(map! (:after clojure-mode
       :localleader
       :n  "e"  #'cider-enlighten-mode)
      (:leader
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
