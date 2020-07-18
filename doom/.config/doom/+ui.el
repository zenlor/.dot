;;; ~/.dot/doom/.doom.d/+ui.el -*- lexical-binding: t; -*-

;;
;; Customization
;;

; https://github.com/ar1a/dotfiles/blob/master/emacs/.doom.d/config.el#L68
(after! helm
  ;; I want backspace to go up a level, like ivy
  (add-hook! 'helm-find-files-after-init-hook
    (map!
     :map helm-find-files-map "<DEL>" #'helm-find-files-up-one-level)))


;;(add-to-list 'load-path "~/.doom.d/themes")

;; theme
(setq doom-theme 'doom-monokai-pro)

;; Fonts
(setq doom-font (font-spec :family "Iosevka Extended" :size 16)
      doom-variable-pitch-font (font-spec :family "Iosevka Sparkle")
      doom-unicode-font (font-spec :family "Iosevka Extended")
      doom-big-font (font-spec :family "Iosevka Extended" :size 22))
