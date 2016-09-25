(global-set-key [f2] 'ido-switch-buffer)
(global-set-key [f3] 'ibuffer)
(global-set-key [f4] 'ido-find-file)
(defun revert-buffer-no-confirm ()
      "Revert buffer without confirmation."
      (interactive) (revert-buffer t t))
(global-set-key [f5] 'revert-buffer-no-confirm)
(global-set-key [f6] 'rgrep)
(global-set-key [f7] 'linum-mode)
(global-set-key [f8] 'dired)

(global-set-key (kbd "C-x <up>") 'windmove-up)
(global-set-key (kbd "C-x <down>") 'windmove-down)
(global-set-key (kbd "C-x <right>") 'windmove-right)
(global-set-key (kbd "C-x <left>") 'windmove-left)
(setq mac-command-key-is-meta t)
(setq tab-width 4)
(setq column-number-mode t)
(setq-default indent-tabs-mode nil)
(menu-bar-mode -1)
(autoload 'linum-mode "linum" "toggle line numbers on/off" t)
(setq linum-format "%d ")

(setq vc-follow-symlinks t)
(setq create-lockfiles nil)
(defconst emacs-tmp-dir (format "%s/%s%s/" temporary-file-directory "emacs" (user-uid)))
(setq backup-directory-alist `(("." . ,emacs-tmp-dir)))
(setq auto-save-file-name-transforms `((".*" ,emacs-tmp-dir t)))
(setq auto-save-list-file-prefix emacs-tmp-dir)
(global-set-key "\C-cy" 'browse-kill-ring)


(defun comment-or-uncomment-region-or-line ()
    "Comments or uncomments the region or the current line if there's no active region."
    (interactive)
    (let (beg end)
        (if (region-active-p)
            (setq beg (region-beginning) end (region-end))
            (setq beg (line-beginning-position) end (line-end-position)))
        (comment-or-uncomment-region beg end)))
(global-set-key [f6] 'comment-or-uncomment-region-or-line)

;;to set foreground color to white
(set-foreground-color "white")

;; find file at point. ~ vi gf
(ffap-bindings)

;; tmux mangling
(global-set-key "\M-[1;5C"    'forward-word)  ; Ctrl+right   => forward word
(global-set-key "\M-[1;5D"    'backward-word) ; Ctrl+left    => backward word
;;to set background color to black
(set-background-color "black")

(setq transient-mark-mode t)
;;; Shell mode
(setq ansi-color-names-vector ; better contrast colors
      ["black" "red4" "green4" "yellow4"
       "green2" "magenta4" "cyan4" "white"])
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(setq comint-prompt-read-only t)

;;(add-to-list 'load-path "/home/courcol/.emacs.d/")
;;(require 'edit-server)
;;(edit-server-start)

;; web editing
;;(require 'web-mode)


;;(add-to-list 'load-path
;;              "~/.emacs.d/plugins/yasnippet")


(show-paren-mode 1)
(global-set-key "%" 'match-paren)
(defun match-paren (arg)
  "Go to the matching paren if on a paren; otherwise insert %."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
	((looking-at "\\s\)") (forward-char 1) (backward-list 1))
	(t (self-insert-command (or arg 1)))))

(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   '("melpa" . "http://melpa.org/packages/")
   t)
  (package-initialize))

(autoload 'bash-completion-dynamic-complete 
  "bash-completion"
  "BASH completion hook")
(add-hook 'shell-dynamic-complete-functions
  'bash-completion-dynamic-complete)
(add-hook 'shell-command-complete-functions
  'bash-completion-dynamic-complete)
;; Configure flymake for Python
(when (load "flymake" t)
  (defun flymake-checker-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      (list "emacs_checker.sh" (list local-file))))
  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.py\\'" flymake-checker-init)))

;; Configure to wait a bit longer after edits before starting
(setq-default flymake-no-changes-timeout '3)
;; dd
;; Keymaps to navigate to the errors
(add-hook 'python-mode-hook '(lambda () (define-key python-mode-map "\C-cn" 'flymake-goto-next-error)))
(add-hook 'python-mode-hook '(lambda () (define-key python-mode-map "\C-cp" 'flymake-goto-prev-error)))
;; To avoid having to mouse hover for the error message, these functions make flymake error messages
;; appear in the minibuffer
(defun show-fly-err-at-point ()
  "If the cursor is sitting on a flymake error, display the message in the minibuffer"
  (require 'cl)
  (interactive)
  (let ((line-no (line-number-at-pos)))
    (dolist (elem flymake-err-info)
      (if (eq (car elem) line-no)
      (let ((err (car (second elem))))
        (message "%s" (flymake-ler-text err)))))))

(add-hook 'post-command-hook 'show-fly-err-at-point)
(defadvice flymake-post-syntax-check (before flymake-force-check-was-interrupted)
    (setq flymake-check-was-interrupted t))
(ad-activate 'flymake-post-syntax-check)

(setq-default show-trailing-whitespace t)
(when (require 'browse-kill-ring nil 'noerror)
  (browse-kill-ring-default-keybindings))

(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))


;;(setq x-select-enable-clipboard t)
;;(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)
;;(xclip-mode 1)
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

(add-hook 'minibuffer-setup-hook 'my/paste-in-minibuffer)

;; (defun copy-to-clipboard ()
;;   (interactive)
;;   (if (display-graphic-p)
;;       (progn
;;         (message "Yanked region to x-clipboard!")
;;         (call-interactively 'clipboard-kill-ring-save)
;;         )
;;     (if (region-active-p)
;;         (progn
;;           (shell-command-on-region (region-beginning) (region-end) "xsel -i -b")
;;           (message "Yanked region to clipboard!")
;;           (deactivate-mark))
;;       (message "No region active; can't yank to clipboard!")))
;;   )

;; (defun paste-from-clipboard ()
;;   (interactive)
;;   (if (display-graphic-p)
;;       (progn
;;         (clipboard-yank)
;;         (message "graphics active")
;;         )
;;     (insert (shell-command-to-string "xsel -o -b"))
;;     )
;;   )

(global-set-key [f9] 'copy-to-clipboard)
(global-set-key [f10] 'paste-from-clipboard)

(require `ido)
(ido-mode 1)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)

(setq smex-save-file (expand-file-name ".smex-items" user-emacs-directory))
(global-set-key [remap execute-extended-command] 'smex)

;; ( if (eq system-type 'darwin)
;;     (setq interprogram-cut-function
;;     (lambda (text &optional push)
;;     (let* ((process-connection-type nil)
;;            (pbproxy (start-process "pbcopy" "pbcopy" "pbcopy")))
;;       (process-send-string pbproxy text)
;;       (process-send-eof pbproxy))))
;;   )

(load-theme 'zenburn t)


(setq inhibit-startup-message t)

;;(add-hook 'python-mode-hook 'jedi:setup)
;;(setq jedi:complete-on-dot t)

(require 'yasnippet)
(setq yas-snippet-dirs
      '("~/.snippets/"))
(yas-global-mode 1)

(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-hook 'js-mode-hook #'jscs-indent-apply)
(add-hook 'js2-mode-hook #'jscs-indent-apply)
(add-hook 'json-mode-hook #'jscs-indent-apply)
(add-hook 'js-mode-hook #'jscs-fix-run-before-save)
(add-hook 'js2-mode-hook #'jscs-fix-run-before-save)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files (quote ("~/todo.org"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:background nil))))
 '(js2-error ((t (:foreground "red" :weight bold))))
 '(js2-external-variable ((t (:foreground "red")))))

(global-hl-line-mode 1)
(set-face-background 'hl-line "#3e4446")
(require 'desktop+)
(setq python-shell-interpreter "ipython"
      python-shell-interpreter-args "--simple-prompt --pprint")
(elpy-enable)
;; Set as a minor mode for Python (to be after elpy)
(add-hook 'python-mode-hook '(lambda () (flymake-mode)))
(js2-imenu-extras-mode)
(winner-mode 1)
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.css?\\'" . web-mode))
(require 'ace-jump-mode)
(global-set-key (kbd "C-c SPC") 'ace-jump-mode)
(global-set-key (kbd "C-x SPC") 'fasd-find-file)
(global-fasd-mode 1)
(setq initial-scratch-message "")
(setq visible-bell t)
(fset 'yes-or-no-p 'y-or-n-p)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
  (require 'use-package)
;; (use-package etags
;;              :init (setq tags-revert-without-query 1))
;; (use-package ctags-update
;;   :ensure t
;;   :config
;;   (add-hook 'prog-mode-hook  'turn-on-ctags-auto-update-mode)
;;   :diminish ctags-auto-update-mode)
;; (setq tags-table-list '("~/.tags/TAGS"))
