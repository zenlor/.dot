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

;; theme
(setq doom-theme 'doom-tomorrow-night)

;; Fonts
(setq doom-font (font-spec :family "Iosevka" :size 14))
(setq doom-variable-font (font-spec :family "Iosevka" :size 14))
(setq doom-unicode-font (font-spec :family "DejaVu Sans Mono" :size 14))
(setq doom-big-font (font-spec :family "Iosevka" :size 16))
