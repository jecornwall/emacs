(require 'server)
(when (and (= emacs-major-version 23) (equal window-system 'w32))
  (defun server-ensure-safe-dir (dir) "Noop" t)) ; Suppress error "directory
                                                 ; ~/.emacs.d/server is unsafe"
                                                 ; on windows.
(server-start)

;;I don't need native backups; I'm using GIT
(setq make-backup-files nil)

;;Visual line mode means word wrapping isn't ugly
(global-visual-line-mode 1)

;Haskell
(load "~/.emacs.d/haskell-mode/haskell-site-file")
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)

;;Auto save drives me crazy
(setq auto-save-interval '0)

;Orgmode
(load "~/.emacs.d/org-init.el")

;IDO
(require 'ido)
(ido-mode t)
(setq ido-rescan t)

; Use IDO for target completion
(setq org-completion-use-ido t)

;;Word wrap toggling
(global-set-key [f9] 'toggle-truncate-lines)

;;Remove mess from the top of the screen
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

;;Meta-x without the meta key
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)

;;More options for killing
(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)

;; Keys for regexing
(global-set-key "\M-r" 'isearch-backward-regexp)
(global-set-key "\M-s" 'isearch-forward-regexp)
(defalias 'qrr 'query-replace-regexp)

;;Keyboard macro awesome key
(global-set-key [f5] 'call-last-kbd-macro)

;; recentf stuff, for recently accessed files
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)
(global-set-key "\C-c\ \C-r" 'recentf-open-files)

;;Remove stupid splash screen
(setq inhibit-splash-screen t)

;;Switching colours to ones that cause less occular discomfort
(defvar *color-mode* 'light
  "Color mode for ``switch-colors''. Can be 'light or 'dark.")

(defun lights ()
    (set-background-color "white")
    (set-foreground-color "black")
    (set-cursor-color "black")
    (setq *color-mode* 'light)
    (message "Lights on"))

(defun night ()
    (set-background-color "black")
    (set-foreground-color "wheat")
    (set-cursor-color "wheat")
    (setq *color-mode* 'night)
    (message "Lights off"))

(defun switch-colors ()
  "Switches between light and dark color modes. Useful if your
eyes are weary."
  (interactive)
  (if (eq *color-mode* 'light)
      (night)
    (lights)))

(global-set-key [f12] 'switch-colors)

;;f7 is made for spell checking, and that's just what it'll do
(global-set-key [f7] 'ispell)
(setq ispell-dictionary "british")

;;Font setting
 (set-default-font
     "-outline-Consolas-normal-r-normal-normal-14-97-96-96-c-*-iso8859-1")

;;ediff should split horizontally when the windows get to a certain size
(setq ediff-split-window-function (lambda (&optional arg)
				    (if (> (frame-width) 150)
					(split-window-horizontally arg)
				      (split-window-vertically arg))))

;;Stuff for windows (only)
(when (eq system-type 'windows-nt)
  ;;Spelling program
  (if (file-accessible-directory-p "C:\\Program Files\\Aspell\\bin\\") 
      (setq-default ispell-program-name "C:\\Program Files\\Aspell\\bin\\aspell.exe")
    (setq-default ispell-program-name "C:\\Program Files (x86)\\Aspell\\bin\\aspell.exe")
    )

  (defvar *w32-window-state* 'restored)

  ;;Powershell support
  (load "~/.emacs.d/powershell.el")
  (autoload 'powershell "powershell" "Run powershell as a shell within emacs." t) 
)

; Install mode-compile to give friendlier compiling support!
(autoload 'mode-compile "~/.emacs.d/mode-compile.el"
   "Command to compile current buffer file based on the major mode" t)
(global-set-key "\C-c\C-c" 'mode-compile)
(autoload 'mode-compile-kill "mode-compile"
 "Command to kill a compilation launched by `mode-compile'" t)
(global-set-key "\C-c\C-k" 'mode-compile-kil)

;; ri binding
(setq ri-ruby-script "~/.emacs.d/ri-emacs.rb")
(autoload 'ri "~/.emacs.d/ri-ruby.el" nil t)

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(initial-scratch-message nil))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )
