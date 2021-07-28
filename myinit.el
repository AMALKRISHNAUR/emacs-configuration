(setq inhibit-startup-message t)
(tool-bar-mode -1)
(fset 'yes-or-no-p 'y-or-n-p)
(global-set-key (kbd "<f5>") 'revert-buffer)

(use-package try
:ensure t)

(use-package which-key
:ensure t
:config
(which-key-mode))

;  (use-package org 
     ; :ensure t
      ;:pin org)
      (use-package org-bullets
      :ensure t
      :config
      (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))


    (global-set-key (kbd "C-c c")
		    'org-capture)


    (setq org-capture-templates
    '(("a" "Appointment" entry (file+healine  "~/Dropbox/orgfiles/gcal.org" "Appointments")
    "* TODO %?\n:PROPERTIES:\n\n:END:\nDEADLINE: %^T \n %i\n")
    ("n" "Note" entry (file+headline "~/Dropbox/orgfiles/notes.org" "Notes")
    "* Note %?\n%T")
    ("l" "Link" entry (file+headline "~/Dropbox/orgfiles/links.org" "Links")
    "* %? %^L %^g \n%T" :prepend t)
    ("b" "Blog idea" entry (file+headline "~/Dropbox/orgfiles/i.org" "Blog Topics:")
    "* %?\n%T" :prepend t)
    ("t" "To Do Item" entry (file+headline "~/Dropbox/orgfiles/i.org" "To Do Items")
    "* %?\n%T" :prepend t)
    ("j" "Journal" entry (file+datetree "~/Dropbox/orgfiles/journal.org")
    "* %?\nEntered on %U\n  %i\n  %a")
    ("s" "Screencast" entry (file "~/Dropbox/orgfiles/screencastnotes.org")
     "* %?\n%i\n")))

