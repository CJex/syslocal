; Use `Ctrl-h v` or `describe-variable` to see the value of `user-init-file`
; On Windows it is "~/AppData/Roaming/.emacs.d/init.el"
; Add `(load-file "/path/to/this/file.el")` to `user-init-file`


(setq debug-on-error t) ; Or `emacs.exe --debug-init`
(setq my-emacs-dir (file-name-directory load-file-name))
(setq my-site-lisp  (concat my-emacs-dir "site-lisp"))
(add-to-list 'load-path my-site-lisp)


; https://github.com/syl20bnr/spacemacs/commit/dcfc6e480a75a13cd1f538a849e2f1e33b1059c7#diff-feb6416c8fdef425d353c5bac2cd35f7
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")
(setq package-archives
  '(("melpa-cn" . "http://elpa.emacs-china.org/melpa/")
    ("melpa-stable-cn" . "http://elpa.emacs-china.org/melpa-stable/")
    ("marmalade-cn" . "http://elpa.emacs-china.org/marmalade/")
    ("org-cn"   . "http://elpa.emacs-china.org/org/")
    ("gnu-cn"   . "http://elpa.emacs-china.org/gnu/")
  ))

(setq package-check-signature nil)

(defun increase-gc-cons-threshold() (setq gc-cons-threshold 80000000))
(defun restore-gc-cons-threshold()  (setq gc-cons-threshold 800000))
(increase-gc-cons-threshold)
(add-hook 'emacs-startup-hook 'restore-gc-cons-threshold)
(add-hook 'minibuffer-setup-hook 'increase-gc-cons-threshold)
(add-hook 'minibuffer-exit-hook 'restore-gc-cons-threshold)


; Maximize window on start (deprecated, use `emacs.exe -mm` instead)
(add-to-list 'initial-frame-alist '(fullscreen . maximized))
(add-to-list 'default-frame-alist '(fullscreen . maximized))
(defun max-window ()
  "The value 0xF030 is the command for maximizing a window."
  (interactive)
  (when (eq system-type 'windows-nt)
    (w32-send-sys-command #xf030)))

(setq term-setup-hook 'max-window)
(setq window-setup-hook 'max-window)



(set-default-font "DejaVu Sans Mono-16")
(set-face-attribute 'default nil :font "DejaVu Sans Mono-16")

(set-foreground-color "Wheat")
(set-background-color "#091410")
(set-cursor-color "Orchid")
(set-mouse-color "Orchid")
(set-default-font "DejaVu Sans Mono-16")
(set-face-attribute 'default nil :font "DejaVu Sans Mono-16")

(tool-bar-mode -1)


;; Line Col number in bottom line
(column-number-mode t)
(line-number-mode t)

(setq default-tab-width 2)
(setq tab-width 2)

(cua-mode)

;; File path in title
(setq frame-title-format
      '("%S" (buffer-file-name "%f"
                               (dired-directory dired-directory "%b"))))

;; Disable backup file
(setq make-backup-files nil)

(fset 'yes-or-no-p 'y-or-n-p)

(setq current-language-environment "UTF-8")
(setq default-input-method "chinese-py")
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8-unix)

(setq dotspacemacs-check-for-update nil)
(setq dotspacemacs-elpa-https nil)
(setq dotspacemacs-elpa-timeout 666)
(setq spacemacs-start-directory (concat my-emacs-dir "spacemacs/"))
(load-file (concat spacemacs-start-directory "init.el"))

 














