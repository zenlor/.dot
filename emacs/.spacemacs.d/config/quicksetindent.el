;;; quicksetindent.el --- Quickly and easily sets your desired indentation level in Emacs.
;;
;; Copyright (c) 2016 SteveJobzniak
;;
;; Author: SteveJobzniak
;; Version: 1.0
;; URL: https://github.com/SteveJobzniak/emacs-quicksetindent
;;
;; This file is not part of GNUEmacs.
;;
;; License: Public Domain, for the good of mankind.
;;
;;; Commentary:
;;
;; Quickly and easily sets either the global indentation defaults or the
;; local values for the current buffer. Supports pretty much every programming
;; language under the sun, and saves you from the massive hassle of
;; setting all of their different indentation variables manually!
;;
;; Usage:
;;
;;  (require 'quicksetindent)
;;
;;  Here are several usage examples, all of which set the global defaults:
;;
;;  ;; global, 4-space indents, only spaces (no tabs), 4-space tab display width
;;  (quicksetindent/set-indentation t 4)
;;  ;; global, 4-space indents, use tabs and spaces, 4-space tab display width
;;  (quicksetindent/set-indentation t 4 t)
;;  ;; global, 8-space indents, use tabs and spaces, 2-space tab display width
;;  (quicksetindent/set-indentation t 8 t 2)
;;  ;; global, 8-space indents, only spaces (no tabs), 2-space tab display width
;;  (quicksetindent/set-indentation t 8 nil 2)
;;
;;  To instead only set local values for current buffer, set the first arg to nil:
;;
;;  ;; local, 4-space indents, only spaces (no tabs), 4-space tab display width
;;  (quicksetindent/set-indentation nil 4)
;;  ;; local, 4-space indents, use tabs and spaces, 4-space tab display width
;;  (quicksetindent/set-indentation nil 4 t)
;;  ;; local, 8-space indents, use tabs and spaces, 2-space tab display width
;;  (quicksetindent/set-indentation nil 8 t 2)
;;  ;; local, 8-space indents, only spaces (no tabs), 2-space tab display width
;;  (quicksetindent/set-indentation nil 8 nil 2)
;;
;;  Here's the config most people want (sets global defaults to 4 spaces, no tabs):
;;
;;  (require 'quicksetindent)
;;  (quicksetindent/set-indentation t 4)
;;  (setq-default php-mode-coding-style 'pear)
;;
;;  The PHP style is only necessary if you want to code in PHP. See note below.
;;
;;
;; Special note about PHP and a few other languages and modes:
;;
;;  Users of php-mode who want a global indentation override will have to set it
;;  manually via php-mode-hook, meaning *after* php-mode has loaded. That's
;;  necessary because php-mode automatically loads a "style" profile at startup,
;;  which overrides your global indentation setting. The same is true for a few
;;  other programming languages too.
;;
;;  Here's an example of a PHP hook:
;;   (add-hook 'php-mode-hook
;;             (lambda () (setq indent-tabs-mode nil
;;                               tab-width 4
;;                               c-basic-offset 4)))
;;
;;  However, be aware that hooks will conflict with modules like EditorConfig!
;;  If you just want the most common PHP code style (4-space indents, no tabs),
;;  it's better to just set the PHP style to "pear", which achieves exactly that!
;;  And the benefit of using a style is that it won't interfere with EditorConfig.
;;
;;  To enable PHP's "pear" style, just use the following line:
;;   (setq-default php-mode-coding-style 'pear)
;;
;; Special notes (Lisp):
;;
;;  Lisp language indentation can't be overridden without disabling its
;;  smart formatter and forcing all Lisp indents to the exact same depth!
;;  Therefore, the main function won't affect Lisp indentation.
;;
;;  If you REALLY want to enforce a certain indentation depth for Lisp files,
;;  you must manually call the following function in your config (with your
;;  own <set_defaults> and <indent_spaces> values, of course):
;;   (quicksetindent/set-var-helper <set_defaults> 'lisp-indent-offset <indent_spaces>)"
;;
;;
;;; Code:

(defun quicksetindent/set-var-helper (set_defaults var_name var_value)
  "Easily set a variable's value globally or locally.

SET_DEFAULTS: t to set a variable's global default,
  nil to set its local value for current buffer only.

VAR_NAME: The variable to change.

VAR_VALUE: Its new value."
  (if set_defaults
      (set-default var_name var_value)
    (set (make-local-variable var_name) var_value))
  )

(defun quicksetindent/set-indentation (set_defaults indent_spaces &optional use_tabs tab_width)
  "Quickly and easily sets your desired indentation level in Emacs.

This will set either the global indentation defaults or the
local values for the current buffer.

Supports pretty much every programming language under the sun,
and saves you from the massive hassle of setting all of their
different indentation variables manually!

Arguments:
SET_DEFAULTS: t to set global defaults, nil to set values only
  for current buffer.
INDENT_SPACES: the width of an indentation level, in spaces.

Optional arguments:
USE_TABS: t to use tabs and spaces,
  or nil (default) to use only spaces.
TAB_WIDTH: the width of a tab character, for display and
  indentation purposes. will be set to the same width as
  indent_spaces by default, if tab_width option omitted.

Special notes (PHP, and a few other languages):
Users of php-mode who want a global indentation override
will have to set it manually via php-mode-hook, meaning
*after* php-mode has loaded. That's necessary because
php-mode automatically loads a \"style\" profile at startup
which overrides your global indentation setting.
The same is true for a few other programming languages too.

Special notes (Lisp):
Lisp language indentation can't be overridden without
disabling its smart formatter and forcing all Lisp indents
to the exact same depth! Therefore, this function won't
affect Lisp indentation.
If you REALLY want to enforce a certain indentation depth
for Lisp files, you must manually call the following
function in your config (with your own <set_defaults> and
<indent_spaces> values, of course):
  (quicksetindent/set-var-helper <set_defaults> 'lisp-indent-offset <indent_spaces>)"

  ;; Use the same tab width as indentation spaces if no tab width provided.
  (unless tab_width (setq tab_width indent_spaces))

  ;; ---- Set general indentation formatting preferences. ----

  ;; Set indentation mode to either mixed tabs and spaces (t) or only spaces
  ;; (nil). There is unfortunately no way to tell Emacs to completely disable
  ;; spaces, since Emacs uses spaces to fill in columns to reach its exact
  ;; alignment offsets. But tab fans can set tab width and indentation spaces to
  ;; the same number, to reduce the amount of spaces you will get in your code.
  (if (bound-and-true-p use_tabs)
      (quicksetindent/set-var-helper set_defaults 'indent-tabs-mode t)
    (quicksetindent/set-var-helper set_defaults 'indent-tabs-mode nil))

  ;; Set the display width of a tab character, expressed in number of spaces.
  (quicksetindent/set-var-helper set_defaults 'tab-width tab_width)

  ;; If evil-mode is installed, set how many spaces its shift operator affects.
  (when (featurep 'evil)
    (quicksetindent/set-var-helper set_defaults 'evil-shift-width indent_spaces))

  ;; ---- Set indentation styles for certain languages that need it. ----

  ;; [web-mode: use style "2" = "all lines will be indented"]
  (quicksetindent/set-var-helper set_defaults 'web-mode-indent-style 2)
  ;; [nxml-mode: how many spaces to indent attributes when spread across lines]
  (quicksetindent/set-var-helper set_defaults 'nxml-attribute-indent 2)

  ;; ---- Set the indentation sizes for all supported languages. ----
  ;; Above each section is a list of modes confirmed to use that variable.

  ;; [default emacs indentation variable which some modes use for indentation if their own isn't set]
  (quicksetindent/set-var-helper set_defaults 'standard-indent indent_spaces)
  ;; [awk-mode; c++-mode; c-mode; groovy-mode; idl-mode; java-mode; objc-mode; php-mode; pike-mode]
  (quicksetindent/set-var-helper set_defaults 'c-basic-offset indent_spaces)
  ;; [cmake-mode]
  (quicksetindent/set-var-helper set_defaults 'cmake-tab-width indent_spaces)
  ;; [coffee-mode]
  (quicksetindent/set-var-helper set_defaults 'coffee-tab-width indent_spaces)
  ;; [cperl-mode]
  (quicksetindent/set-var-helper set_defaults 'cperl-indent-level indent_spaces)
  ;; [crystal-mode]
  (quicksetindent/set-var-helper set_defaults 'crystal-indent-level indent_spaces)
  ;; [css-mode; scss-mode]
  (quicksetindent/set-var-helper set_defaults 'css-indent-offset indent_spaces)
  ;; [emacs-lisp-mode; lisp-mode]
  ;; NOTE: Lisp indentation can't be overridden without disabling its smart
  ;; formatter! By setting a value, you would force all Lisp indents to the
  ;; exact same depth. If you REALLY want to do this, MANUALLY call this
  ;; function in your config:
  ;;   (quicksetindent/set-var-helper set_defaults 'lisp-indent-offset indent_spaces)
  ;; [erlang-mode]
  (quicksetindent/set-var-helper set_defaults 'erlang-indent-level indent_spaces)
  ;; [ess-mode]
  (quicksetindent/set-var-helper set_defaults 'ess-indent-offset indent_spaces)
  ;; [haskell-mode]
  (quicksetindent/set-var-helper set_defaults 'haskell-indent-spaces indent_spaces)
  (quicksetindent/set-var-helper set_defaults 'haskell-indent-offset indent_spaces)
  (quicksetindent/set-var-helper set_defaults 'haskell-indentation-layout-offset indent_spaces)
  (quicksetindent/set-var-helper set_defaults 'haskell-indentation-left-offset indent_spaces)
  (quicksetindent/set-var-helper set_defaults 'haskell-indentation-starter-offset indent_spaces)
  (quicksetindent/set-var-helper set_defaults 'haskell-indentation-where-post-offset indent_spaces)
  (quicksetindent/set-var-helper set_defaults 'haskell-indentation-where-pre-offset indent_spaces)
  (quicksetindent/set-var-helper set_defaults 'shm-indent-spaces indent_spaces)
  ;; [jade-mode]
  (quicksetindent/set-var-helper set_defaults 'jade-tab-width indent_spaces)
  ;; [js-jsx-mode; js-mode; json-mode]
  (quicksetindent/set-var-helper set_defaults 'js-indent-level indent_spaces)
  ;; [js-jsx-mode; js2-jsx-mode; sgml-mode]
  (quicksetindent/set-var-helper set_defaults 'sgml-basic-offset indent_spaces)
  ;; [js2-jsx-mode; js2-mode]
  (quicksetindent/set-var-helper set_defaults 'js2-basic-offset indent_spaces)
  ;; [js3-mode]
  (quicksetindent/set-var-helper set_defaults 'js3-indent-level indent_spaces)
  ;; [julia-mode]
  (quicksetindent/set-var-helper set_defaults 'julia-indent-offset indent_spaces)
  ;; [latex-mode]
  (quicksetindent/set-var-helper set_defaults 'tex-indent-basic indent_spaces)
  (quicksetindent/set-var-helper set_defaults 'tex-indent-item indent_spaces)
  (quicksetindent/set-var-helper set_defaults 'tex-indent-arg (* 2 indent_spaces))
  ;; [latex-mode - special variables for AUCTeX package]
  (quicksetindent/set-var-helper set_defaults 'TeX-brace-indent-level indent_spaces)
  (quicksetindent/set-var-helper set_defaults 'LaTeX-indent-level indent_spaces)
  (quicksetindent/set-var-helper set_defaults 'LaTeX-item-indent (- indent_spaces))
  ;; [livescript-mode]
  (quicksetindent/set-var-helper set_defaults 'livescript-tab-width indent_spaces)
  ;; [lua-mode]
  (quicksetindent/set-var-helper set_defaults 'lua-indent-level indent_spaces)
  ;; [matlab-mode]
  (quicksetindent/set-var-helper set_defaults 'matlab-indent-level indent_spaces)
  ;; [mustache-mode]
  (quicksetindent/set-var-helper set_defaults 'mustache-basic-offset indent_spaces)
  ;; [nginx-mode]
  (quicksetindent/set-var-helper set_defaults 'nginx-indent-level indent_spaces)
  ;; [nxml-mode]
  (quicksetindent/set-var-helper set_defaults 'nxml-child-indent indent_spaces)
  ;; [octave-mode]
  (quicksetindent/set-var-helper set_defaults 'octave-block-offset indent_spaces)
  ;; [perl-mode]
  (quicksetindent/set-var-helper set_defaults 'perl-indent-level indent_spaces)
  ;; [ps-mode]
  (quicksetindent/set-var-helper set_defaults 'ps-mode-tab indent_spaces)
  ;; [puppet-mode]
  (quicksetindent/set-var-helper set_defaults 'puppet-indent-level indent_spaces)
  ;; [python-mode]
  ;; NOTE: We must set python vars this way for compatibility with EditorConfig!
  (quicksetindent/set-var-helper set_defaults (if (or (> emacs-major-version 24)
                                                      (and (= emacs-major-version 24)
                                                           (>= emacs-minor-version 3)))
                                                  'python-indent-offset
                                                'python-indent) indent_spaces)
  (quicksetindent/set-var-helper set_defaults 'py-indent-offset indent_spaces)
  ;; [ruby-mode]
  (quicksetindent/set-var-helper set_defaults 'ruby-indent-level indent_spaces)
  ;; [rust-mode]
  (quicksetindent/set-var-helper set_defaults 'rust-indent-offset indent_spaces)
  ;; [scala-mode]
  (quicksetindent/set-var-helper set_defaults 'scala-indent:step indent_spaces)
  ;; [sh-mode]
  (quicksetindent/set-var-helper set_defaults 'sh-basic-offset indent_spaces)
  (quicksetindent/set-var-helper set_defaults 'sh-indentation indent_spaces)
  ;; [slim-mode]
  (quicksetindent/set-var-helper set_defaults 'slim-indent-offset indent_spaces)
  ;; [tcl-mode]
  (quicksetindent/set-var-helper set_defaults 'tcl-indent-level indent_spaces)
  (quicksetindent/set-var-helper set_defaults 'tcl-continued-indent-level indent_spaces)
  ;; [typescript-mode]
  (quicksetindent/set-var-helper set_defaults 'typescript-indent-level indent_spaces)
  ;; [web-mode]
  (quicksetindent/set-var-helper set_defaults 'web-mode-markup-indent-offset indent_spaces)
  (quicksetindent/set-var-helper set_defaults 'web-mode-css-indent-offset indent_spaces)
  (quicksetindent/set-var-helper set_defaults 'web-mode-code-indent-offset indent_spaces)
  (quicksetindent/set-var-helper set_defaults 'web-mode-block-padding indent_spaces)
  (quicksetindent/set-var-helper set_defaults 'web-mode-script-padding indent_spaces)
  (quicksetindent/set-var-helper set_defaults 'web-mode-style-padding indent_spaces)
  ;; [yaml-mode]
  (quicksetindent/set-var-helper set_defaults 'yaml-indent-offset indent_spaces)
  )

(provide 'quicksetindent)

;;; quicksetindent.el ends here
