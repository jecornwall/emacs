(server-start)

;;I don't need native backups; I'm using GIT
(setq make-backup-files nil)

;;Auto save drives me crazy
(setq auto-save-interval '0)

;;Org-Mode
(add-to-list 'load-path "~/lisp/org")
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(global-set-key [f8] 'org-feed-update-all)
(global-set-key (kbd "C-<f11>") 'org-clock-in)

(add-hook 'org-mode-hook 'turn-on-font-lock)  ; Org buffers only

;;Prettyness
(setq org-hide-leading-stars t)
(setq org-odd-levels-only t)

;;Posible TODO states
(setq org-todo-keywords (quote ((sequence "TODO(t)" "STARTED(s)" "|" "DONE(d!/!)")
 (sequence "WAITING(w@/!)" "SOMEDAY(S!)" "|" "CANCELLED(c@/!)"))))

;;Clocking should stay on always
(setq org-clock-persist t)
(org-clock-persistence-insinuate)
;; Yes it's long... but more is better ;)
(setq org-clock-history-length 35)
;; Resume clocking task on clock-in if the clock is open
(setq org-clock-in-resume t)
;; Change task state to STARTED when clocking in
(setq org-clock-in-switch-to-state "STARTED")
;; Save clock data and notes in the LOGBOOK drawer
(setq org-clock-into-drawer t)
;; Sometimes I change tasks I'm clocking quickly - this removes clocked tasks with 0:00 duration
(setq org-clock-out-remove-zero-time-clocks t)
;; Don't clock out when moving task to a done state
(setq org-clock-out-when-done nil)

;; Tagging triggers
(setq org-todo-state-tags-triggers
      (quote (("CANCELLED" ("CANCELLED" . t))
              ("WAITING" ("WAITING" . t) ("NEXT"))
              ("SOMEDAY" ("WAITING" . t))
              (done ("NEXT") ("WAITING"))
              ("TODO" ("WAITING") ("CANCELLED"))
              ("STARTED" ("WAITING") ("NEXT" . t)))))

;;Pick up all .org files in this directory for agenda
(setq org-agenda-files (file-expand-wildcards "~/org/*.org"))

(setq org-use-fast-todo-selection t)

;;Locks down the parent of todo items still in TODO state
(setq org-enforce-todo-dependencies t)

(setq org-feed-alist
      '(("ReQall"
	 "http://www.reqall.com/user/feeds/rss/3b5e4c0dae44c665b26d206bddbdc67e956150b2"
	 "~/org/refile.org" "ReQall Entries")))

;;IDO mode thing
(require 'ido)
(ido-mode t)

; Use IDO for target completion
(setq org-completion-use-ido t)

;;Refiling
; Targets include this file and any file contributing to the agenda - up to 5 levels deep
(setq org-refile-targets (quote ((org-agenda-files :maxlevel . 5) (nil :maxlevel . 5))))

; Targets start with the file name - allows creating level 1 tasks
(setq org-refile-use-outline-path (quote file))

; Targets complete in steps so we start with filename, TAB shows the next level of targets etc
(setq org-outline-path-complete-in-steps t)
;;;  Load Org Remember Stuff
(add-to-list 'load-path "~/lisp/remember")
(require 'remember)

;;  Trying random things to see if I can unbreak remember
(setq org-directory "~/org/")
(setq org-default-notes-file "~/org/refile.org")
(setq remember-annotation-functions '(org-remember-annotation))
(setq remember-handler-functions '(org-remember-handler))
(add-hook 'remember-mode-hook 'org-remember-apply-template)

;; I use C-M-r to start org-remember
(global-set-key (kbd "C-M-r") 'org-remember)

;; I don't use this -- but set it in case I forget to specify a location in a future template
(setq org-remember-default-headline "Tasks")

;; 3 remember templates for TODO tasks, Notes, and Phone calls
(setq org-remember-templates (quote (("todo" ?t "* TODO %?
  %u
  %a" nil bottom nil)
                                     ("note" ?n "* %?                                        :NOTE:
  %u
  %a" nil bottom nil)
                                     ("phone" ?p "* PHONE %:name - %:company -                :PHONE:
  Contact Info: %a
  %u
  :CLOCK-IN:
  %?" nil bottom nil))))

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

  ;;Powershell support
  (autoload 'powershell "powershell" "Run powershell as a shell within emacs." t) 
)


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
