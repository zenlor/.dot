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
(setq doom-theme 'gruvbox-light-soft)

;; Fonts
(let* ((my-font "Operator Mono Book")
       (font-size 16)
       (font-size-big (+ 4 font-size)))
  (setq doom-font           (font-spec :family my-font :size font-size))
  (setq doom-variable-font  (font-spec :family my-font :size font-size))
  (setq doom-unicode-font   (font-spec :family my-font :size font-size))
  (setq doom-big-font       (font-spec :family my-font :size font-size-big)))
