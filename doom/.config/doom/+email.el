;;; +email.el -*- lexical-binding: t; -*-

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

(setq user-mail-address "lorenzo@giuliani.me"
      user-full-name    "Lorenzo Giuliani")