(defadvice org-capture-finalize
(after delete-capture-frame activate)
"Advise capture-finalize to close the frame"
(if (equal "capture" (frame-parameter nil 'name))
(delete-frame)))

(defadvice org-capture-destroy
(after delete-capture-frame activate)
"Advise capture-destroy to close the frame"
(if (equal "capture" (frame-parameter nil 'name))
(delete-frame)))

(use-package noflet
:ensure t )
(defun make-capture-frame ()
"Create a new frame and run org-capture."
(interactive)
(make-frame '((name . "capture")))
(select-frame-by-name "capture")
(delete-other-windows)
(noflet ((switch-to-buffer-other-window (buf) (switch-to-buffer buf)))
(org-capture)))

;idomode
;(setq ido-enable-flex-matching t)
;(setq ido-everywhere t)
;(ido-mode 1)

;make ibuffer defult
(defalias 'list-buffers 'ibuffer) ; make ibuffer default
;ibuffer in other window
;(defalias 'list-buffers 'ibuffer-other-window) ; make ibuffer default
;(winner-mode 1);pass through previous window ccleftright

;widmod u can shift between windows by shift and arrow key
;(windmove-default-keybindings)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(setq ibuffer-saved-filter-groups
(quote (("default"
("dired" (mode . dired-mode))
("org" (name . "^.*org$"))

("web" (or (mode . web-mode) (mode . js2-mode)))
("shell" (or (mode . eshell-mode) (mode . shell-mode)))
("mu4e" (name . "\*mu4e\*"))
("programming" (or
(mode . python-mode)
(mode . c++-mode)))
("emacs" (or
(name . "^\\*scratch\\*$")
(name . "^\\*Messages\\*$")))
))))
(add-hook 'ibuffer-mode-hook
(lambda ()
(ibuffer-auto-mode 1)
(ibuffer-switch-to-saved-filter-groups "default")))

;; don't show these
;(add-to-list 'ibuffer-never-show-predicates "zowie")
;; Don't show filter groups if there are no buffers in that group
(setq ibuffer-show-empty-filter-groups nil)

;; Don't ask for confirmation to delete marked buffers
(setq ibuffer-expert t)

(use-package ace-window
:ensure t
:init
(progn
(global-set-key [remap other-window] 'ace-window)
(custom-set-faces
'(aw-leading-char-face
((t (:inherit ace-jump-face-foreground :height 3.0)))))
))

(use-package counsel
  :ensure t
  :bind
  (("M-y" . counsel-yank-pop)
   :map ivy-minibuffer-map
   ("M-y" . ivy-next-line)))


(use-package swiper
:ensure try
:config
(progn
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "<f6>") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "<f1> l") 'counsel-load-library)
(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
(global-set-key (kbd "<f2> u") 'counsel-unicode-char)
(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c j") 'counsel-git-grep)
(global-set-key (kbd "C-c k") 'counsel-ag)
(global-set-key (kbd "C-x l") 'counsel-locate)
(global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
(define-key read-expression-map (kbd "C-r") 'counsel-expression-history)
))

(use-package avy
:ensure t
:bind ("M-s" . avy-goto-char))

;defult mode
;(use-package avy
;:ensure t
;:config
;(avy-setup-default))

;auto complete
(use-package auto-complete
:ensure t
:init
(progn
(ac-config-default)
(global-auto-complete-mode t)
))

(use-package color-theme
  :ensure t
  )
  
  (use-package zenburn-theme
  :ensure t
  :config (load-theme 'zenburn t))
  (load-theme 'leuven t)
(use-package moe-theme
:ensure t)
(moe-light)

(use-package ox-reveal
:ensure ox-reveal)

(setq org-reveal-root "https://cdn.jsdelivr.net/npm/reveal.js")
(setq org-reveal-mathjax t)

(use-package htmlize
:ensure t)

(use-package flycheck
  :ensure t
  :init
  (global-flycheck-mode t))

(use-package jedi
  :ensure t
  :init
  (add-hook 'python-mode-hook 'jedi:setup)
  (add-hook 'python-mode-hook 'jedi:ac-setup))
 (use-package virtualenvwrapper
  :ensure t
  :config
  (venv-initialize-interactive-shells)
  (venv-initialize-eshell))

(use-package elpy
  :ensure t
  :init
  (elpy-enable))

(use-package yasnippet
  :ensure t
  :init
  (progn
    (yas-global-mode 1)))

(use-package undo-tree
:ensure t
:init
(global-undo-tree-mode))

(global-hl-line-mode t)
(use-package  beacon
  :ensure t
  :config
  (beacon-mode 1)
  ;(setq beacon-color "#666600")
  )
(use-package hungry-delete
  :ensure t
  :config
  (global-hungry-delete-mode))

(use-package expand-region
:ensure t
:config
(global-set-key (kbd "C-=") 'er/expand-region))
(setq save-interprogram-paste-before-kill t)
 (global-auto-revert-mode 1)
(setq auto-revert-verbose nil)
(global-set-key (kbd "<f5>") 'revert-buffer)

(use-package iedit
      :ensure t
      )
  ; if you're windened, narrow to the region, if you're narrowed, widen
  ; bound to C-x n
  (defun narrow-or-widen-dwim (p)
  "If the buffer is narrowed, it widens. Otherwise, it narrows intelligently.
  Intelligently means: region, org-src-block, org-subtree, or defun,
  whichever applies first.
  Narrowing to org-src-block actually calls `org-edit-src-code'.

  With prefix P, don't widen, just narrow even if buffer is already
  narrowed."
  (interactive "P")
  (declare (interactive-only))
  (cond ((and (buffer-narrowed-p) (not p)) (widen))
  ((region-active-p)
  (narrow-to-region (region-beginning) (region-end)))
  ((derived-mode-p 'org-mode)
  ;; `org-edit-src-code' is not a real narrowing command.
  ;; Remove this first conditional if you don't want it.
  (cond ((ignore-errors (org-edit-src-code))
  (delete-other-windows))
  ((org-at-block-p)
  (org-narrow-to-block))
  (t (org-narrow-to-subtree))))
  (t (narrow-to-defun))))

  ;; (define-key endless/toggle-map "n" #'narrow-or-widen-dwim)
  ;; This line actually replaces Emacs' entire narrowing keymap, that's
  ;; how much I like this command. Only copy it if that's what you want.
  (define-key ctl-x-map "n" #'narrow-or-widen-dwim)

(defun lhenoad-if-exists (f)
  ""
  (if (file-readable-p f)
      (load-file f)))

(use-package web-mode
:ensure t
:config
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(setq web-mode-engines-alist
'(("django"    . "\\.html\\'")))
(setq web-mode-ac-sources-alist
'(("css" . (ac-source-css-property))
("html" . (ac-source-words-in-buffer ac-source-abbrev))))

(setq web-mode-enable-auto-closing t)
 (setq web-mode-enable-auto-quoting t)) ; this fixes the quote problem I mentionde

(setq user-full-name "Amalkrishnaur"
      user-mail-address "amalkrishnaur100@gmail.com")

(global-set-key (kbd "\e\ei")
		(lambda () (interactive) (find-file "~/Dropbox/orgfiles/i.org")))
(global-set-key (kbd "\e\el")
		(lambda () (interactive) (find-file "~/Dropbox/orgfiles/links.org")))
(global-set-key (kbd "\e\ec")
		(lambda () (interactive) (find-file "~/.emacs.d/myinit.org")))

    ;;--------------------------------------------------------------------------
    ;; latex
    (use-package tex
    :ensure auctex)

    (defun tex-view ()
	(interactive)
	(tex-send-command "evince" (tex-append tex-print-file ".pdf")))
  ;; babel stuff

    (org-babel-do-load-languages
     'org-babel-load-languages
     '((python . t)
       (emacs-lisp . t)
(shell . t)
       (C . t)
    (js . t)
       (ditaa . t)
       (dot . t)
       (org . t)
    (latex . t )
       ))
  ;; projectile
    (use-package projectile
      :ensure t
      :bind ("C-c p" . projectile-command-map)
      :config
      (projectile-global-mode)
    (setq projectile-completion-system 'ivy))

    ;; (use-package counsel-projectile
    ;;   :ensure t
    ;;   :config
    ;;   (counsel-projectile-on)q)

(use-package smartparens
:ensure t
  :hook (prog-mode . smartparens-mode)
  :custom
  (sp-escape-quotes-after-insert nil)
  :config
  (require 'smartparens-config))

(show-paren-mode t)
    ;;--------------------------------------------




    ;; font scaling
    (use-package default-text-scale
      :ensure t
     :config
      (global-set-key (kbd "C-M-=") 'default-text-scale-increase)
      (global-set-key (kbd "C-M--") 'default-text-scale-decrease))


    ;; (use-package frame-cmds :ensure t)
    ;; (load-file "/home/zamansky/Dropbox/shared/zoom-frm.el")
    ;; (define-key ctl-x-map [(control ?+)] 'zoom-in/out)
    ;; (define-key ctl-x-map [(control ?-)] 'zoom-in/out)
    ;; (define-key ctl-x-map [(control ?=)] 'zoom-in/out)
    (define-key ctl-x-map [(control ?0)] 'zoom-in/out)

(setq package-check-signature nil)


(use-package org-gcal
:ensure t
:config
(setq org-gcal-client-id "376897957639-a8kbfhipqb9f52ut0flh7tocldcmo1l0.apps.googleusercontent.com"
org-gcal-client-secret "n4iAcGXyJxVvaCuvs9Gy4u8u"
org-gcal-file-alist '(("amalkrishnaur100@gmail.com" .  "~/Dropbox/orgfiles/gcal.org"))))
(add-hook 'org-agenda-mode-hook (lambda () (org-gcal-sync) ))
(add-hook 'org-capture-after-finalize-hook (lambda () (org-gcal-sync) ))


(setq org-agenda-files (list "~/Dropbox/orgfiles/gcal.org"
"~/Dropbox/orgfiles/i.org"
"~/Dropbox/orgfiles/schedule.org"))


(setq org-capture-templates
'(("a" "Appointment" entry (file  "~/Dropbox/orgfiles/gcal.org" )
"* %?\n\n%^T\n\n:PROPERTIES:\n\n:END:\n\n")
("l" "Link" entry (file+headline "~/Dropbox/orgfiles/links.org" "Links")
"* %? %^L %^g \n%T" :prepend t)
("b" "Blog idea" entry (file+headline "~/Dropbox/orgfiles/i.org" "Blog Topics:")
"* %?\n%T" :prepend t)
("t" "To Do Item" entry (file+headline "~/Dropbox/orgfiles/i.org" "To Do")
"* TODO %?\n%u" :prepend t)
("n" "Note" entry (file+headline "~/Dropbox/orgfiles/i.org" "Note space")
"* %?\n%u" :prepend t)
("j" "Journal" entry (file+datetree "~/Dropbox/journal.org")
"* %?\nEntered on %U\n  %i\n  %a")
("s" "Screencast" entry (file "~/Dropbox/orgfiles/screencastnotes.org")
 "* %?\n%i\n")))


(setq org-agenda-custom-commands
'(("c" "Simple agenda view"
((agenda "")
 (alltodo "")))))

(use-package calfw
:ensure ;TODO:
:config
(require 'calfw)
(require 'calfw-org)
(setq cfw:org-overwrite-default-keybinding t)
(require 'calfw-ical)

(defun mycalendar ()
(interactive)
(cfw:open-calendar-buffer
:contents-sources
(list
;; (cfw:org-create-source "Green")  ; orgmode source
(cfw:ical-create-source "gcal" "https://somecalnedaraddress" "IndianRed") ; devorah calender
(cfw:ical-create-source "gcal" "https://anothercalendaraddress" "IndianRed") ; google calendar ICS
)))
(setq cfw:org-overwrite-default-keybinding t))

(use-package calfw-gcal
:ensure t
:config
(require 'calfw-gcal))

(use-package better-shell
:ensure t
:bind (("C-'" . better-shell-shell)
("C-;" . better-shell-remote-open)))

(setq elfeed-db-directory "~/Dropbox/shared/elfeeddb")


(defun elfeed-mark-all-as-read ()
(interactive)
(mark-whole-buffer)
(elfeed-search-untag-all-unread))


;;functions to support syncing .elfeed between machines
;;makes sure elfeed reads index from disk before launching
(defun bjm/elfeed-load-db-and-open ()
"Wrapper to load the elfeed db from disk before opening"
(interactive)
(elfeed-db-load)
(elfeed)
(elfeed-search-update--force))

;;write to disk when quiting
(defun bjm/elfeed-save-db-and-bury ()
"Wrapper to save the elfeed db to disk before burying buffer"
(interactive)
(elfeed-db-save)
(quit-window))



(defalias 'elfeed-toggle-star
(elfeed-expose #'elfeed-search-toggle-all 'star))

(use-package elfeed
:ensure t
:bind (:map elfeed-search-mode-map
("q" . bjm/elfeed-save-db-and-bury)
("Q" . bjm/elfeed-save-db-and-bury)
("m" . elfeed-toggle-star)
("M" . elfeed-toggle-star)
)
)

(use-package elfeed-goodies
:ensure t
:config
(elfeed-goodies/setup))


(use-package elfeed-org
:ensure t
:config
(elfeed-org)
(setq rmh-elfeed-org-files (list "~/Dropbox/shared/elfeed.org")))

(use-package hydra 
    :ensure hydra
    :init 
    (global-set-key
    (kbd "C-x t")
	    (defhydra toggle (:color blue)
	      "toggle"
	      ("a" abbrev-mode "abbrev")
	      ("s" flyspell-mode "flyspell")
	      ("d" toggle-debug-on-error "debug")
	      ("c" fci-mode "fCi")
	      ("f" auto-fill-mode "fill")
	      ("t" toggle-truncate-lines "truncate")
	      ("w" whitespace-mode "whitespace")
	      ("q" nil "cancel")))
    (global-set-key
     (kbd "C-x j")
     (defhydra gotoline 
       ( :pre (linum-mode 1)
	      :post (linum-mode -1))
       "goto"
       ("t" (lambda () (interactive)(move-to-window-line-top-bottom 0)) "top")
       ("b" (lambda () (interactive)(move-to-window-line-top-bottom -1)) "bottom")
       ("m" (lambda () (interactive)(move-to-window-line-top-bottom)) "middle")
       ("e" (lambda () (interactive)(end-of-buffer)) "end")
       ("c" recenter-top-bottom "recenter")
       ("n" next-line "down")
       ("p" (lambda () (interactive) (forward-line -1))  "up")
       ("g" goto-line "goto-line")
       ))
    (global-set-key
     (kbd "C-c t")
     (defhydra hydra-global-org (:color blue)
       "Org"
       ("t" org-timer-start "Start Timer")
       ("s" org-timer-stop "Stop Timer")
       ("r" org-timer-set-timer "Set Timer") ; This one requires you be in an orgmode doc, as it sets the timer for the header
       ("p" org-timer "Print Timer") ; output timer value to buffer
       ("w" (org-clock-in '(4)) "Clock-In") ; used with (org-clock-persistence-insinuate) (setq org-clock-persist t)
       ("o" org-clock-out "Clock-Out") ; you might also want (setq org-log-note-clock-out t)
       ("j" org-clock-goto "Clock Goto") ; global visit the clocked task
       ("c" org-capture "Capture") ; Don't forget to define the captures you want http://orgmode.org/manual/Capture.html
	     ("l" (or )rg-capture-goto-last-stored "Last Capture"))

     ))

(defhydra hydra-multiple-cursors (:hint nil)
  "
 Up^^             Down^^           Miscellaneous           % 2(mc/num-cursors) cursor%s(if (> (mc/num-cursors) 1) \"s\" \"\")
------------------------------------------------------------------
 [_p_]   Next     [_n_]   Next     [_l_] Edit lines  [_0_] Insert numbers
 [_P_]   Skip     [_N_]   Skip     [_a_] Mark all    [_A_] Insert letters
 [_M-p_] Unmark   [_M-n_] Unmark   [_s_] Search
 [Click] Cursor at point       [_q_] Quit"
  ("l" mc/edit-lines :exit t)
  ("a" mc/mark-all-like-this :exit t)
  ("n" mc/mark-next-like-this)
  ("N" mc/skip-to-next-like-this)
  ("M-n" mc/unmark-next-like-this)
  ("p" mc/mark-previous-like-this)
  ("P" mc/skip-to-previous-like-this)
  ("M-p" mc/unmark-previous-like-this)
  ("s" mc/mark-all-in-region-regexp :exit t)
  ("0" mc/insert-numbers :exit t)
  ("A" mc/insert-letters :exit t)
  ("<mouse-1>" mc/add-cursor-on-click)
  ;; Help with click recognition in this hydra
  ("<down-mouse-1>" ignore)
  ("<drag-mouse-1>" ignore)
  ("q" nil)


  ("<mouse-1>" mc/add-cursor-on-click)
  ("<down-mouse-1>" ignore)
  ("<drag-mouse-1>" ignore))

;; tags for code navigation
(use-package ggtags
:ensure t
:config
(add-hook 'c-mode-common-hook
(lambda ()
(when (derived-mode-p 'c-mode 'c++-mode 'java-mode)
(ggtags-mode 1))))
)

(use-package dumb-jump
  :bind (("M-g o" . dumb-jump-go-other-window)
	 ("M-g j" . dumb-jump-go)
	 ("M-g x" . dumb-jump-go-prefer-external)
	 ("M-g z" . dumb-jump-go-prefer-external-other-window))
  :config 
  ;; (setq dumb-jump-selector 'ivy) ;; (setq dumb-jump-selector 'helm)
:init
(dumb-jump-mode)
  :ensure
)

(use-package emmet-mode
:ensure t
:config
(add-hook 'sgml-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
(add-hook 'web-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
(add-hook 'css-mode-hook  'emmet-mode) ;; enable Emmet's css abbreviation.
)

(use-package aggressive-indent
:ensure t
:config
(global-aggressive-indent-mode 1)
;;(add-to-list 'aggressive-indent-excluded-modes 'html-mode)
)


(defun z/swap-windows ()
""
(interactive)
(ace-swap-window)
(aw-flip-window)
)

(use-package treemacs
    :ensure t
    :defer t
    :config
    (progn

      (setq treemacs-follow-after-init          t
	    treemacs-width                      35
	    treemacs-indentation                2
	    treemacs-git-integration            t
	    treemacs-collapse-dirs              3
	    treemacs-silent-refresh             nil
	    treemacs-change-root-without-asking nil
	    treemacs-sorting                    'alphabetic-desc
	    treemacs-show-hidden-files          t
	    treemacs-never-persist              nil
	    treemacs-is-never-other-window      nil
	    treemacs-goto-tag-strategy          'refetch-index)

      (treemacs-follow-mode t)
      (treemacs-filewatch-mode t))
    :bind
    (:map global-map
	  ([f8]        . treemacs-toggle)
	  ([f9]        . treemacs-projectile-toggle)
	  ("<C-M-tab>" . treemacs-toggle)
	  ("M-0"       . treemacs-select-window)
	  ("C-c 1"     . treemacs-delete-other-windows)
	))
  (use-package treemacs-projectile
    :defer t
    :ensure t
    :config
    (setq treemacs-header-function #'treemacs-projectile-create-header)
)

; wiki melpa problem
					;(use-package dired+
					 ; :ensure t
					 ; :config (require 'dired+)
					 ; )

(setq dired-dwim-target t)

(use-package dired-narrow
  :ensure t
  :config
  (bind-key "C-c C-n" #'dired-narrow)
  (bind-key "C-c C-f" #'dired-narrow-fuzzy)
  (bind-key "C-x C-N" #'dired-narrow-regexp)
  )

(use-package dired-subtree :ensure t
  :after dired
  :config
  (bind-key "<tab>" #'dired-subtree-toggle dired-mode-map)
  (bind-key "<backtab>" #'dired-subtree-cycle dired-mode-map))
