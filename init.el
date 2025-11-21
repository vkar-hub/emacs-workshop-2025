;;; init.el --- Minimal Workshop Emacs Config

;; -----------------------------------------
;; Package manager setup
;; -----------------------------------------
(require 'package)

(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ("elpa"  . "https://elpa.gnu.org/packages/")
        ("org"   . "https://orgmode.org/elpa/")))

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

;; Install use-package if missing
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; -----------------------------------------
;; Basic UI cleanup
;; -----------------------------------------
(setq inhibit-startup-message t)   ; no welcome screen
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(tooltip-mode -1)

(global-visual-line-mode 1)        ; wrap lines naturally
(setq visible-bell t)              ; no beep

;; A readable default font (safe)
(set-face-attribute 'default nil :height 140)

;; Split windows vertically by default
(setq split-height-threshold nil)
(setq split-width-threshold 0)

;; -----------------------------------------
;; Org Mode
;; -----------------------------------------
(use-package org
  :hook (org-mode . visual-line-mode)
  :custom
  (org-hide-emphasis-markers t)
  (org-startup-with-inline-images t)
  (org-image-actual-width '(300))
  (org-directory "~/org")                    ; default notes location
  (org-agenda-files (directory-files-recursively "~/org" "\\.org$"))
  (org-todo-keywords '((sequence "TODO(t)" "WAIT(w)" "|" "DONE(d)" "CANCELLED(c)")))
  :bind (("C-c a" . org-agenda)
         ("C-c c" . org-capture)))

(setq org-default-notes-file "~/org/inbox.org")

;; Simple capture template
(setq org-capture-templates
      '(("t" "Todo" entry (file "~/org/inbox.org")
         "* TODO %?\n  %U")))

;; -----------------------------------------
;; Org-roam
;; -----------------------------------------
(use-package org-roam
  :init
  (setq org-roam-v2-ack t) ; prevent v2 upgrade prompt
  :custom
  (org-roam-directory (file-truename "~/org/roam"))
  :config
  (org-roam-db-autosync-mode)
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert)))

;; -----------------------------------------
;; UTF-8 everywhere (avoids encoding bugs)
;; -----------------------------------------
(prefer-coding-system 'utf-8)
(set-language-environment "UTF-8")

(provide 'init)
;;; init.el ends here

