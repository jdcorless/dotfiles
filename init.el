;; Bootstrap the current version of org-mode
(package-initialize nil)
(add-to-list 'load-path "~/git/org-mode/contrib/lisp")
(add-to-list 'load-path "~/git/org-mode/lisp")
(require 'package)
(package-initialize t)
(setq package-enable-at-startup nil)
(require 'org)
(require 'ob-tangle)

;; Run myinit.org, which is my primary config file
(org-babel-load-file (expand-file-name "~/.emacs.d/myinit.org"))
