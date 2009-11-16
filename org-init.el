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
              ("STARTED" ("WAITING") ))))

;;Pick up all .org files in this directory for agenda
(setq org-agenda-files (file-expand-wildcards "~/org/*.org"))

(setq org-use-fast-todo-selection t)

;;Locks down the parent of todo items still in TODO state
(setq org-enforce-todo-dependencies t)

(setq org-feed-alist
      '(("ReQall"
	 "http://www.reqall.com/user/feeds/rss/3b5e4c0dae44c665b26d206bddbdc67e956150b2"
	 "~/org/refile.org" "ReQall Entries")))

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

;Custom Agenda things
(setq org-agenda-custom-commands 
      '(("c" "Work Tasks" tags-todo "+@Work")
      ))

; Set default column view headings: Task Effort Clock_Summary
(setq org-columns-default-format "%80ITEM(Task) %10TODO(To Do) %7Effort(Effort){:} %8CLOCKSUM")

; global Effort estimate values
(setq org-global-properties (quote (("Effort_ALL" . "0:00 0:10 0:30 1:00 2:00 3:45 6:00 7:30 11:15 15:00 18:45 22:30"))))