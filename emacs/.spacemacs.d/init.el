;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Configuration Layers declaration.
You should not put any user code in this function besides modifying the variable
values."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs
   ;; Lazy installation of layers (i.e. layers are installed only when a file
   ;; with a supported type is opened). Possible values are `all', `unused'
   ;; and `nil'. `unused' will lazy install only unused layers (i.e. layers
   ;; not listed in variable `dotspacemacs-configuration-layers'), `all' will
   ;; lazy install any layer that support lazy installation even the layers
   ;; listed in `dotspacemacs-configuration-layers'. `nil' disable the lazy
   ;; installation feature and you have to explicitly list a layer in the
   ;; variable `dotspacemacs-configuration-layers' to install it.
   ;; (default 'unused)
   dotspacemacs-enable-lazy-installation 'unused
   ;; If non-nil then Spacemacs will ask for confirmation before installing
   ;; a layer lazily. (default t)
   dotspacemacs-ask-for-lazy-installation t
   ;; If non-nil layers with lazy install support are lazy installed.
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()
   ;; List of configuration layers to load.
   dotspacemacs-configuration-layers
   '(
     ;; ----------------------------------------------------------------
     ;; Add/uncomment some layer names and press <SPC f e R> (Vim style)
     ;; or <M-m f e R> (Emacs style) to install them.
     ;; ----------------------------------------------------------------

     ;; Languages (mostly major modes)
     asm
     c-c++
     csv
     clojure
     emacs-lisp
     html
     javascript
     lua
     markdown
     org
     php
     python
     shell-scripts
     sql
     (typescript :variables
                 typescript-fmt-on-save t)
     vimscript
     yaml

     ;; General layers
     helm
     (auto-completion :variables
                      auto-completion-return-key-behavior 'complete
                      auto-completion-tab-key-behavior 'cycle
                      ;; Disable documentation tooltips; slow and useless.
                      auto-completion-enable-help-tooltip nil
                      ;; Makes Company auto-complete using snippets too,
                      ;; in both the first/only suggestion and in the popup.
                      ;; Just type a snippet name and press Enter!
                      auto-completion-enable-snippets-in-popup t
                      ;; Load snippets from "snippets" and "snippets-default".
                      ;; Snippet path resolution is done from left to right.
                      ;; TODO: Having multiple paths causes auto-complete
                      ;; bug. Must manually fix "aya-persist-snippets-dir".
                      ;; See: https://github.com/syl20bnr/spacemacs/issues/7948
                      auto-completion-private-snippets-directory
                      '("~/.spacemacs.d/snippets/"
                        "~/.spacemacs.d/snippets-default/"))
     ibuffer
     imenu-list
     (git :variables
          git-magit-status-fullscreen t)
     ;; TODO: replace this with "colors" when my fixes are merged
     ;; https://github.com/syl20bnr/spacemacs/pull/7945
     (paintvars :variables
                paintvars-colorize-identifiers 'all
                ;; Averages of all colors that work for both light & dark
                ;; themes. The best we can do without per-theme optimizations.
                paintvars-default-rainbow-identifiers-sat 50
                paintvars-default-rainbow-identifiers-light 65)
     (shell :variables
            shell-default-shell 'ansi-term
            shell-default-term-shell "/bin/bash"
            shell-default-height 30
            shell-default-position 'bottom)
     semantic
     syntax-checking
     )
  ;; List of additional packages that will be installed without being
  ;; wrapped in a layer. If you need some configuration for these
  ;; packages, then consider creating a layer. You can also put the
  ;; configuration in `dotspacemacs/user-config'.
   dotspacemacs-additional-packages
   '(
     ;; Allows fast, super fuzzy finding of files.
     fzf

     ;; Makes it very easy to bind keys globally or in specific keymaps, and
     ;; with your choice of priority to ensure nothing overrides your keys. You
     ;; can see all your keys with <SPC SPC> describe-personal-keybindings. And
     ;; that list shows what was on the key before rebinding, if applicable.
     ;; NOTE: You can even use this to add bindings to Spacemacs' space-menu
     ;; since that's really just a keymap stored in "spacemacs-default-map".
     ;;
     ;; These four achieve the EXACT same thing, but the last is the best:
     ;;  (evil-leader/set-key "x y z" 'my/thing) ; official method (wrapper)
     ;;  (spacemacs/set-leader-keys "x y z" 'my/thing) ; core of official method
     ;;  (define-key spacemacs-default-map (kbd "x y z") 'my/thing) ; actual map
     ;;  (bind-key "x y z" 'my/thing spacemacs-default-map) ; bind-key method
     bind-key

     ;; Super clever version of "fill-paragraph", with an unfill toggle.
     unfill

     ;; Automatically configures emacs to match any project-provided settings.
     editorconfig

     ;; Theme packages to ensure they are always available.
     leuven-theme
     doom-themes
     flatland-theme
     gruvbox-theme
     material-theme
     color-theme-sanityinc-tomorrow
     subatomic-theme
     subatomic256-theme
     )
   ;; A list of packages that cannot be updated.
   dotspacemacs-frozen-packages '()
   ;; A list of packages that will not be installed and loaded.
   dotspacemacs-excluded-packages '()
   ;; Defines the behaviour of Spacemacs when installing packages.
   ;; Possible values are `used-only', `used-but-keep-unused' and `all'.
   ;; `used-only' installs only explicitly used packages and uninstall any
   ;; unused packages as well as their unused dependencies.
   ;; `used-but-keep-unused' installs only the used packages but won't uninstall
   ;; them if they become unused. `all' installs *all* packages supported by
   ;; Spacemacs and never uninstall them. (default is `used-only')
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/init ()
  "Initialization function.
This function is called at the very startup of Spacemacs initialization
before layers configuration.
You should not put any user code in there besides modifying the variable
values."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; If non-nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https t
   ;; Maximum allowed time in seconds to contact an ELPA repository.
   dotspacemacs-elpa-timeout 5
   ;; If non-nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. Note that checking for
   ;; new versions works via git commands, thus it calls GitHub services
   ;; whenever you start Emacs. (default nil)
   dotspacemacs-check-for-update t
   ;; If non-nil, a form that evaluates to a package directory. For example, to
   ;; use different package directories for different Emacs versions, set this
   ;; to `emacs-version'.
   dotspacemacs-elpa-subdirectory nil
   ;; One of `vim', `emacs' or `hybrid'.
   ;; `hybrid' is like `vim' except that `insert state' is replaced by the
   ;; `hybrid state' with `emacs' key bindings. The value can also be a list
   ;; with `:variables' keyword (similar to layers). Check the editing styles
   ;; section of the documentation for details on available variables.
   ;; (default 'vim)
   dotspacemacs-editing-style 'vim
   ;; If non-nil output loading progress in `*Messages*' buffer. (default nil)
   dotspacemacs-verbose-loading nil
   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner 'official
   ;; List of items to show in startup buffer or an association list of
   ;; the form `(list-type . list-size)`. If nil then it is disabled.
   ;; Possible values for list-type are:
   ;; `recents' `bookmarks' `projects' `agenda' `todos'."
   ;; List sizes may be nil, in which case
   ;; `spacemacs-buffer-startup-lists-length' takes effect.
   dotspacemacs-startup-lists '((todos . 10)
                                (recents . 3)
                                (projects . 10))
   ;; True if the home buffer should respond to resize events.
   dotspacemacs-startup-buffer-responsive t
   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'text-mode
   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press <SPC> T n to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(
                         spacemacs
                         ;; Curated list of great light & dark themes.
                         leuven
                         doom-molokai
                         doom-one
                         flatland
                         gruvbox
                         material
                         material-light
                         sanityinc-tomorrow-blue
                         sanityinc-tomorrow-eighties
                         spacemacs-light
                         subatomic
                         subatomic256)
   ;; If non-nil the cursor color matches the state color in GUI Emacs.
   dotspacemacs-colorize-cursor-according-to-state t
   ;; Default font, or prioritized list of fonts. `powerline-scale' allows to
   ;; quickly tweak the mode-line size to make separators look not too crappy.
   dotspacemacs-default-font '("Iosevka Slab" ;; "Source Code Pro"
                               :size 15
                               :weight semi-bold
                               :width normal
                               :powerline-scale 1.4)
   ;; The leader key
   dotspacemacs-leader-key "SPC"
   ;; The key used for Emacs commands (M-x) (after pressing on the leader key).
   ;; (default "SPC")
   dotspacemacs-emacs-command-key "SPC"
   ;; The key used for Vim Ex commands (default ":")
   dotspacemacs-ex-command-key ":"
   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"
   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","
   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m")
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs C-i, TAB and C-m, RET.
   ;; Setting it to a non-nil value, allows for separate commands under <C-i>
   ;; and TAB or <C-m> and RET.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil
   ;; If non-nil `Y' is remapped to `y$' in Evil states. (default nil)
   dotspacemacs-remap-Y-to-y$ nil
   ;; If non-nil, the shift mappings `<' and `>' retain visual state if used
   ;; there. (default t)
   dotspacemacs-retain-visual-state-on-shift t
   ;; If non-nil, J and K move lines up and down when in visual mode.
   ;; (default nil)
   dotspacemacs-visual-line-move-text nil
   ;; If non-nil, inverse the meaning of `g' in `:substitute' Evil ex-command.
   ;; (default nil)
   dotspacemacs-ex-substitute-global nil
   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"
   ;; If non-nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil
   ;; If non-nil then the last auto saved layouts are resume automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil
   ;; Size (in MB) above which spacemacs will prompt to open the large file
   ;; literally to avoid performance issues. Opening a file literally means that
   ;; no major mode or minor modes are active. (default is 1)
   dotspacemacs-large-file-size 1
   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache
   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5
   ;; If non-nil, `helm' will try to minimize the space it uses. (default nil)
   dotspacemacs-helm-resize nil
   ;; if non-nil, the helm header is hidden when there is only one source.
   ;; (default nil)
   dotspacemacs-helm-no-header nil
   ;; define the position to display `helm', options are `bottom', `top',
   ;; `left', or `right'. (default 'bottom)
   dotspacemacs-helm-position 'bottom
   ;; Controls fuzzy matching in helm. If set to `always', force fuzzy matching
   ;; in all non-asynchronous sources. If set to `source', preserve individual
   ;; source settings. Else, disable fuzzy matching in all sources.
   ;; (default 'always)
   dotspacemacs-helm-use-fuzzy 'always
   ;; If non-nil the paste micro-state is enabled. When enabled pressing `p`
   ;; several times cycle between the kill ring content. (default nil)
   dotspacemacs-enable-paste-transient-state nil
   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4
   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom
   ;; Control where `switch-to-buffer' displays the buffer. If nil,
   ;; `switch-to-buffer' displays the buffer in the current window even if
   ;; another same-purpose window is available. If non-nil, `switch-to-buffer'
   ;; displays the buffer in a same-purpose window even if the buffer can be
   ;; displayed in the current window. (default nil)
   dotspacemacs-switch-to-buffer-prefers-purpose nil
   ;; If non-nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t
   ;; If non-nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil
   ;; If non-nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil
   ;; If non-nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup nil
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 98
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 95
   ;; If non-nil show the titles of transient states. (default t)
   dotspacemacs-show-transient-state-title t
   ;; If non-nil show the color guide hint for transient state keys. (default t)
   dotspacemacs-show-transient-state-color-guide t
   ;; If non-nil unicode symbols are displayed in the mode line. (default t)
   dotspacemacs-mode-line-unicode-symbols t
   ;; If non-nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters point
   ;; when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t
   ;; Control line numbers activation.
   ;; If set to `t' or `relative' line numbers are turned on in all `prog-mode' and
   ;; `text-mode' derivatives. If set to `relative', line numbers are relative.
   ;; This variable can also be set to a property list for finer control:
   ;; '(:relative nil
   ;;   :disabled-for-modes dired-mode
   ;;                       doc-view-mode
   ;;                       markdown-mode
   ;;                       org-mode
   ;;                       pdf-view-mode
   ;;                       text-mode
   ;;   :size-limit-kb 1000)
   ;; (default nil)
   dotspacemacs-line-numbers nil
   ;; Code folding method. Possible values are `evil' and `origami'.
   ;; (default 'evil)
   dotspacemacs-folding-method 'evil
   ;; If non-nil smartparens-strict-mode will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil
   ;; If non-nil pressing the closing parenthesis `)' key in insert mode passes
   ;; over any automatically added closing parenthesis, bracket, quote, etc…
   ;; This can be temporary disabled by pressing `C-q' before `)'. (default nil)
   dotspacemacs-smart-closing-parenthesis nil
   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all
   ;; If non-nil, advise quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil
   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `rg', `ag', `pt', `ack' and `grep'.
   ;; (default '("rg" "ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("rg" "ag" "pt" "ack" "grep")
   ;; The default package repository used if no explicit repository has been
   ;; specified with an installed package.
   ;; Not used for now. (default nil)
   dotspacemacs-default-package-repository nil
   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed'to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup 'changed
   ))

(defun dotspacemacs/user-init ()
  "Initialization function for user code.
It is called immediately after `dotspacemacs/init', before layer configuration
executes.
 This function is mostly useful for variables that need to be set
before packages are loaded. If you are unsure, you should try in setting them in
`dotspacemacs/user-config' first."

  ;; Set the Emacs customization file path. Must be done here in user-init.
  (setq custom-file "~/.spacemacs.d/custom.el")

  ;; Default all new frames to 90x40 to fit line number + 80 columns of text.
  (add-to-list 'default-frame-alist '(width . 90))
  (add-to-list 'default-frame-alist '(height . 40))
  )

(defun dotspacemacs/user-config ()
  "Configuration function for user code.
This function is called at the very end of Spacemacs initialization after
layers configuration.
This is the place where most of your configurations should be done. Unless it is
explicitly specified that a variable should be set before a package is loaded,
you should place your code here."


  ;; Add personal script path, so that "require" works for personal scripts.
  (push "~/.spacemacs.d/config/" load-path)


  ;; ------- KEYBINDING SYSTEM -------

  ;; Helper func which creates your own evil-leader rebindings
  ;; and stores a help reference in your list of personal keys.
  (defun my/bind-key-evil-leader (key def &rest bindings)
    "Works like `evil-leader/set-key', but also stores
the new binding in your list of personal rebindings.

Do NOT include your Evil leader key in the key pattern."
    (while key
      ;; we replaced define-key with bind-key, to log the result.
      (bind-key key def spacemacs-default-map)
      (setq key (pop bindings) def (pop bindings))))

  ;; Helper func which binds something in all evil states
  ;; and stores a help reference in your list of personal keys.
  (defun my/bind-key-evil-noninsert-states (key def &rest bindings)
    "Binds a key in all Evil states *except* the Insert state.
Also stores the new bindings in your list of personal rebindings.

If you don't want to affect all maps, you should manually
set the key in just the maps you want. But setting your key
in all Evil maps is great for adding motion commands that
work as normal, motion and visual commands!

The reason we don't affect evil's \"insert\" state is to
*avoid* encouraging lots of motion-jumping around within a
single insert state. For example, if you bound a key to let
you jump to another part of the file while still in
insert-state, you could stay in insert state forever, and
then when you finally *DO* leave the state and press \"u\"
to undo something, you will lose ALL of your work as one big
chunk. Constantly leaving insert-state via ESC to break up
your work into chunks is a CORE aspect of how editing is
*supposed* to work in Vim and Evil mode! It *ensures* that
your undo/redo-states have logical chunks.

If you really want to perform a Evil Normal-state action
while staying in Insert mode, then press Ctrl-o to enter
\"perform next command as if in Normal mode\" state. With
that, you can press your desired motion key even from within
Insert-mode, in situations where you need it!

Here are the maps this sets the key in, and their purposes:

`evil-normal-state-map':
  The normal state when you aren't in any specialized evil
  mode. This is the state you return to via ESC. It has all
  your normal initial keys, such as \"d\"elete and \"y\"ank.

`evil-motion-state-map':
  Used for operator motions, and affects the meaning of the
  second \"movement\" key AFTER you've pressed a normal key
  like \"d\"elete or \"y\"ank. An example of a motion would
  be \"j\" for \"go down one line\".
  Note that certain motions like \"s\" have special handling
  and cannot be rebound by setting them in this state map!
  An example of that is \"s\"urround, which is hardcoded to
  use the special `evil-surround-mode-map' instead, and that
  map in turn contains non-standard submaps, and the only
  way to rebind those submaps is via `evil-define-key'!

`evil-visual-state-map':
  Used for motions in all visual modes; character, line, block.

We don't affect `global-map' at all, meaning the default
fallback map which is used if a key isn't overridden in any
of the loaded major or minor mode maps. Therefore, anything
you bind via this function will *only* work within Evil
mode. It won't work at all within regular Emacs mode!
That is *intentional*, because anything you bind in the
`global-map' will be active in Evil's Insert mode too! So if
you bound something to \"Shift-Q\" for instance, then you'd
be unable to type a \"Q\" character while in Evil's Insert
mode! Furthermore, it would yet again re-introduce the
problem we're trying to avoid, which is to *not* bind in
Insert mode, so that we *discourage* creating huge chunks of
work within a single undo-history entry!

One side-effect of not affecting the `global-map' is that
you won't see if your Evil mode re-bindings are actually
overriding a global fallback that was used by Evil's lack of
own bindings for that key. So it's a very good idea to first
try your key by pressing \"SPC h d k\" and then the key, to
see if anything is bound to it by default in Emacs. If so,
you'll probably want to manually create another `global-map'
entry which rebinds whatever global behavior you're
overriding due to your Evil maps.

To manually add a `global-map' fallback default, use this:
  bind-key key def global-map

Lastly, if you're REALLY sure you want to override a certain
key in EVERY keymap inside of Emacs, for ALL Evil states and
ALL other modes globally, then use the `bind-key*' function
instead. It will install an ENFORCED global override which
replaces ALL other meanings for that key EVERYWHERE!
But you should be VERY sure that such bindings don't destroy
keybind functionality of the modes you use! For example,
lots of modes use the Tab key for something useful, and it's
a terrible idea to rebind Tab globally!

To manually ENFORCE a certain key behavior globally, use this:
  bind-key* key def"
    (while key ; imagine that the key is "Alt-q"
      ;; NOTE: We don't touch evil-operator-state-map, because that's just
      ;; a special map containing "i" (inside) and "a" (around) sub-maps
      ;; that are loaded when pressing "i" or "a" in evil-motion-state-map.
      (bind-key key def evil-normal-state-map) ; ie: Alt-q
      (bind-key key def evil-motion-state-map) ; ie: d Alt-q
      (bind-key key def evil-visual-state-map) ; ie: v Alt-q
      (setq key (pop bindings) def (pop bindings))))

  ;; Declare the text labels for our own prefix groups, so that our labels will
  ;; show up properly if we decide to insert our own evil-leader keys within
  ;; these. However, I prefer trying to find an available key within main
  ;; mnemonic menus.
  (spacemacs/declare-prefix "o" "my/own")
  (spacemacs/declare-prefix "os" "my/search")

  ;; Add an easy method for seeing all of your personal keys:
  ;;  <SPC h o> ("help own").
  ;; Let's also place it under "o h" for "own help", in case we misremember it.
  (defun my/help-own-keys ()
    "Lists all of your personal keybindings,
and which action they replaced (if any)."
    (interactive)
    (describe-personal-keybindings)
    (when (> (count-windows) 1)
      (other-window 1))) ; focus "next" window (the new info window)
  (my/bind-key-evil-leader "h o" 'my/help-own-keys)
  (my/bind-key-evil-leader "o h" 'my/help-own-keys)


  ;; ------- GENERAL GUI SETTINGS -------

  ;; Always start with a semi-transparent frame.
  (spacemacs/toggle-transparency)
  (add-hook 'after-make-frame-functions 'spacemacs/toggle-transparency)

  ;; Show the full file path in the frame titlebar.
  (setq frame-title-format '(buffer-file-name "%f" ("%b")))

  ;; Prevent vim visual mode selection from overriding macOS system clipboard.
  (fset 'evil-visual-update-x-selection 'ignore)

  ;; The "osx" layer adds a mentally insane Command-q shortcut by default, which
  ;; quits the application. If all of your buffers have been saved to disk, it
  ;; instantly quits without confirmation and loses your entire workspace. The
  ;; worst part is that the shortcut is way too easy to accidentally hit since
  ;; this text editor requires lots of meta-key sequences. Let's disable it.
  (defun my/quit-advice ()
    "Tells the user how to quit Spacemacs the proper way."
    (interactive)
    (message "To quit Spacemacs, press <SPC q q>."))
  (bind-key "s-q" 'my/quit-advice global-map)

  ;; GUI Settings for YAMAMOTO Mitsuharu's Mac port of GNU Emacs.
  ;; https://github.com/railwaycat/homebrew-emacsmacport
  (when (and (spacemacs/system-is-mac) (display-graphic-p))
    ;; Map Command to Super.
    (setq mac-command-key-is-meta nil
          mac-command-modifier 'super)

    ;; Map Option to Meta.
    (setq mac-option-key-is-meta t
          mac-option-modifier 'meta)

    ;; Disable pixel-by-pixel scrolling, since it's extremely choppy.
    (setq mac-mouse-wheel-smooth-scroll nil)

    ;; Ensure that deleted files go to the Mac trash folder.
    (setq mac-system-move-file-to-trash-use-finder t))

  ;; Keyboard smooth scrolling: Prevent the awkward "snap to re-center" when
  ;; the text cursor moves off-screen. Instead, only scroll the minimum amount
  ;; necessary to show the new line. (A number of 101+ disables re-centering.)
  (setq scroll-conservatively 101)

  ;; Optimize mouse wheel scrolling for smooth-scrolling trackpad use.
  ;; Trackpads send a lot more scroll events than regular mouse wheels,
  ;; so the scroll amount and acceleration must be tuned to smooth it out.
  (setq
   ;; If the frame contains multiple windows, scroll the one under the cursor
   ;; instead of the one that currently has keyboard focus.
   mouse-wheel-follow-mouse 't
   ;; Completely disable mouse wheel acceleration to avoid speeding away.
   mouse-wheel-progressive-speed nil
   ;; The most important setting of all! Make each scroll-event move 2 lines at
   ;; a time (instead of 5 at default). Simply hold down shift to move twice as
   ;; fast, or hold down control to move 3x as fast. Perfect for trackpads.
   mouse-wheel-scroll-amount '(2 ((shift) . 4) ((control) . 6)))

  ;; Switch powerline separators to text, since the bitmaps look bad in sRGB.
  ;; It's possible to disable sRGB, but that makes Emacs colors too bright.
  ;; UPDATE: Enabling again since this is fixed in railwaycat's emacs-mac port!
  ;; (setq powerline-default-separator 'utf-8)

  ;; Use the beautiful wave separators for powerline.
  (setq powerline-default-separator 'wave)

  ;; Set default per-theme saturation and lightness for rainbow-identifiers.
  ;; These are carefully tweaked for all of my enabled themes.
  (paintvars/add-theme-sat&light 'leuven '(95 40))
  (paintvars/add-theme-sat&light 'doom-molokai '(45 80))
  (paintvars/add-theme-sat&light 'doom-one '(45 80))
  (paintvars/add-theme-sat&light 'flatland '(50 80))
  (paintvars/add-theme-sat&light 'gruvbox '(55 80))
  (paintvars/add-theme-sat&light 'material '(55 90))
  (paintvars/add-theme-sat&light 'material-light '(70 35))
  (paintvars/add-theme-sat&light 'sanityinc-tomorrow-blue '(40 95))
  (paintvars/add-theme-sat&light 'sanityinc-tomorrow-eighties '(30 80))
  (paintvars/add-theme-sat&light 'spacemacs-light '(60 45))
  (paintvars/add-theme-sat&light 'spacemacs-dark '(45 70))
  (paintvars/add-theme-sat&light 'subatomic '(35 90))
  (paintvars/add-theme-sat&light 'subatomic256 '(30 85))
  (paintvars/refresh-theme-look)


  ;; ------- GENERAL SETTINGS -------

  ;; Make Spacemacs go into git-commit-mode if opened as git's external editor.
  (global-git-commit-mode t)

  ;; Modify imenu-list so that the window position is centered after each jump.
  (add-hook 'imenu-after-jump-hook (lambda () (recenter 10)))

  ;; Because we've made magit fullscreen, mark its buffer useful in <SPC b n>.
  (when (configuration-layer/package-usedp 'magit)
    (add-to-list 'spacemacs-useful-buffers-regexp "^\\*magit"))

  ;; Tell Magit to warn us if commit summary exceeds 50 characters, and to wrap
  ;; the commit message itself at no more than 72 characters per line.
  ;; NOTE: The Emacs modeline displays columns with 0 as the first column.
  (setq git-commit-summary-max-length 50)
  (setq git-commit-fill-column 72)

  ;; Disable Semantic's source referencing in lisp buffers, otherwise it tries
  ;; to parse all Spacemacs source code while you type, which freezes Emacs.
  (add-hook 'semantic-inhibit-functions
            (lambda () (member major-mode '(emacs-lisp-mode))))

  ;; The following is a replacement for having line-numbers on screen, since
  ;; line numbers massively slow down Visual Block insert mode (Ctrl-v Shift-i)
  ;; in Evil and make it take much longer to insert your text, so it's not worth
  ;; it. With line numbers, insertion speed goes from instant to many seconds.
  ;; Seemingly because Emacs has to re-calculate the numbers for the whole file
  ;; once per each line that was affected by block insertion. But you won't miss
  ;; having line numbers after you've tried these commands instead! And you can
  ;; always read the current line number in the statusline.
  ;;
  ;; We'll add a few new Evil mode motions, which allow you to extremely rapidly
  ;; jump to exact lines or character pairs on screen. The shortcut keys were
  ;; carefully chosen to be sure they don't conflict with anything in any Evil
  ;; mode or any other buffer modes used in combination with Evil, or any major
  ;; default shortcuts (such as Ctrl-q for literal character insertion).
  ;; The "q" is a mnemonic for "quick goto".
  ;;
  ;; Adds the following shortcuts (which can be used standalone or as motions):
  ;; -<Shift-Q> = Type two characters to list jump candidates on screen. Very
  ;;  easy to type and is also super close to w and e, which you may want to use
  ;;  after jumping.
  ;; -<Alt-q> = Easily jump to any line on screen. Less important now that you
  ;;  can jump to direct character positions in lines via the previous shortcut,
  ;;  which is why this one is placed on the harder-to-type Alt-key. But it's
  ;;  still pretty easy, especially if you just the right-alt key to avoid
  ;;  having to do finger gymnastics with your left hand.
  ;;
  ;; These keys are NOT bound in Evil's insert mode. Because making it too easy
  ;; to jump around lines could cause you to stay forever in insert mode, and
  ;; then when you finally press Esc and "u" to undo something, you would undo
  ;; all of the work as one giant chunk. You are *meant* to periodically leave
  ;; insert mode via Esc, to split your undo history into logical chunks!
  ;;
  ;; However, if you *really* want to perform a jump while in insert mode, just
  ;; use the standard <Ctrl-o> Vim shortcut to perform a normal-mode command
  ;; such as "<Ctrl-o>dQ" to delete from your current position to the jump
  ;; target you choose! :-)
  (my/bind-key-evil-noninsert-states "Q" 'evil-avy-goto-char-2)
  (my/bind-key-evil-noninsert-states "M-q" 'evil-avy-goto-line)

  ;; Reduce the number of jump targets, by only listing targets in the focused
  ;; window. This helps keep your jump character sequences short.
  (setq avy-all-windows nil)

  ;; The <Alt-q> shortcut above actually causes Evil to override a default
  ;; action in the global-map. And the default is the extremely useful
  ;; "fill-paragraph" command which nicely reflows paragraphs. Therefore, let's
  ;; fix it by installing a global default <Alt-Shift-Q> shortcut which performs
  ;; an enhanced version of fill-paragraph! It will work in all Evil modes, and
  ;; any other modes that don't manually override this new global default with
  ;; something else. This "unfill-toggle" command resets itself every time you
  ;; move the text cursor, and the first thing it does is a normal
  ;; "fill-paragraph", and then if you press it again without moving your text
  ;; cursor it will perform an unfill to put it all on a single line.
  ;; It uses "fill-column" to determine wrapping. Use <C-x f> to quickly set
  ;; a new column value; it even helpfully defaults to your current column pos.
  (bind-key "M-Q" 'unfill-toggle global-map)

  ;; Global keys: Support incrementing and decrementing the number under the
  ;; cursor. It correctly handles <count> prefixes too, just like vim. You can
  ;; also use <SPC n +/=/-> to open a transient state in vim normal mode.
  (bind-keys*
   ("C-c =" . evil-numbers/inc-at-pt)
   ("C-c +" . evil-numbers/inc-at-pt)
   ("C-c -" . evil-numbers/dec-at-pt))

  ;; Bind <SPC f F> to perform a recursive, dired (find-pattern based) search.
  (my/bind-key-evil-leader "f F" 'find-name-dired)

  ;; Bind <SPC f z> to fzf fuzzy find in CWD, and <SPC f Z> for a manual path.
  ;; We disable colors so that the display looks good on any Emacs theme, and we
  ;; move the fzf prompt up by 1 row to fix a rendering bug in ansi-term. Note
  ;; that you simply press <C-c C-c> to gently exit fzf if you want to abort.
  (setq fzf/args "-x --color bw --margin 1,0")
  (my/bind-key-evil-leader "f z" 'fzf)
  (my/bind-key-evil-leader "f Z" 'fzf-directory)

  ;; Bind <SPC f /> to use Helm's recursive find-based search. Nicer than fzf.
  ;; The main point is its perfect Helm integration, but it only refeshes when
  ;; the "find" command finishes executing, so fzf beats it for large trees.
  (defun my/helm-find ()
    "Perform a recursive find-based search."
    (interactive)
    (setq current-prefix-arg '(4))
    (call-interactively 'helm-find))
  (my/bind-key-evil-leader "f /" 'my/helm-find)

  ;; Global key: <C-tab> jumps to first non-whitespace character on the line.
  ;; This doesn't conflict with anything, since I've never seen any modes bind
  ;; that key, and it's a more convenient shortcut than <^> for my typing style.
  ;; Furthermore, global binding means the convenience works in insert mode too.
  (bind-key* "<C-tab>" 'evil-first-non-blank)

  ;; Global keys: <f5> to find tasks in current buffer, <shift-f5> for all.
  ;; Space-leader: <SPC o s t> and <SPC o s T>.
  (defun my/find-todo-here ()
    "Search for todo-items in the current buffer."
    (interactive)
    (helm-swoop :$query "\\(fixme\\|todo\\|xxx\\)"))
  (bind-key* "<f5>" 'my/find-todo-here)
  (my/bind-key-evil-leader "s x" 'my/find-todo-here)
  (defun my/find-todo-all ()
    "Search for todo-items in all open buffers."
    (interactive)
    (helm-multi-swoop-all "\\(fixme\\|todo\\|xxx\\)"))
  (bind-key* "<S-f5>" 'my/find-todo-all)
  (my/bind-key-evil-leader "s X" 'my/find-todo-all)

  ;; Company auto-completer.
  (with-eval-after-load 'company
    ;; Global key: Set Super+/ to start/finish autocompletion; about as easy
    ;; as pressing tab, and always works even when a mode has rebound tab!
    ;; And it is very consistent with Meta+/ which does basic, naive completion.
    ;; PS: This is mostly useful to re-activate autocompletion after canceling.
    ;; During normal typing, it's easier to use Enter to complete suggestions.
    (bind-key* "s-/" 'company-complete)
    ;; Autocompletion popup: Enable "delete word" shortcut like you'd expect.
    (bind-key "C-w" 'evil-delete-backward-word company-active-map))

  ;; TODO: Remove this workaround when the bug is fixed:
  ;; This is a workaround for a severe bug in the auto-complete layer's
  ;; support for multiple include paths. It wrongly sets auto-yasnippet's
  ;; save-folder to the entire list of paths. So we must correct it to be
  ;; a single folder where we want to save snippets, otherwise it breaks.
  (when (configuration-layer/layer-usedp 'auto-completion)
    ;; The buggy auto-completion layer sets the incorrect value before loading
    ;; aya. But loading of the actual package is deferred until we call one of
    ;; its funcs. So we simply replace aya's variable value after the package is
    ;; loaded, which happens before the func call is performed. That solves it.
    (with-eval-after-load 'auto-yasnippet
      (setq aya-persist-snippets-dir "~/.spacemacs.d/snippets/")))

  ;; YASnippet: Press <SPC i S m> to create a manual snippet via editor.
  (defun my/manual-snippet ()
    "Manually create a new snippet via a dedicated editor."
    (interactive)
    ;; Exit from any ongoing expansion state, to avoid errors when leaving buf.
    (yas-exit-all-snippets)
    ;; Go back to Evil's normal state in the current buffer.
    (evil-force-normal-state)
    ;; Create a new snippet buffer using the default template.
    (yas-new-snippet nil)
    ;; Enter Evil's insert mode to allow you to type immediately.
    (evil-insert 1))
  (my/bind-key-evil-leader "i S m" 'my/manual-snippet)

  ;; Helm: Bind some unused keys to deleting previous word or whole line.
  ;; You can also use the built-in <C-backspace> to delete the previous word.
  (with-eval-after-load 'helm
    (bind-key "C-h" 'evil-delete-backward-word helm-map)
    (bind-key "C-u" 'evil-delete-whole-line helm-map))


  ;; ------- FINISH WITH ALL CRITICALLY IMPORTANT TEXT SETTINGS -------

  ;; Automatically configure buffer-local text display settings for all text
  ;; and programming language buffers. We don't affect `special-mode' buffers.
  (setq-default fill-column 80) ; default to max 80-character lines
  (defun my/default-text-setup ()
    "Configures the current buffer for proper text display."
    (interactive)
    ;; Display the 80th column via a faint line, to let you see it visually.
    ;; Tip: You can easily change the column at runtime by pressing <C-x f>.
    (spacemacs/toggle-fill-column-indicator-on)
    ;; Automatically break lines that go past the 80th column as you write.
    (spacemacs/toggle-auto-fill-mode-on)
    ;; Forcibly enable the long line warning since global enable isn't reliable.
    (column-enforce-n 80)
    ;; Disallow lines from being truncated at the right; this enables wrapping.
    ;; This is a visual hard-wrapping. But lines on-disk won't be affected.
    ;; Note that we must set this option LAST, since the prior ones reset it!
    ;; Tip: You can toggle this at runtime via <SPC t l>.
    (spacemacs/toggle-truncate-lines-off))
  (add-hook 'text-mode-hook 'my/default-text-setup)
  (add-hook 'prog-mode-hook 'my/default-text-setup)

  ;; Globally enable the long line warning for lines 80 chars or longer. This
  ;; ensures that you'll never again write/miss long lines by accident.
  ;; Tip: <Alt-Shift-Q> reflows comments to fit within those requirements.
  (setq-default column-enforce-column 80) ; highlight column 80 globally
  (spacemacs/toggle-highlight-long-lines-globally-on)

  ;; Change backspace behavior from "del 1 char, if tab then convert to spaces
  ;; and del 1 space", into "delete all whitespace before cursor on line". This
  ;; simplifies all work of indenting code, regardless of whitespace type. Note
  ;; that some modes such as python override BS with more advanced behavior. At
  ;; start of a python line, BS eats 1 indent level, otherwise it does as below.
  (setq backward-delete-char-untabify-method 'hungry)

  ;; Tell Emacs to globally use 4 spaces as its default indentation. Certain
  ;; modes override these defaults, but it works for the vast majority of modes.
  ;; Also note that we set our global defaults before enabling editorconfig.
  ;; That way editorconfig's per-project settings will take precedence.
  (require 'quicksetindent)
  (quicksetindent/set-indentation t 4)
  (setq-default php-mode-coding-style 'pear)

  ;; Enable editorconfig-mode, to ensure we apply project-provided settings.
  ;; This automatically sets up indentation depth, type, evil-shift-width, etc.
  ;; You can read about .editorconfig files here: http://editorconfig.org
  (editorconfig-mode 1)

  ;; Make ec's indicator less obnoxious. We'll see a Cog/"Ec" when loaded.
  (spacemacs|diminish editorconfig-mode " ☼" " Ec")

  ;; Lastly, load custom-file (but only if the file exists).
  (when (file-exists-p custom-file)
    (load-file custom-file))
  )
