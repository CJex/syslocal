



;; Begin RightClickContextMenu
(require 'cl-lib)
(require 'popup)
(require 'undo-tree)

(defgroup right-click-context ()
  "Right Click Context menu"
  :group 'convenience)

(defcustom right-click-context-interface 'popup-el
  "Menu interface for Right Click Context menu.")

(defcustom right-click-context-mode-lighter " RightClick"
  "Lighter displayed in mode line when `right-click-context-mode' is enabled.")

(defvar right-click-context-mode-map nil
  "Keymap used in right-click-context-mode.")

(unless right-click-context-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "<mouse-3>") 'right-click-context-menu)
    (setq right-click-context-mode-map map)))

(defcustom right-click-context-global-menu-tree
  '(("== Menu ==" :call (message "Fuck Emacs"))
    ("Copy" :call (kill-ring-save beg end) :if (use-region-p))
    ("Cut"  :call (kill-region beg end) :if (and (use-region-p) (not buffer-read-only)))
    ("Paste" :call (yank) :if (not buffer-read-only))
    ("Select"
     ("All"  :call (mark-whole-buffer) :if (not (use-region-p)))
     ("Word" :call (mark-word))
     ("Paragraph" :call (mark-paragraph))
     ;("Rectangle" :call rectangle-mark-mode)
    )
    ("Comment Region" :call comment-region :if (use-region-p))
    ("Comment Out Region" :call uncomment-region :if (use-region-p))
    ("Go To Dir" :call (find-file default-directory))
    ; ("ShowChar" :call (describe-char (point)) :if (not (use-region-p)))
    ; ("Undo" :call (if (and (not (eq nil buffer-undo-tree)) (fboundp 'undo-tree-undo)) 
                      ; (undo-tree-undo) (undo-only))
            ; :if (and 
                  ; (fboundp 'undo-tree-redo)
                  ; (not (eq nil buffer-undo-tree))    
                  ; (undo-tree-node-next 
                    ; (undo-tree-current buffer-undo-tree))))
            
    ; ("Redo" :call 
      ; (if (fboundp 'undo-tree-redo) (undo-tree-redo)) 
      ; :if (and 
            ; (fboundp 'undo-tree-redo)
            ; (not (eq nil buffer-undo-tree))    
            ; (undo-tree-node-previous 
              ; (undo-tree-current buffer-undo-tree))))
  )
  "Right Click Context menu.")

(defun right-click-context--build-menu-for-popup-el (tree)
  "Build right click menu for `popup.el' from `TREE'."
  (cl-loop
    for n from 0
    for (name . l) in tree
      if (not (stringp name)) return (error (format "Invalid tree. (%d-th elm)" n))
      if (or (null (plist-get l :if)) (eval (plist-get l :if)))
        if (listp (car l)) collect (cons name (right-click-context--build-menu-for-popup-el l))
        else collect (popup-make-item name :value (plist-get l :call))
  ))

(defvar right-click-context-local-menu-tree nil
  "Buffer local Right Click Menu.")
(make-variable-buffer-local 'right-click-context-local-menu-tree)

(defun right-click-context--menu-tree ()
  "Return right click menu tree."
  (cond ((and (symbolp right-click-context-local-menu-tree) (fboundp right-click-context-local-menu-tree)) (funcall right-click-context-local-menu-tree))
        (right-click-context-local-menu-tree right-click-context-local-menu-tree)
        (:else right-click-context-global-menu-tree)))

(defun right-click-context--process-region (begin end callback &rest args)
  "Convert string in region(BEGIN to END) by `CALLBACK' function call with additional arguments `ARGS'."
  (let ((region-string (buffer-substring-no-properties begin end))
        result)
    (setq result (apply callback region-string args))
    (if (null result)
        (error "Convert Error")
      (delete-region begin end)
      (insert result)
      (set-mark begin))))


(defun right-click-context-menu ()
  "Open Right Click Context menu."
  (interactive)
  (let ((value (popup-cascade-menu (right-click-context--build-menu-for-popup-el (right-click-context--menu-tree))))
        beg end)
    (when value
      (when (region-active-p)
        (setq beg (region-beginning))
        (setq end (region-end)))
      (if (symbolp value)
          (call-interactively value t)
        (eval value)))))

(global-set-key (kbd "<mouse-3>") 'right-click-context-menu)

(bind-key "C-c <mouse-3>" 'right-click-context-menu)
(bind-key "C-c :" 'right-click-context-menu)

;; End RightClickContextMenu