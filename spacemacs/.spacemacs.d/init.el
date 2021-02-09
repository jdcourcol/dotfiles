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
   '(graphviz
     go
     typescript
     octave
     csv
     ansible
     lua
     yaml
     markdown
     lsp
     python
     ;; ----------------------------------------------------------------
     ;; Example of useful layers you may want to use right away.
     ;; ----------------------------------------------------------------
     helm
     multiple-cursors
     auto-completion
     (auto-completion :variables
                      auto-completion-return-key-behavior nil
                      auto-completion-tab-key-behavior 'complete
                      auto-completion-complete-with-key-sequence nil
                      auto-completion-complete-with-key-sequence-delay 0.1
                      auto-completion-private-snippets-directory nil)
     ;; better-defaults
     emacs-lisp
     fasd
     git
     github
     html
     javascript
     treemacs
     org
     osx
     ranger
     ;; (shell :variables
     ;;        shell-default-height 30
     ;;        shell-default-position 'bottom)
     spell-checking
     syntax-checking
     ;; version-control
     restclient
     evil-snipe
     )
   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   dotspacemacs-additional-packages '(
                                      dumb-jump
                                      request
                                      json
                                      cl
                                      evil-terminal-cursor-changer
                                      edit-server
                                      (vue-mode :location (recipe :fetcher github :repo "codefalling/vue-mode"))
                                      )
   ;; A list of packages that cannot be updated.
   dotspacemacs-frozen-packages '()
   ;; A list of packages that will not be installed and loaded.
   dotspacemacs-excluded-packages '(org-projectile)
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
   ;; If non nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https t
   ;; Maximum allowed time in seconds to contact an ELPA repository.
   dotspacemacs-elpa-timeout 5
   ;; If non nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. Note that checking for
   ;; new versions works via git commands, thus it calls GitHub services
   ;; whenever you start Emacs. (default nil)
   dotspacemacs-check-for-update nil
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
   ;; If non nil output loading progress in `*Messages*' buffer. (default nil)
   dotspacemacs-verbose-loading nil
   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner 'nil
   ;; List of items to show in startup buffer or an association list of
   ;; the form `(list-type . list-size)`. If nil then it is disabled.
   ;; Possible values for list-type are:
   ;; `recents' `bookmarks' `projects' `agenda' `todos'."
   ;; List sizes may be nil, in which case
   ;; `spacemacs-buffer-startup-lists-length' takes effect.
   dotspacemacs-startup-lists '((recents . 25)
                                (projects . 25))
   ;; True if the home buffer should respond to resize events.
   dotspacemacs-startup-buffer-responsive t
   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'text-mode
   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press <SPC> T n to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(spacemacs-dark
                         spacemacs-light)
   ;; If non nil the cursor color matches the state color in GUI Emacs.
   dotspacemacs-colorize-cursor-according-to-state t
   ;; Default font, or prioritized list of fonts. `powerline-scale' allows to
   ;; quickly tweak the mode-line size to make separators look not too crappy.
   dotspacemacs-default-font '("Source Code Pro"
                               :size 13
                               :weight normal
                               :width normal
                               :powerline-scale 1.1)
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
   ;; If non nil `Y' is remapped to `y$' in Evil states. (default nil)
   dotspacemacs-remap-Y-to-y$ nil
   ;; If non-nil, the shift mappings `<' and `>' retain visual state if used
   ;; there. (default t)
   dotspacemacs-retain-visual-state-on-shift t
   ;; If non-nil, J and K move lines up and down when in visual mode.
   ;; (default nil)
   dotspacemacs-visual-line-move-text t
   ;; If non nil, inverse the meaning of `g' in `:substitute' Evil ex-command.
   ;; (default nil)
   dotspacemacs-ex-substitute-global nil
   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"
   ;; If non nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil
   ;; If non nil then the last auto saved layouts are resume automatically upon
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
   ;; If non nil, `helm' will try to minimize the space it uses. (default nil)
   dotspacemacs-helm-resize nil
   ;; if non nil, the helm header is hidden when there is only one source.
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
   ;; If non nil the paste micro-state is enabled. When enabled pressing `p`
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
   ;; If non nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t
   ;; If non nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil
   ;; If non nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil
   ;; If non nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup nil
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90
   ;; If non nil show the titles of transient states. (default t)
   dotspacemacs-show-transient-state-title t
   ;; If non nil show the color guide hint for transient state keys. (default t)
   dotspacemacs-show-transient-state-color-guide t
   ;; If non nil unicode symbols are displayed in the mode line. (default t)
   dotspacemacs-mode-line-unicode-symbols nil
   ;; If non nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters point
   ;; when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t
   ;; If non nil line numbers are turned on in all `prog-mode' and `text-mode'
   ;; derivatives. If set to `relative', also turns on relative line numbers.
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
   ;; If non nil, advise quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil
   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `ag', `pt', `ack' and `grep'.
   ;; (default '("ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
   ;; The default package repository used if no explicit repository has been
   ;; specified with an installed package.
   ;; Not used for now. (default nil)
   dotspacemacs-default-package-repository nil
   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed'to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup nil
   ))

