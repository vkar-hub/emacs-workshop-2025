;;; init.el --- Minimal Workshop Emacs Config (Org + Org-roam + Ivy)

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

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; -----------------------------------------
;; Basic UI cleanup
;; -----------------------------------------
(setq inhibit-startup-message t)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(tooltip-mode -1)

(global-visual-line-mode 1)
(setq visible-bell t)

(set-face-attribute 'default nil :height 140)

;; Split windows vertically by default
(setq split-height-threshold nil)
(setq split-width-threshold 0)

;; -----------------------------------------
;; IVY + COUNSEL + SWIPER
;; -----------------------------------------

(use-package ivy
  :diminish
  :config
  (ivy-mode 1)
  :custom
  (ivy-use-virtual-buffers t)
  (ivy-count-format "(%d/%d) ")
  (ivy-wrap t))

(use-package counsel
  :after ivy
  :bind (("M-x"     . counsel-M-x)
         ("C-x C-f" . counsel-find-file)
         ("C-c f"   . counsel-recentf)
         ("C-c g"   . counsel-git)
         ("C-c k"   . counsel-rg)))

(use-package swiper
  :after ivy
  :bind (("C-s" . swiper)
         ("C-r" . swiper)))

;; -----------------------------------------
;; Org Mode
;; -----------------------------------------
(use-package org
  :hook (org-mode . visual-line-mode)
  :custom
  (org-hide-emphasis-markers t)
  (org-startup-with-inline-images t)
  (org-image-actual-width '(300))
  (org-directory "~/org")
  (org-agenda-files (directory-files-recursively "~/org" "\\.org$"))
  (org-todo-keywords '((sequence "TODO(t)" "WAIT(w)" "|" "DONE(d)" "CANCELLED(c)")))
  :bind (("C-c a" . org-agenda)
         ("C-c c" . org-capture)))

(setq org-default-notes-file "~/org/inbox.org")

(setq org-capture-templates
      '(("t" "Todo" entry (file "~/org/inbox.org")
         "* TODO %?\n  %U")))

;; -----------------------------------------
;; Org-roam
;; -----------------------------------------
(use-package org-roam
  :init
  (setq org-roam-v2-ack t)
  :custom
  (org-roam-directory (file-truename "~/org/roam"))
  :config
  (org-roam-db-autosync-mode)
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert)))

;; -----------------------------------------
;; UTF-8 everywhere
;; -----------------------------------------
(prefer-coding-system 'utf-8)
(set-language-environment "UTF-8")

(provide 'init)
;;; init.el ends here
