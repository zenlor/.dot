;;;  -*- lexical-binding: t; -*-

;;; +theme|doom-nordless.el --- Nordless theme

(require 'doom-themes)

(defgroup doom-nordless-theme nil
  "Options for doom-themes"
  :group 'doom-themes)

(defcustom doom-nordless-brighter-modeline nil
  "If non-nil, more vivid colors will be used to style the mode-line."
  :group 'doom-nordless-theme
  :type 'boolean)

(defcustom doom-nordless-brighter-comments nil
  "If non-nil, comments will be highlighted in more vivid colors."
  :group 'doom-nordless-theme
  :type 'boolean)

(defcustom doom-nordless-comment-bg doom-nordless-brighter-comments
  "If non-nil, comments will have a subtle, darker background. Enhancing their
legibility."
  :group 'doom-nordless-theme
  :type 'boolean)

(defcustom doom-nordless-padded-modeline doom-themes-padded-modeline
  "If non-nil, adds a 4px padding to the mode-line. Can be an integer to
determine the exact padding."
  :group 'doom-nordless-theme
  :type '(or integer boolean))

(defcustom doom-nordless-region-highlight t
  "Determines the selection highlight style. Can be 'frost, 'snowstorm or t
(default)."
  :group 'doom-nordless-theme
  :type 'symbol)

;;
;; Color reference:
;;
;;
(let (nord0  "#2E3440") ; polar night
     (nord1  "#3B4252")
     (nord2  "#434C5E")
     (nord3  "#4C566A")
     (nord4  "#D8DEE9") ; snow storm
     (nord5  "#E5E9F0")
     (nord6  "#ECEFF4")
     (nord7  "#8FBCBB") ; frost
     (nord8  "#88C0D0")
     (nord9  "#81A1C1")
     (nord10 "#5E81AC")
     (nord11 "#BF616A") ; aurora
     (nord12 "#D08770")
     (nord13 "#EBCB8B")
     (nord14 "#A3BE8C")
     (nord15 "#B48EAD"))

(def-doom-theme doom-nordless
  "A dark nord/less theme."

  ;; name        default   256       16
  ((bg         '("#323334" nil       nil))
   (bg-alt     '("#222224" nil       nil))
   (base0      '("#000000" "black"   "black"))
   (base1      '("#1e1e1e" "#1e1e1e" "brightblack"))
   (base2      '("#2e2e2e" "#2e2e2e" "brightblack"))
   (base3      '("#262626" "#262626" "brightblack"))
   (base4      '("#3f3f3f" "#3f3f3f" "brightblack"))
   (base5      '("#525252" "#525252" "brightblack"))
   (base6      '("#6b6b6b" "#6b6b6b" "brightblack"))
   (base7      '("#979797" "#979797" "brightblack"))
   (base8      '("#dfdfdf" "#dfdfdf" "white"))
   (fg         '("#eceff4" "#dfdfdf" "white"))
   (fg-alt     '("#727269" "#bfbfbf" "brightwhite"))

   (grey       base4)
   (red        '("#C16069" "#ff6655" "red"))
   (orange     '("#D2876D" "#dd8844" "brightred"))
   (green      '("#A2BF8A" "#99bb66" "green"))
   (teal       '("#8EBCBB" "#44b9b1" "brightgreen"))
   (yellow     '("#ECCC87" "#ECBE7B" "yellow"))
   (blue       '("#80A0C2" "#51afef" "brightblue"))
   (dark-blue  '("#5C748E" "#2257A0" "blue"))
   (magenta    '("#B58DAE" "#c678dd" "magenta"))
   (violet     '("#5D80AE" "#a9a1e1" "brightmagenta"))
   (cyan       '("#86C0D1" "#46D9FF" "brightcyan"))
   (dark-cyan  '("#507681" "#5699AF" "cyan"))

   ;; face categories -- required for all themes
   (highlight      blue)
   (vertical-bar   (doom-darken base1 0.2))
   (selection      dark-blue)
   (builtin        teal)
   (comments       (if doom-nordless-brighter-comments dark-cyan (doom-lighten base5 0.2)))
   (doc-comments   (doom-lighten (if doom-nordless-brighter-comments dark-cyan base5) 0.25))
   (constants      magenta)
   (functions      teal)
   (keywords       blue)
   (methods        teal)
   (nordlesstors      blue)
   (type           yellow)
   (strings        green)
   (variables      (doom-lighten magenta 0.5))
   (numbers        magenta)
   (region         base4)
   (error          red)
   (warning        yellow)
   (success        green)
   (vc-modified    orange)
   (vc-added       green)
   (vc-deleted     red)

   ;; custom categories
   (hidden     `(,(car bg) "black" "black"))
   (-modeline-bright doom-nordless-brighter-modeline)
   (-modeline-pad
    (when doom-nordless-padded-modeline
      (if (integerp doom-nordless-padded-modeline) doom-nordless-padded-modeline 4)))

   (modeline-fg     nil)
   (modeline-fg-alt base5)

   (modeline-bg
    (if -modeline-bright
        (doom-darken blue 0.475)
      `(,(doom-darken (car bg-alt) 0.15) ,@(cdr base0))))
   (modeline-bg-l
    (if -modeline-bright
        (doom-darken blue 0.45)
      `(,(doom-darken (car bg-alt) 0.1) ,@(cdr base0))))
   (modeline-bg-inactive   (doom-darken bg-alt 0.1))
   (modeline-bg-inactive-l `(,(car bg-alt) ,@(cdr base1))))

  ;; --- extra faces ------------------------
  (
   ((line-number &override) :foreground fg-alt)
   ((line-number-current-line &override) :foreground fg)

   (font-lock-comment-face
    :foreground comments
    :background (if doom-nordless-comment-bg (doom-lighten bg 0.05)))
   (font-lock-doc-face
    :inherit 'font-lock-comment-face
    :foreground doc-comments)

   (doom-modeline-bar :background (if -modeline-bright modeline-bg highlight))

   (mode-line
    :background modeline-bg :foreground modeline-fg
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg)))
   (mode-line-inactive
    :background modeline-bg-inactive :foreground modeline-fg-alt
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive)))
   (mode-line-emphasis
    :foreground (if -modeline-bright base8 highlight))

   (solaire-mode-line-face
    :inherit 'mode-line
    :background modeline-bg-l
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-l)))
   (solaire-mode-line-inactive-face
    :inherit 'mode-line-inactive
    :background modeline-bg-inactive-l
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive-l)))))

(add-to-list 'default-frame-alist '(ns-appearance . dark))

(push '(doom-nordless . t) +doom-solaire-themes)

;;; +theme|doom-nordless.el ends here
