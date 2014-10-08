(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/"))
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (manoj-dark)))
 '(custom-safe-themes (quote ("1e7e097ec8cb1f8c3a912d7e1e0331caeed49fef6cff220be63bd2a6ba4cc365" "fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "e16a771a13a202ee6e276d06098bc77f008b73bbac4d526f160faa2d76c1dd0e" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default)))
 '(org-agenda-files (quote ("~/Documents/Personal/GTD/GTD Review.org")))
 '(visible-bell t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;; Fix Shift-Up bug with iTerm2
;; Solution per  https://groups.google.com/forum/#!topic/gnu.emacs.help/rR478H4BDU8
(define-key input-decode-map "\e[1;2A" [S-up])
(if (equal "xterm" (tty-type))
    (define-key input-decode-map "\e[1;2A" [S-up]))
(defadvice terminal-init-xterm (after select-shift-up activate)
  (define-key input-decode-map "\e[1;2A" [S-up]))
;; iTerm2 key configs
(define-key input-decode-map "\e[1;10A" [M-S-up])
(define-key input-decode-map "\e[1;10B" [M-S-down])
(define-key input-decode-map "\e[1;10C" [M-S-right])
(define-key input-decode-map "\e[1;10D" [M-S-left])
(define-key input-decode-map "\e[1;9A" [M-up])
(define-key input-decode-map "\e[1;9B" [M-down])
(define-key input-decode-map "\e[1;9C" [M-right])
(define-key input-decode-map "\e[1;9D" [M-left])
(define-key input-decode-map "\e[1;12C" [M-C-right])
(define-key input-decode-map "\e[1;12D" [M-C-left])
;; CIDER auto-completion
(global-company-mode)
;; Install ElDoc
(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
(add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)
;; Integrate with CIDER / Clojure
(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
;; Install ParEdit
(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
(add-hook 'clojure-mode-hook          #'enable-paredit-mode)
(add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
(add-hook 'ielm-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
(add-hook 'scheme-mode-hook           #'enable-paredit-mode)
;; To use ParEdit with ElDoc, you should make ElDoc aware of ParEdit’s most used commands:
(require 'eldoc) ; if not already loaded
(eldoc-add-command
 'paredit-backward-delete
 'paredit-close-round)
;; ParEdit in REPL sessions 
(add-hook 'cider-repl-mode-hook 'paredit-mode)
;; Stop SLIME's REPL from grabbing DEL,
;; which is annoying when backspacing over a '('
(defun override-slime-repl-bindings-with-paredit ()
  (define-key slime-repl-mode-map
    (read-kbd-macro paredit-backward-delete-key)
    nil))
(add-hook 'slime-repl-mode-hook 'override-slime-repl-bindings-with-paredit)
;; Show Paren Mode
;; When point is on one of the paired characters, the other is highlighted. 
;; http://www.emacswiki.org/emacs/ShowParenMode
(show-paren-mode 1)
(add-hook 'clojure-mode-hook 'show-paren-mode) 
;; Install Rainbow Delimiters
(require 'rainbow-delimiters)
(add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)
(add-hook 'cider-repl-mode-hook 'rainbow-delimiters-mode)
;; Install Solarized
(add-to-list 'custom-theme-load-path "~/.emacs.d/elpa/emacs-color-theme-solarized")
(setq solarized-termcolors 256)
(load-theme 'solarized-dark t)
;; Better indentation for Compojure macros
;; https://github.com/weavejester/compojure/wiki/Emacs-indentation 
(require 'clojure-mode)
(define-clojure-indent
  (defroutes 'defun)
  (GET 2)
  (POST 2)
  (PUT 2)
  (DELETE 2)
  (HEAD 2)
  (ANY 2)
  (context 2))
;; Suggested Org Mode global keybindings
;; https://www.gnu.org/software/emacs/manual/html_node/org/Activation.html#Activation
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
;; Org Mode local keybindings
(eval-after-load 'org-mode
  '(progn
     '(define-key org-mode-map "\C-c[" 'org-agenda-file-to-front)
     '(define-key org-mode-map "\C-c]" 'org-remove-file)))
;; Setting up Org Mode capture
(setq org-directory "~/Documents/Personal/GTD")
(setq org-default-notes-file (concat org-directory "/capture-notes.org"))
(define-key global-map "\C-cc" 'org-capture)
;; Renames current buffer and file it is visiting. 
;; http://whattheemacsd.com/
(defun rename-current-buffer-file ()
  "Renames current buffer and file it is visiting."
  (interactive)
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
        (error "Buffer '%s' is not visiting a file!" name)
      (let ((new-name (read-file-name "New name: " filename)))
        (if (get-buffer new-name)
            (error "A buffer named '%s' already exists!" new-name)
          (rename-file filename new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil)
          (message "File '%s' successfully renamed to '%s'"
                   name (file-name-nondirectory new-name)))))))

(global-set-key (kbd "C-x C-r") 'rename-current-buffer-file)
;; Toggle between horizontal and vertical layout of two windows.
;; http://whattheemacsd.com/
(defun toggle-window-split ()
  (interactive)
  (if (= (count-windows) 2)
      (let* ((this-win-buffer (window-buffer))
             (next-win-buffer (window-buffer (next-window)))
             (this-win-edges (window-edges (selected-window)))
             (next-win-edges (window-edges (next-window)))
             (this-win-2nd (not (and (<= (car this-win-edges)
                                         (car next-win-edges))
                                     (<= (cadr this-win-edges)
                                         (cadr next-win-edges)))))
             (splitter
              (if (= (car this-win-edges)
                     (car (window-edges (next-window))))
                  'split-window-horizontally
                'split-window-vertically)))
        (delete-other-windows)
        (let ((first-win (selected-window)))
          (funcall splitter)
          (if this-win-2nd (other-window 1))
          (set-window-buffer (selected-window) this-win-buffer)
          (set-window-buffer (next-window) next-win-buffer)
          (select-window first-win)
          (if this-win-2nd (other-window 1))))))
;; Making paredit work with delete-selection-mode
;; C-w on highlighted region will no longer delete only
;; one side of the parentheses.
;; http://whattheemacsd.com/
(put 'paredit-forward-delete 'delete-selection 'supersede)
(put 'paredit-backward-delete 'delete-selection 'supersede)
(put 'paredit-open-round 'delete-selection t)
(put 'paredit-open-square 'delete-selection t)
(put 'paredit-doublequote 'delete-selection t)
(put 'paredit-newline 'delete-selection t)
;; Smex
(autoload 'smex "smex"
  "Smex is a M-x enhancement for Emacs, it provides a convenient interface to
your recently and most frequently used commands.")
(global-set-key (kbd "M-x") 'smex)
;; IDO
(require 'ido)
(ido-mode t)
;; ibuffer; replace stock buffer list
(global-set-key (kbd "C-x C-b") 'ibuffer)
(autoload 'ibuffer "ibuffer" "List buffers." t)
 
