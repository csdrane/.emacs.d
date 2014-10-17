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
 '(iswitchb-mode nil)
 '(org-completion-use-ido t)
 '(org-habit-graph-column 80)
 '(org-modules (quote (org-bbdb org-bibtex org-docview org-gnus org-info org-jsinfo org-habit org-irc org-mew org-mhe org-rmail org-vm org-wl org-w3m)))
 '(org-outline-path-complete-in-steps nil)
 '(server-mode t)
 '(visible-bell t)
 '(winner-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(require 'use-package)
(use-package smex
  :bind
  ("M-x" . smex))

(require 'ido)
(ido-mode t)
(setq ido-everywhere t)
(setq ido-buffer-disable-smart-matches nil)
(setq ido-enable-flex-matching t)
(setq ido-use-filename-at-point 'guess)
(setq ido-use-url-at-point t)
(setq ido-create-new-buffer 'always)

(bind-key (kbd "C-x C-b") 'ibuffer)
(autoload 'ibuffer "ibuffer" "List buffers." t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Hacks courtesy of http://pages.sachachua.com/.emacs.d/Sacha.html
;; 

;; Don't care for this mode. Maybe try increasing time before help window pops up?
;; C-x page takes up half the screen.
;; (use-package guide-key
;;   :init
;;   (setq guide-key/guide-key-sequence '("C-x" "C-x r" "C-x 4" "C-c"))
;;   (guide-key-mode 1))  ; Enable guide-key-mode

;; Pop to mark
;; Handy way of getting back to previous places.

(bind-key "C-x p" 'pop-to-mark-command)
(setq set-mark-command-repeat-pop t)

(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))
(setq vc-make-backup-files t)
(setq sentence-end-double-space nil)


;; Windmove lets you move between windows with something more natural than cycling through C-x o (other-window). Windmove doesn't behave well with Org, so we need to use different keybindings.
(use-package windmove
  :bind
  (("<f2> <right>" . windmove-right)
   ("<f2> <left>" . windmove-left)
   ("<f2> <up>" . windmove-up)
   ("<f2> <down>" . windmove-down)))

(remove-hook 'text-mode-hook #'turn-on-auto-fill)
(add-hook 'text-mode-hook 'turn-on-visual-line-mode)

;; Note about below: would want to replace C-k binding with kill-region.
;; Choosing not to install below in order to preserve paredit kill line hack below.
;; (defadvice kill-region (before slick-cut activate compile)
;;   "When called interactively with no active region, kill a single line instead."
;;   (interactive
;;     (if mark-active (list (region-beginning) (region-end))
;;       (list (line-beginning-position)
;;         (line-beginning-position 2)))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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
(define-key input-decode-map "\e[1;13Q" [M-S-return])
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

;;
;; Org Mode
;;

;; Suggested Org Mode global keybindings
;; https://www.gnu.org/software/emacs/manual/html_node/org/Activation.html#Activation
(bind-key "\C-cl" 'org-store-link)
(bind-key "\C-cc" 'org-capture)
(bind-key "\C-ca" 'org-agenda)
(bind-key "\C-cb" 'org-iswitchb)
;; Local keybindings
(eval-after-load 'org-mode
  '(progn
     '(define-key org-mode-map "\C-c[" 'org-agenda-file-to-front)
     '(define-key org-mode-map "\C-c]" 'org-remove-file)))

(setq org-catch-invisible-edits 'smart)
(setq org-startup-indented t)
(setq org-global-properties
      '(("Effort_ALL". "0:05 0:15 0:30 1:00 2:00 3:00 4:00")))

;; Track TODO state changes
;; https://www.gnu.org/software/emacs/manual/html_node/org/Tracking-TODO-state-changes.html#Tracking-TODO-state-changes
(setq org-todo-keywords
      '((sequence "TODO(t)" "WAIT(w@/!)" "|" "DONE(d!)" "CANCELED(c@)")))
;; Org-refile
(setq org-refile-targets '((nil :maxlevel . 2)
			   (org-agenda-files :maxlevel . 2)))
;; Org-capture
(setq org-directory "~/Documents/Personal/GTD")
(setq org-agenda-files '("~/Documents/Personal/GTD/GTD Review.org" "~/Documents/Personal/GTD/journal.org"))

(setq org-default-capture-file (concat org-directory "/capture-notes.org"))
(defvar chris/org-basic-task-template "* TODO %^{Task}    
SCHEDULED: %^t
%?
:PROPERTIES:
:Effort: %^{effort|1:00|0:05|0:15|0:30|2:00|4:00}
:END:" "Basic task data")
(setq org-capture-templates
      `(("j" "Journal" entry (file+datetree (concat org-directory "/journal.org"))
	 "* %?\nEntered on %U\n  %i\n  %a")  
	("n" "Note" entry (file+headline (concat org-directory "/GTD Review.org") "Notes")
	 "")
	("t" "Task" entry (file org-default-capture-file)
	 ,chris/org-basic-task-template)))

;;
;; Misc. hacks
;;

;; C-n adds newline
(setq next-line-add-newlines t)

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
(bind-key (kbd "C-x C-r") 'rename-current-buffer-file)

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
 
