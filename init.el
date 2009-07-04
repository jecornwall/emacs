;;Org-Mode
(add-to-list 'load-path "~/lisp/org")
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

(add-hook 'org-mode-hook 'turn-on-font-lock)  ; Org buffers only

(setq org-hide-leading-stars t)
(setq org-odd-levels-only t)

(setq org-todo-keywords (quote ((sequence "TODO(t)" "STARTED(s)" "|" "DONE(d!/!)")
 (sequence "WAITING(w@/!)" "|" "CANCELLED(c@/!)"))))

(setq org-agenda-files (file-expand-wildcards "~/org/*.org"))

(setq org-use-fast-todo-selection t)

;;;  Load Org Remember Stuff
(add-to-list 'load-path "~/lisp/remember")
(org-remember-insinuate)

;; I use C-M-r to start org-remember
(global-set-key (kbd "C-M-r") 'org-remember)

;; C-c C-c stores the note immediately
(setq org-remember-store-without-prompt t)

;; I don't use this -- but set it in case I forget to specify a location in a future template
(setq org-remember-default-headline "Tasks")

;; 3 remember templates for TODO tasks, Notes, and Phone calls
(setq org-remember-templates (quote (("todo" ?t "* TODO %?
  %u
  %a" "~/org/tasks.org" bottom nil)
                                     ("note" ?n "* %?                                        :NOTE:
  %u
  %a" nil bottom nil)
                                     ("phone" ?p "* PHONE %:name - %:company -                :PHONE:
  Contact Info: %a
  %u
  :CLOCK-IN:
  %?" "~/org/phone.org" bottom nil))))

;;Word wrap toggling
(global-set-key [f9] 'toggle-truncate-lines)

;;Remove mess from the top of the screen
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

;;Meta-x without the meta key
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)

;;More options for killing
(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)

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

;;Stuff for windows (only)
(when (eq system-type 'windows-nt)
  ;;Printing via Ghost Script
  (setenv "GS_LIB" "C:\\Program Files\\GS\\gs8.64\\lib;C:\\Program Files\\GS\\gs8.64\\fonts")
  (setq ps-lpr-command "C:\\Program Files\\gs\\gs8.64\\bin\\gswin32c.exe")
  (setq ps-lpr-switches '("-q" "-dNOPAUSE" "-dBATCH" "-sDEVICE=mswinpr2"))
  (setq ps-printer-name t)
	
  ;;Spelling program
  (if (file-accessible-directory-p "C:\\Program Files\\Aspell\\bin\\") 
      (setq-default ispell-program-name "C:\\Program Files\\Aspell\\bin\\aspell.exe")
    (setq-default ispell-program-name "C:\\Program Files (x86)\\Aspell\\bin\\aspell.exe")
    )

  (defvar *w32-window-state* 'restored)

  ;;Maximise frame
  (defun w32-maximize-frame ()
    "Maximize the current frame"
    (interactive)
    (w32-send-sys-command 61488)
    (setq *w32-window-state* 'maximised))

  ;;Restore the current frame
  (defun w32-restore-frame ()
    "Restore the current frame"
    (interactive)
    (w32-send-sys-command 61728)
    (setq *w32-window-state* 'restored))
 
  (defun w32-cycle-state ()
    (interactive)
    (if (eq *w32-window-state* 'restored)
	(w32-maximize-frame)
      (w32-restore-frame)))

  (global-set-key [f11] 'w32-cycle-state)
)


