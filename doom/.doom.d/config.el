;;; private/cli/config.el -*- lexical-binding: t; -*-

(load! "+bindings")

(defvar xdg-data (getenv "XDG_DATA_HOME"))
(defvar xdg-bin (getenv "XDG_BIN_HOME"))
(defvar xdg-cache (getenv "XDG_CACHE_HOME"))
(defvar xdg-config (getenv "XDG_CONFIG_HOME"))

;; app/email
(after! mu4e
  (setq mu4e-maildir (expand-file-name "~/Mail"))
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

  (set-email-account! "gmail"
    '((mu4e-sent-folder       . "/gmail/sent")
      (mu4e-drafts-folder     . "/gmail/drafts")
      (mu4e-trash-folder      . "/gmail/trash")
      (mu4e-refile-folder     . "/gmail/archive")
      (smtpmail-smtp-user     . "aliem13@gmail.com")
      (user-mail-address      . "aliem13@gmail.com")
      (mu4e-compose-signature . "---\nLor")))

  (set-email-account! "frenz"
    '((mu4e-sent-folder       . "/frenz/sent")
      (mu4e-drafts-folder     . "/frenz/drafts")
      (mu4e-trash-folder      . "/frenz/trash")
      (mu4e-refile-folder     . "/frenz/archive")
      (smtpmail-smtp-user     . "lorenzo@frenzart.com")
      (user-mail-address      . "lorenzo@frenzart.com")
      (mu4e-compose-signature . "---\nLorenzo Giuliani")))

  (set-email-account! "work"
    '((mu4e-sent-folder       . "/work/sent")
      (mu4e-drafts-folder     . "/work/drafts")
      (mu4e-trash-folder      . "/work/trash")
      (mu4e-refile-folder     . "/work/archive")
      (smtpmail-smtp-user     . "lorenzo@mobilebridge.com")
      (user-mail-address      . "lorenzo@mobilebridge.com")
      (mu4e-compose-signature . "---\nLorenzo Giuliani"))))

;; theme
(setq doom-theme 'doom-dracula)

;; Org
(setq +org-dir (expand-file-name "~/Documents/org/"))

;; Markdown
;; (add-hook 'markdown-mode-hook #')
(setq markdown-command "marked")

;; host-specific settings
(setq doom-font (font-spec :family "Iosevka" :size 14))
(setq doom-variable-font (font-spec :family "Iosevka" :size 14))
(setq doom-unicode-font (font-spec :family "DejaVu Sans Mono" :size 14))
(setq doom-big-font (font-spec :family "Iosevka" :size 16))

;; org-tree-slide font
(setq +org-present-text-scale 5)

(setq user-mail-address "lorenzo@giuliani.me"
      user-full-name    "Lorenzo Giuliani")

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
(setq tide-tsserver-executable "node_modules/typescript/bin/tsserver")

(add-hook 'typescript-mode-hook
          (lambda ()
            (local-set-key (kbd "M-j") 'c-indent-new-comment-line)
            (local-set-key (kbd "RET") 'c-indent-new-comment-line)
            (add-hook 'before-save-hook 'tide-format-before-save)
            eldoc-mode
            flycheck-mode))


;;
;; Extra packages
;;

;;
;; Terraform
;;
(def-package! terraform-mode
  :mode "\\.tf$"
  :mode "\\.tfvars$"
  :config
  (custom-set-variables
   '(terraform-indent-level 4)))


;;
;; Systemd
;;
(def-package! systemd-mode
  :mode "\\.service$"
  :config
  (set! :company-backend 'systemd-mode '(systemd-mode-hook)))

(require 'evil-mu4e)

;;
;; Carp Lang
;;
(add-to-list 'load-path "~/lib/src/github.com/carp-lang/Carp/emacs")
(def-package! carp-mode
  :mode "\\.carp$"
  :init)

(def-package! inf-carp-mode
  :after 'carp-mode)

