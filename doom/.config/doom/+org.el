;;; ~/.dot/doom/.doom.d/+org.el -*- lexical-binding: t; -*-

(setq langtool-java-classpath
      "/usr/share/languagetool:/usr/share/java/languagetool/*")

;; org-tree-slide font
(setq +org-present-text-scale 5)

;; Org
(let ((org-dir (expand-file-name "~/Documents/Notes/")))
  (setq org-directory org-dir)
  (setq deft-directory org-dir))