(defun dotspacemacs/user-init ()
  "Initialization function for user code.
It is called immediately after `dotspacemacs/init', before layer configuration
executes.
 This function is mostly useful for variables that need to be set
before packages are loaded. If you are unsure, you should try in setting them in
`dotspacemacs/user-config' first."
  ;; TODO this raises a warning.
  ;; Shell
  (setq shell-default-term-shell "/bin/zsh")
  (setq avy-all-windows 'all-frames)
  (setq ispell-program-name "aspell")
  (setq evil-move-cursor-back nil)
  (setq org-M-RET-may-split-line nil)

  )

(defun dotspacemacs/user-config ()
  "Configuration function for user code.
This function is called at the very end of Spacemacs initialization after
layers configuration.
This is the place where most of your configurations should be done. Unless it is
explicitly specified that a variable should be set before a package is loaded,
you should place your code here."
  ;; ;; fixing org ,-RET issue
  ;; (with-eval-after-load 'org 
  ;;   (define-key org-mode-map [(, n)] 'org-insert-heading-respect-content)
  ;;   )
  ;; (add-hook 'org-mode-hook (lambda()
  ;;                            (define-key
  ;;                              evil-normal-state-local-map
  ;;                              (kbd "C-RET")
  ;;                              #'org-meta-return)
  ;;                            (define-key
  ;;                              evil-insert-state-local-map
  ;;                              (kbd "C-RET")
  ;;                              #'org-meta-return)))
  (spacemacs/set-leader-keys-for-major-mode 'org-mode "RET" 'org-insert-heading-respect-content
    (or dotspacemacs-major-mode-leader-key ",") 'org-ctrl-c-ctrl-c
    "RET" 'org-insert-heading-respect-content
)
  
  (setq tramp-default-method "ssh")
  (setq tramp-shell-prompt-pattern "\\(?:^\\|\r\\)[^]#$%>\n]*#?[]#$%>].* *\\(^[\\[[0-9;]*[a-zA-Z] *\\)*")
  (eval-after-load 'tramp '(setenv "SHELL" "/bin/bash"))
   (unless (display-graphic-p)
    (require 'evil-terminal-cursor-changer)
     (evil-terminal-cursor-changer-activate) ; or (etcc-on)
     )
   (setq evil-normal-state-cursor '("orange" box))
   (setq evil-insert-state-cursor '("green" bar))
   (setq evil-visual-state-cursor '("gray" box))
   (setq-default evil-escape-key-sequence "jk")
   (setq restclient-same-buffer-response nil)
   (setq make-backup-files nil)
   (xterm-mouse-mode -1)
   ;; disable anaconda response display
   (remove-hook 'anaconda-mode-response-read-fail-hook
                                     'anaconda-mode-show-unreadable-response)
   ;; s causes issues with magit (squash)
   (add-hook 'magit-mode-hook 'turn-off-evil-snipe-override-mode)
  (add-to-list 'auto-mode-alist '("\\.vue\\'" . vue-mode))
  (setq vc-follow-symlinks t)
  ;; undo as I like it
  (setq evil-want-fine-undo 't)
  (setq display-time-day-and-date t
        display-time-default-load-average nil
        display-time-24hr-format nil)
  (display-time)
  (global-set-key (kbd "<f1>") (lambda() (interactive)(find-file "~/.spacemacs.org")))
  (setq create-lockfiles nil)
  (defconst emacs-tmp-dir (format "%s/%s%s/" temporary-file-directory "emacs" (user-uid)))
  (setq backup-directory-alist `(("." . ,emacs-tmp-dir)))
  (setq auto-save-file-name-transforms `((".*" ,emacs-tmp-dir t)))
  (setq auto-save-list-file-prefix emacs-tmp-dir)
  (setq auto-save-interval 10000000)
  (setq auto-save-default nil)
  (add-hook 'python-mode-hook '(lambda ( )
                               (modify-syntax-entry ?_ "w" python-mode-syntax-table)))

  (add-hook 'js2-mode-hook '(lambda ( )
                                 (modify-syntax-entry ?_ "w" js2-mode-syntax-table)))
  (setq powerline-default-separator 'alternate)
  (eval-after-load 'yasnippet
    '(progn
       (define-key yas-keymap (kbd "TAB") nil)
       (define-key yas-minor-mode-map (kbd "<f6>") 'yas-expand)
       (define-key yas-keymap (kbd "<f6>") 'yas-expand)))
  (defun revert-buffer-no-confirm ()
    "Revert buffer without confirmation."
    (interactive) (revert-buffer t t))
  (global-set-key [f5] 'revert-buffer-no-confirm)

  (setq *is-a-mac* (eq system-type 'darwin))
  (setq *cygwin* (eq system-type 'cygwin) )
  (setq *linux* (or (eq system-type 'gnu/linux) (eq system-type 'linux)) )
  (defun copy-to-clipboard ()
    (interactive)
    (if (region-active-p)
        (progn
          (cond
           ((and (display-graphic-p) x-select-enable-clipboard)
            (x-set-selection 'CLIPBOARD (buffer-substring (region-beginning) (region-end))))
           (t (shell-command-on-region (region-beginning) (region-end)
                                       (cond
                                        (*cygwin* "putclip")
                                        (*is-a-mac* "pbcopy")
                                        (*linux* "xsel -ib")))
              ))
          (message "Yanked region to clipboard!")
          (deactivate-mark))
      (message "No region active; can't yank to clipboard!")))

  (defun paste-from-clipboard()
    (interactive)
    (cond
     ((and (display-graphic-p) x-select-enable-clipboard)
      (insert (x-get-selection 'CLIPBOARD)))
     (t (shell-command
         (cond
          (*cygwin* "getclip")
          (*is-a-mac* "pbpaste")
          (t "xsel -ob"))
         1))
     ))

  (defun my/paste-in-minibuffer ()
    (local-set-key (kbd "M-y") 'paste-from-x-clipboard)
    )
  (setq-default python-indent-offset 4)
  (setq-default dotspacemacs-configuration-layers '(
                                                    (python :variables python-formatter 'yapf)))
  (add-hook 'minibuffer-setup-hook 'my/paste-in-minibuffer)
  (global-set-key [f9] 'copy-to-clipboard)
  (global-set-key [f10] 'paste-from-clipboard)
  (defun evil-normalize-all-buffers ()
    "Force a drop to normal state."
    (unless (eq evil-state 'normal)
      (dolist (buffer (buffer-list))
        (set-buffer buffer)
        (unless (or (minibufferp)
                    (eq evil-state 'emacs))
          (evil-force-normal-state)))
      (message "Dropped back to normal state in all buffers")))
  (setq-default bidi-display-reordering nil)
  (defvar evil-normal-timer
    (run-with-idle-timer 10 t #'evil-normalize-all-buffers)
    "Drop back to normal state after idle for 10 seconds.")
   (remove-hook 'prog-mode-hook #'smartparens-mode)
   (spacemacs/toggle-smartparens-globally-off)
   (setq evilmi-always-simple-jump t)
   (global-set-key [f4] 'evil-avy-goto-char-2)
   (setq edit-server-new-frame nil)
   (edit-server-start)
   (define-key evil-normal-state-map (kbd "go") 'evil-avy-goto-word-0)
   (define-key evil-normal-state-map (kbd "gb") 'evil-avy-goto-char-timer)
   (define-key evil-normal-state-map (kbd "gh") 'evil-avy-goto-subword-1)
   ;; disable auto pairing in webmode
   (setq web-mode-enable-auto-closing nil)
   (setq web-mode-enable-auto-pairing nil)
   (setq flycheck-pylintrc "~/.pylintrc")
   (setq flycheck-python-pylint-executable "python3"))

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files
   (quote
    ("~/SWITCHdrive/me/today.org" "~/dotfiles/spacemacs/.spacemacs.org")))
 '(package-selected-packages
   (quote
    (log4e gntp json-snatcher json-reformat multiple-cursors parent-mode gitignore-mode marshal logito pcache flyspell-correct pos-tip flx ghub treepy graphql iedit anzu tide typescript-mode edit-server org-mime yasnippet async websocket gh company avy ht alert magit-popup with-editor hydra f winum vue-mode use-package osx-dictionary live-py-mode hy-mode helm-make evil-nerd-commenter evil-matchit dumb-jump column-enforce-mode dash-functional smartparens evil flycheck markdown-mode projectile magit org-plus-contrib helm helm-core js2-mode dash s yapfify yaml-mode ws-butler which-key web-mode web-beautify vue-html-mode volatile-highlights vi-tilde-fringe uuidgen  toc-org tagedit ssass-mode spaceline smeargle slim-mode scss-mode sass-mode reveal-in-osx-finder restclient-helm restart-emacs ranger rainbow-delimiters pyvenv pytest pyenv-mode py-isort pug-mode popwin pkg-info pip-requirements persp-mode pcre2el pbcopy paradox ox-reveal osx-trash orgit org-projectile org-present org-pomodoro org-download org-bullets open-junk-file ob-restclient ob-http neotree mu4e-maildirs-extension mu4e-alert move-text mmm-mode markdown-toc magit-gitflow magit-gh-pulls macrostep lua-mode lorem-ipsum livid-mode linum-relative link-hint less-css-mode launchctl keyfreq json-mode js2-refactor js-doc jinja2-mode info+ indent-guide hungry-delete htmlize hl-todo highlight-parentheses highlight-numbers highlight-indentation hide-comnt help-fns+ helm-themes helm-swoop helm-pydoc helm-projectile helm-mode-manager helm-gitignore helm-flx helm-descbinds helm-css-scss helm-company helm-c-yasnippet helm-ag goto-chg google-translate golden-ratio gnuplot github-search github-clone github-browse-file gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link git-commit gist gh-md fuzzy flyspell-correct-helm flycheck-pos-tip flx-ido fill-column-indicator fasd fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-terminal-cursor-changer evil-surround evil-snipe evil-search-highlight-persist evil-numbers evil-mc evil-magit evil-lisp-state evil-indent-plus evil-iedit-state evil-exchange evil-escape evil-ediff evil-args evil-anzu eval-sexp-fu emmet-mode elisp-slime-nav ein edit-indirect diminish cython-mode csv-mode company-web company-tern company-statistics company-restclient company-ansible company-anaconda coffee-mode clean-aindent-mode bind-key auto-yasnippet auto-highlight-symbol auto-dictionary auto-compile ansible-doc ansible aggressive-indent adaptive-wrap ace-window ace-link ace-jump-helm-line ac-ispell)))
 '(paradox-github-token t)
 '(python-indent-guess-indent-offset nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(defun dotspacemacs/emacs-custom-settings ()
  "Emacs custom settings.
This is an auto-generated function, do not modify its content directly, use
Emacs customize menu instead.
This function is called at the very end of Spacemacs initialization."
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files
   (quote
    ("~/SWITCHdrive/me/today.org" "~/dotfiles/spacemacs/.spacemacs.org")))
 '(package-selected-packages
   (quote
    (graphviz-dot-mode log4e gntp json-snatcher json-reformat multiple-cursors parent-mode gitignore-mode marshal logito pcache flyspell-correct pos-tip flx ghub treepy graphql iedit anzu tide typescript-mode edit-server org-mime yasnippet async websocket gh company avy ht alert magit-popup with-editor hydra f winum vue-mode use-package osx-dictionary live-py-mode hy-mode helm-make evil-nerd-commenter evil-matchit dumb-jump column-enforce-mode dash-functional smartparens evil flycheck markdown-mode projectile magit org-plus-contrib helm helm-core js2-mode dash s yapfify yaml-mode ws-butler which-key web-mode web-beautify vue-html-mode volatile-highlights vi-tilde-fringe uuidgen  toc-org tagedit ssass-mode spaceline smeargle slim-mode scss-mode sass-mode reveal-in-osx-finder restclient-helm restart-emacs ranger rainbow-delimiters pyvenv pytest pyenv-mode py-isort pug-mode popwin pkg-info pip-requirements persp-mode pcre2el pbcopy paradox ox-reveal osx-trash orgit org-projectile org-present org-pomodoro org-download org-bullets open-junk-file ob-restclient ob-http neotree mu4e-maildirs-extension mu4e-alert move-text mmm-mode markdown-toc magit-gitflow magit-gh-pulls macrostep lua-mode lorem-ipsum livid-mode linum-relative link-hint less-css-mode launchctl keyfreq json-mode js2-refactor js-doc jinja2-mode info+ indent-guide hungry-delete htmlize hl-todo highlight-parentheses highlight-numbers highlight-indentation hide-comnt help-fns+ helm-themes helm-swoop helm-pydoc helm-projectile helm-mode-manager helm-gitignore helm-flx helm-descbinds helm-css-scss helm-company helm-c-yasnippet helm-ag goto-chg google-translate golden-ratio gnuplot github-search github-clone github-browse-file gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link git-commit gist gh-md fuzzy flyspell-correct-helm flycheck-pos-tip flx-ido fill-column-indicator fasd fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-terminal-cursor-changer evil-surround evil-snipe evil-search-highlight-persist evil-numbers evil-mc evil-magit evil-lisp-state evil-indent-plus evil-iedit-state evil-exchange evil-escape evil-ediff evil-args evil-anzu eval-sexp-fu emmet-mode elisp-slime-nav ein edit-indirect diminish cython-mode csv-mode company-web company-tern company-statistics company-restclient company-ansible company-anaconda coffee-mode clean-aindent-mode bind-key auto-yasnippet auto-highlight-symbol auto-dictionary auto-compile ansible-doc ansible aggressive-indent adaptive-wrap ace-window ace-link ace-jump-helm-line ac-ispell)))
 '(paradox-github-token t)
 '(python-indent-guess-indent-offset nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
)
