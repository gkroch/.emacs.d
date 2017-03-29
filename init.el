;;; Gabriel Kroch's Emacs Config File

;; Personal Info
(setq user-full-name "Gabriel Kroch"
      user-mail-address "gabriel.kroch@gmail.com")

;; Package Management
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;; Default Packages
(defvar gmk-default-packages
  '(
    auctex
    auctex-latekmk
    diminish
    helm
    sml-mode
    zenburn-theme
    ))

(defun gmk-install-default-packages ()
  (interactive)
  (package-refresh-contents)
  (mapc #'(lambda (package)
	    (unless (package-installed-p package)
	      (package-install package)))
	gmk-default-packages))

;; Start-up Options
(setq inhibit-splash-screen t
      initial-scratch-message nil
      )

(toggle-frame-maximized)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(find-file "~/Documents/Todo.org")

(add-hook 'after-init-hook #'global-flycheck-mode)

;; Backups
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))
(setq delete-old-versions -1)
(setq version-control t)
(setq vc-make-backup-files t)
(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-save-list/" t)))

;; Yes and No
(defalias 'yes-or-no-p 'y-or-n-p)

;; Misc
(setq echo-keystrokes 0.1 ; Keystrokes to minibuffer immediately
      visible-bell t) ; Line flashes on error
(show-paren-mode t) ; Parens highligh
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
(require 'diminish) ; for modeline tidiness
(setq visual-line-mode t) ; Proper line-wrappign
(setq-default tab-width 2)
(global-set-key (kbd "RET") 'newline-and-indent)

(setq column-number-mode t)
(global-column-enforce-mode t) ; keep columns under 80 char

;; Themes
(load-theme 'monokai t)

;; Helm
(require 'helm-config)
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)

(require 'helm-descbinds)
(global-set-key (kbd "C-h b") 'helm-descbinds)

(helm-mode 1)

;; Org
(require 'org)
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)

(org-indent-mode)
(setq org-todo-keywords
			'((sequence "TODO" "IN-PROGRESS" "|" "DONE")))
(setq org-log-done 'time)

(setq org-default-notes-file "~/Documents/Todo.org")
(setq org-agenda-span 14)

(setq org-refile-targets '((org-agenda-files . (:maxlevel . 3))))
(setq org-file-apps
			'((auto-mode . emacs)
				("\\.mm\\'" . default)
				("\\.x?html?\\'" . default)
				("\\.pdf\\'" . "qpdfview %s")))

(require 'ob-sml) ; Org-Babel SML


;; AucTex
(setq TeX-parse-self t) ; Enable parse on load
(setq TeX-auto-save t) ; Enable parse on save
(setq-default TeX-master nil)

(setq TeX-PDF-mode t) ; PDF mode

;; Jedi (Python)
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)

;; Clojure
(add-hook 'clojure-mode-hook 'cider-mode)

;; Projectile
(projectile-global-mode)
(require 'helm-projectile)
(helm-projectile-on)

;; Mu4e
; Important setup
(require 'mu4e)

; Setup Maildir and folders
(setq mu4e-maildir "~/Maildir")
(setq mu4e-drafts-folder "/[Gmail].Drafts")
(setq mu4e-sent-folder "/[Gmail].Sent Mail")
(setq mu4e-trash-folder "/[Gmail].Trash")

(setq mu4e-maildir-shortcuts
			'(("/INBOX" . ?z)
				))

(setq mu4e-sent-messages-behavior 'delete)
(setq mu4e-get-mail-command "offlineimap") ; Get mail with offlineimap

(setq
 user-mail-address "gabriel.kroch@gmail.com"
 user-full-name "Gabriel M. Kroch"
 )

; Sending Mail
(require 'smtpmail)
(setq message-send-mail-function 'smtpmail-send-it
			smtpmail-stream-type 'starttls
			smtpmail-default-smtp-server "smtp.gmail.com"
			smtpmail-smtp-server "smtp.gmail.com"
			smtpmail-smtp-service 587)

(setq message-kill-buffer-on-exit t)

; Images
(setq
 mu4e-view-show-images t
 mu4e-view-image-max-width 800)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
	 (quote
		("c7a9a68bd07e38620a5508fef62ec079d274475c8f92d75ed0c33c45fbe306bc" default)))
 '(org-agenda-files (quote ("~/Documents/Todo.org")))
 '(package-selected-packages
	 (quote
		(ob-sml monokai-theme rainbow-delimiters cider flycheck jedi magit helm-projectile projectile column-enforce-mode helm-descbinds zenburn-theme solarized-theme sml-mode helm diminish auctex-latexmk))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
