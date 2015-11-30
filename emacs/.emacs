(global-set-key [f4] 'goto-line)
(global-set-key [f3] 'shell)
;;(global-set-key [f5] 'query-replace)
;;(global-set-key [f6] 'switch-to-buffer)
(global-set-key [f6] 'rgrep)
(global-set-key [f2] 'buffer-menu)
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

(require `ido)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

(defun revert-buffer-no-confirm ()
      "Revert buffer without confirmation."
      (interactive) (revert-buffer t t))
(global-set-key [f5] 'revert-buffer-no-confirm)
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

(defvar ack-history nil
  "History for the `ack' command.")

(defun ack (command-args)
  (interactive
   (let ((ack-command "ack --nogroup --with-filename --all "))
     (list (read-shell-command "Run ack (like this): "
                               ack-command
                               'ack-history))))
  (let ((compilation-disable-input t))
    (compilation-start (concat command-args " < " null-device)
                       'grep-mode)))

(global-set-key [f7] 'ack)
(add-to-list 'load-path "/home/courcol/.emacs.d/")
;;(require 'edit-server)
;;(edit-server-start)

;; web editing
;;(require 'web-mode)
;;(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

;;(add-to-list 'load-path
;;              "~/.emacs.d/plugins/yasnippet")
;;(require 'yasnippet)
;;(setq yas-snippet-dirs
;;      '("~/.emacs.d/snippets"))
;;(yas-global-mode 1)
;;(define-key yas-minor-mode-map [(tab)] nil)
;;(define-key yas-minor-mode-map (kbd "TAB") nil)
;;(define-key yas-minor-mode-map (kbd "<tab>") nil)
;;(define-key yas-keymap [(tab)] nil)
;;(define-key yas-keymap (kbd "TAB") nil)


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
      (list "/home/courcol/tools/emacs_checker/emacs_checker.sh" (list local-file))))
  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.py\\'" flymake-checker-init)))

;; Set as a minor mode for Python
(add-hook 'python-mode-hook '(lambda () (flymake-mode)))
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


(setq x-select-enable-clipboard t)
(xclip-mode 1)
;;(setq interprogram-cut-function
;;      (lambda (text &optional push)
;;    (let* ((process-connection-type nil)
;;           (pbproxy (start-process "pbcopy" "pbcopy" "pbcopy")))
;;      (process-send-string pbproxy text)
;;      (process-send-eof pbproxy))))
(load-theme 'zenburn t)
