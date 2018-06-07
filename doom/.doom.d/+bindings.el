;;; ~/.dot/doom/.doom.d/+bindings.el -*- lexical-binding: t; -*-

(map! ;; sexp navigation
      :nv "U" 'backward-up-list
      :nv "R" 'down-list
      :nv "L" 'sp-forward-sexp
      :nv "H" 'sp-backward-sexp

      ;; Easier window navigation
      :n "C-h"   #'evil-window-left
      :n "C-j"   #'evil-window-down
      :n "C-k"   #'evil-window-up
      :n "C-l"   #'evil-window-right

      (:leader
        (:desc "Yank" :n "y" #'counsel-yank-pop)
        (:desc "buffer" :prefix "b"
          :desc "Delete buffer" :n "d" #'doom/kill-this-buffer)
        (:prefix "o"
          :desc "mu4e" :n "e" #'mu4e))

      ;; Custom bindings
      (:after mu4e
        (:map mu4e-main-mode-map
          :n "J" #'mu4e~headers-jump-to-maildir)
        (:map mu4e-headers-mode-map
          :n "J"    #'mu4e~headers-jump-to-maildir

          ;; list movement
          :n "j"    #'mu4e-headers-next
          :n "\C-j" #'mu4e-headers-next
          :n "k"    #'mu4e-headers-prev
          :n "\C-k" #'mu4e-headers-prev
          :n "h"    #'mu4e-headers-mark-for-action
          :n "l"    #'mu4e-headers-mark-for-unflag)

        (:map mu4e-view-mode-map
          :n "\C-j" #'mu4e-headers-next
          :n "\C-k" #'mu4e-headers-prev)

        (:map mu4e-compose-mode-map
          :localleader
          :desc "send and exit" :n "c" #'message-send-and-exit
          :desc "kill buffer"   :n "k" #'message-kill-buffer
          :desc "save draft"    :n "s" #'message-dont-send
          :desc "attach"        :n "f" #'mml-attach-file))

      (:after clojure-mode
        :localleader
        :n  "'"  #'cider-jack-in
        :n  "\"" #'cider-jack-in-clojurescript
        :n  "B"  #'cider-switch-to-repl-buffer
        :n  "b"  #'cider-eval-buffer
        :n  "n"  #'cider-repl-set-ns
        :n  "j"  #'cider-find-var
        :n  "d"  #'cider-doc
        :n  "c"  #'cider-repl-clear-buffer
        :n  "p"  #'cider-eval-sexp-at-point
        :n  "r"  #'cider-eval-region
        :desc "Enlighten mode" :n  "e"  #'cider-enlighten-mode))

