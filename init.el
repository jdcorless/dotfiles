;; JDC init.el file for Emacs customization
;; I am following Avdi Grimm's setup, for instance
;; http://devblog.avdi.org/2011/09/08/emacs-reboot-4-customizing-customization/
;; and the like

(setq jdc-emacs-init-file user-init-file)
(setq jdc-emacs-config-dir user-emacs-directory)
;; (setq jdc-emacs-config-dir
;;       (file-name-directory jdc-emacs-init-file))

;; Set up 'custom' system for customizations made in Emacs
(setq custom-file (expand-file-name "emacs-customizations.el" jdc-emacs-config-dir))
(load custom-file)

;; Package archives, package loading
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)


(setq jdc-required-packages
      (list 'dirtree
	    'magit
            'smex
            'ido
            'ido-vertical-mode
            'window-number
            'ess
            'ein
            'markdown-mode
	    'eclipse-theme
	    'htmlize
	    'auto-compile
	    'elpy
	    'vimgolf
	    'ob-ipython
	    )
      )

(dolist (package jdc-required-packages)
  (when (not (package-installed-p package))
    (package-refresh-contents)
    (package-install package)))

(setq backup-directory-alist
      (list (cons "." (expand-file-name "backup" user-emacs-directory))))


;; Byte compile
;;; init.el --- user init file      -*- no-byte-compile: t -*-
(setq load-prefer-newer t)
(add-to-list 'load-path "/path/to/dash")
(add-to-list 'load-path "/path/to/packed")
(add-to-list 'load-path "/path/to/auto-compile")
(require 'auto-compile)
(auto-compile-on-load-mode 1)
(auto-compile-on-save-mode 1)

;; Dirtree mode
(require 'dirtree)

;; Ido mode
(require 'ido)
(require 'ido-vertical-mode)
(require 'smex)
(global-set-key (kbd "M-x") 'smex)
(ido-mode 1)
(ido-vertical-mode 1)
;; Window number mode
;; C-x 3 splits window vertically, C-x 2 horizontally
;; This mode allows more direct switching to windows
;; than C-x o cycling by labelling each window in mode line
;; C-x C-j followed by a number changes to that window
(require 'window-number)
(window-number-mode 1)

;; Try to fix slow windows behavior
;; (setq w32-get-true-file-attributes nil)

;; Scheme config
;; Enable Quack mode
;; The binary of your interpreter
;; (setq scheme-program-name "mzscheme")
;; This hook lets you use your theme colours instead of quack's ones
;; (defun scheme-mode-quack-hook () 
;;   (require 'quack) (setq quack-fontify-style 'emacs))
;; (add-hook 'scheme-mode-hook 'scheme-mode-quack-hook)


;; Elpy
(elpy-enable)
(elpy-use-ipython "~/anaconda3/bin/ipython")

;; Set up ipython as default interpreter
;;(when (executable-find "ipython")
;;  (setq
;;   python-shell-interpreter "ipython"
;;   python-shell-interpreter-args ""
;;   python-shell-prompt-regexp "In \\[[0-9]+\\]: "
;;   python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
;;   python-shell-completion-setup-code
;;   "from IPython.core.completerlib import module_completion"
;;   python-shell-completion-module-string-code
;;   "';'.join(module_completion('''%s'''))\n"
;;   python-shell-completion-string-code
;;   "';'.join(get_ipython().Completer.all_completions('''%s'''))\n"))

;; Set theme
;; adwaita is nice light theme, wombat is dark-grey, deeper-blue is
;; dark with a blue hue
;; (load-theme 'wombat t)
;; (disable-theme 'wombat)
;; (load-theme 'adwaita t)
;; (disable-theme 'adwaita)
;; (load-theme 'deeper-blue t)
;; (disable-theme 'deeper-blue)
(require 'eclipse-theme)

;; Font selection
;; (set-face-attribute 'default nil :family "Consolas" :height 100)
;; (set-face-attribute 'default nil :family "DejaVu Sans Mono" :height 100)
;; (set-face-attribute 'default nil :family "Source Code Pro Light" :height 100)

;; Some modes
(column-number-mode 1)
(ido-mode 1)
(show-paren-mode 1)
;; (global-visual-line-mode 1)
;; (mouse-avoidance-mode 'banish)

;; Some customizations from Bastien Guerry's emacs simplified

;; Prevent the cursor from blinking
(blink-cursor-mode 0)

;; Don't let Emacs hurt your ears
(setq visible-bell nil)

;; Who still use the scrollbar to scroll?
(scroll-bar-mode 0)

;; The toolbar ???  Com'on.
(tool-bar-mode 0)

;; A small minor mode to use a big fringe
;; (defvar jdc-big-fringe-mode nil)
;; (define-minor-mode jdc-big-fringe-mode
;;   "Minor mode to use big fringe in the current buffer."
;;   :init-value nil
;;   :global t
;;   :variable jdc-big-fringe-mode
;;   :group 'editing-basics
;;   (if (not jdc-big-fringe-mode)
;;       (set-fringe-style nil)
;;     (set-fringe-mode
;;      (/ (- (frame-pixel-width)
;;            (* 100 (frame-char-width)))
;;         2))))

;; Now activate this global minor mode
;; (jdc-big-fringe-mode 1)

;; Some useful functions
(defun eval-and-replace ()
  "Replace the preceding sexp with its value."
  (interactive)
  (backward-kill-sexp)
  (condition-case nil
      (prin1 (eval (read (current-kill 0)))
             (current-buffer))
    (error (message "Invalid expression")
           (insert (current-kill 0)))))

(global-set-key (kbd "C-c e") 'eval-and-replace)

;; Set up org-mode
(add-to-list 'load-path "~/git/org-mode/lisp")
(add-to-list 'load-path "~/git/org-mode/contrib/lisp" t)
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)

(org-babel-do-load-languages
 'org-babel-load-languages
 '(
   (sh . t)
   (python . t)
   (R . t)
   (ditaa . t)
   (dot . t)
   (sqlite . t)
   ))

(setq org-enforce-todo-checkbox-dependencies t)
(setq org-enforce-todo-dependencies t)
;; Per post at http://kitchingroup.cheme.cmu.edu/blog/2015/03/12/Making-org-mode-Python-sessions-look-better/
;; This makes Python output in session mode clean up all the extra
;; >>> and ...
(defun org-babel-python-strip-session-chars ()
  "Remove >>> and ... from a Python session output."
  (when (and (string=
              "python"
              (org-element-property :language (org-element-at-point)))
             (string-match
              ":session"
              (org-element-property :parameters (org-element-at-point))))

    (save-excursion
      (when (org-babel-where-is-src-block-result)
        (goto-char (org-babel-where-is-src-block-result))
        (end-of-line 1)
        ;(while (looking-at "[\n\r\t\f ]") (forward-char 1))
        (while (re-search-forward
                "\\(>>> \\|\\.\\.\\. \\|: $\\|: >>>$\\)"
                (org-element-property :end (org-element-at-point))
                t)
          (replace-match "")
          ;; this enables us to get rid of blank lines and blank : >>>
          (beginning-of-line)
          (when (looking-at "^$")
            (kill-line)))))))

(add-hook 'org-babel-after-execute-hook 'org-babel-python-strip-session-chars)

;; Scrolling
;; Keep cursor at same position when scrolling
(setq scroll-preserve-screen-position 1)
;; Scroll window up/down by one line
(global-set-key (kbd "M-n") (kbd "C-u 1 C-v"))
(global-set-key (kbd "M-p") (kbd "C-u 1 M-v"))

;; Set up magit
(global-set-key (kbd "C-x g") 'magit-status)

;; Global hl-line-mode
(global-hl-line-mode)

;; Set up ipython as org-mode language
(require 'ob-ipython)
