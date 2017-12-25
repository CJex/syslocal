;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.
;; Add `(load-file "/path/to/this/file.el")` to ~/.spacemacs


(setq my-emacs-dir (file-name-directory load-file-name))


(defun dotspacemacs/layers ()
  "Configuration Layers declaration.You should not put any user code in this function besides modifying the variable values."
  (setq-default
      dotspacemacs-configuration-layer-path (list (concat my-emacs-dir "site-lisp"))
      dotspacemacs-configuration-layers
      '(
        ;; ----------------------------------------------------------------
        ;; Example of useful layers you may want to use right away.
        ;; Uncomment some layer names and press <SPC f e R> (Vim style) or
        ;; <M-m f e R> (Emacs style) to install them.
        ;; ----------------------------------------------------------------
        haskell
        coq
        helm
        emacs-lisp
        ; semantic
        auto-completion
        themes-megapack)

      ;; List of additional packages that will be installed without being
      ;; wrapped in a layer. If you need some configuration for these
      ;; packages, then consider creating a layer. You can also put the
      ;; configuration in `dotspacemacs/user-config'.
      dotspacemacs-additional-packages '(
        company-coq color-theme-modern desktop tabbar ido evil popup cl-lib undo-tree
      )

      ;; A list of packages that cannot be updated.
      dotspacemacs-frozen-packages '()
      ;; A list of packages that will not be installed and loaded.
      dotspacemacs-excluded-packages '()
      dotspacemacs-install-packages 'used-only
  )
)

(defun dotspacemacs/init ()
  "Initialization function. This function is called at the very startup of Spacemacs initialization before layers configuration. You should not put any user code in there besides modifying the variable values."
  (setq-default
      dotspacemacs-elpa-https nil
      dotspacemacs-elpa-timeout 666
      dotspacemacs-check-for-update nil
      dotspacemacs-elpa-subdirectory nil
      dotspacemacs-editing-style 'vim
      dotspacemacs-verbose-loading t
      dotspacemacs-auto-resume-layouts t

      dotspacemacs-startup-lists '((recents . 5)
                                  (projects . 7))

      ;; Press <SPC> T n to cycle to the next theme in the list
      dotspacemacs-themes '(deeper-blue spolsky arjen spacemacs-dark spacemacs-light)

      dotspacemacs-default-font '("DejaVu Sans Mono"
                                    :size 20
                                    :weight normal
                                    :width normal
                                    :powerline-scale 1.1)

      dotspacemacs-maximized-at-startup t

      dotspacemacs-mode-line-unicode-symbols t

      ;; List of search tool executable names. Spacemacs uses the first installed
      ;; tool of the list. Supported tools are `ag', `pt', `ack' and `grep'.
      ;; (default '("ag" "pt" "ack" "grep"))
      dotspacemacs-search-tools '("ag" "pt" "ack" "grep")

      dotspacemacs-whitespace-cleanup "trailing"
  )
)

(defun dotspacemacs/user-init ()
  "Initialization function for user code. It is called immediately after `dotspacemacs/init', before layer configuration executes. This function is mostly useful for variables that need to be set before packages are loaded. If you are unsure, you should try in setting them in `dotspacemacs/user-config' first."
  (setq proof-general-path (concat my-emacs-dir "site-lisp/PG/generic/proof-site"))
  (setq evil-want-abbrev-expand-on-insert-exit nil)
  (setq coq-mode-abbrev-table '())
)

(defun dotspacemacs/user-config ()
  "Configuration function for user code. This function is called at the very end of Spacemacs initialization after layers configuration. This is the place where most of your configurations should be done. Unless it is explicitly specified that a variable should be set before a package is loaded, you should place your code here."
  ;; Set fallback fonts for Math Symbols
  (set-fontset-font t 'unicode (font-spec :name "Cambria Math") nil 'append)
  (set-fontset-font t 'unicode (font-spec :name "Symbola") nil 'append)

  (setq create-lockfiles nil)
  (fset 'evil-visual-update-x-selection 'ignore)

  ;; Line Col number in bottom line
  (column-number-mode t)
  (line-number-mode t)

  (cua-mode t)

  (setq default-tab-width 2)
  (setq tab-width 2)

  ;; File path in title
  (setq frame-title-format
    '("%S" (buffer-file-name "%f" (dired-directory dired-directory "%b"))))

  (tabbar-mode t)
  (use-package tabbar
    :bind
    (
      ;通过Alt-x describe-key [按键] 及C-x ESC ESC ESC的方法
      ([(shift tab)] . 'tabbar-backward)
      ([(control tab)]. 'tabbar-forward)
    )

    :init
    (setq tabbar-buffer-groups-function (lambda () (list
      (cond
        ((string-match-p (regexp-quote "*") (buffer-name)) "Emacs Buffer")
        ((eq major-mode 'dired-mode) "Dired")
        (t "User Buffer")
      ))))
    ; This seems not work
    (setq tabbar-buffer-list-function
        (lambda
          (remove-if
            (lambda(buffer)
              (and (string-match-p (regexp-quote "*") (buffer-name buffer))
                   (not (member (buffer-name buffer) '("*scratch*" "*Messages*" "*spacemacs*")))) )
            (buffer-list))))
    (tabbar-mode t)

    ;; 设置tabbar外观
    ; (setq tabbar-use-images nil)
    (set-face-attribute 'tabbar-default nil
                        :font "DejaVu Sans Mono-20"
                        :background "navy"
                        :foreground "white"
                        :height 1.2
                        )
    (set-face-attribute 'tabbar-button nil
                        :background "dodgerblue"
                        :foreground "white"
                        :height 1.2
                        :box '(:line-width 2 :color "#00B2BF")
                        )
    (set-face-attribute 'tabbar-selected nil
                        :inherit 'tabbar-default
                        :foreground "white"
                        :background "darkgreen"
                        :weight 'bold
                        :box '(:line-width 2 :color "deepskyblue")
                        )
    (set-face-attribute 'tabbar-selected-modified nil
                        :inherit 'tabbar-selected 
                        :foreground "white"
                        :underline "lime"
                        )
    (set-face-attribute 'tabbar-unselected nil
                        :inherit 'tabbar-default
                        :box '(:line-width 2 :color "#00B2BF")
                        )

  ) ;; End tabbar


  ; (use-package desktop
    ; :init
    ; (desktop-save-mode 1)
    ; (defun my-desktop-save()
      ; (interactive)
      ; ;; Don't call desktop-save-in-desktop-dir, as it prints a message.
      ; (if (eq (desktop-owner) (emacs-pid))
          ; (desktop-save desktop-dirname)
          ; ;; (message (concat "Wrote:" desktop-dirname))
        ; ))

    ; (add-hook 'auto-save-hook 'my-desktop-save t)
    ; (add-hook 'before-save-hook 'delete-trailing-whitespace)
    ; (add-to-list 'desktop-modes-not-to-save 'dired-mode)
    ; (add-to-list 'desktop-modes-not-to-save 'Info-mode)
    ; (add-to-list 'desktop-modes-not-to-save 'info-lookup-mode)
    ; (add-to-list 'desktop-modes-not-to-save 'fundamental-mode)
  ; )


)
