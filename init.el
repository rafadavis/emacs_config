;; this is to enable packages, it tells where it is gonna look for packages
(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   '("melpa" . "http://melpa.org/packages/")
   t)
  (add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
  (package-initialize))
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.

;; (package-initialize)
;; commented the above out because it is already on the melpa code above


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(wheatgrass))
 '(org-capture-templates
   '(("i" "Inbox: to be processed" entry
      (file+headline "" "inbox")
      "* %u"))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(add-to-list 'default-frame-alist '(font . "Courier New 18"))
(set-face-attribute 'default t :font "Courier New 18") ;; setting default font and font size
(add-to-list 'default-frame-alist '(fullscreen . maximized)) ;; to open in maximized window



;; org settings

(setq org-agenda-files '("c:/Users/rdpor/Dropbox/org/projects.org"))

(setq org-agenda-custom-commands
      '(("@" . "HOME + first letter for context") ; describe prefix "@"
        ("@e" tags "@errands")
        ("@h" tags "@home")
        ("@p" tags "@pc")))
;; adding choice of searching specific tags in agenda

(setq org-agenda-dim-blocked-tasks 'invisible)
;; removing from agenda projects that are blocked (by subtodos or something)
;; set to t if want to dim instead of disappear

(setq org-todo-keywords '((sequence "TODO(t)" "WAITING(w!)" "|" "CANCELLED(c!)" "DONE(d!)")))
;; setting todo to have waiting and cancelled options
;; (setq org-log-done t)
;; To log done todos
;; commented out because it is redundant with code above. The '!' logs automatically

(setq org-stuck-projects '("+LEVEL=1/-DONE-CANCELLED" ("TODO" "WAITING" "") nil ""))

(setq org-default-notes-file "c:/Users/rdpor/Dropbox/org/projects.org")

(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-cc" 'org-capture)


(setq org-log-into-drawer t)
;; so the todo state logs go to a drawer instead of the body of the text

(setq org-enforce-todo-dependencies t)
(setq org-enforce-todo-checkbox-dependencies t)
;; blocks you from making done todo's that have open dependencies
;; it is working with cancelled, but not with done


(setq org-refile-targets '(("c:/Users/rdpor/Dropbox/org/done.org" :maxlevel . 1)
			   ("c:/Users/rdpor/Dropbox/org/references.org" :maxlevel . 1)
			   ("c:/Users/rdpor/Dropbox/org/i.org" :maxlevel . 1)))
;; setting targets for refile. Need to better understand the maxlevel

(setq org-agenda-show-all-dates nil)
;; in the agend show only dates that have things schedule


;; Visual changes + start up

(global-visual-line-mode 1)
 ;; This allows for a soft line break that does not break words in the middle
 ;; 1 for on, 0 for off.

(setq visible-bell 1)
;; removes beep and change it to a light when in the end of file

(setq split-height-threshold nil)
(setq split-width-threshold 0)
;; open new window vertically by default


(setq inhibit-splash-screen t) ;; inhibit starting scree
(setq inhibit-startup-message t) ;; apparently, that forces start in $HOME path
;;(find-file-other-window "c:/Users/rdpor/Dropbox/org/projects.org") ;; I left the projects.org even though I close it later because I want it to be on the buffer list
(org-agenda-list) ;; another option is (org-todo-list)
(delete-other-windows) ;; to close scratch window

(setq default-directory "c:/Users/rdpor/")
;; apparently it is working without the above line
;; not sure why and how (probably because I ask to open the projects.org file first



;;(global-set-key "\C-x2" (lambda () (interactive)(split-window-vertically) (other-window 1)))
;;(global-set-key "\C-x3" (lambda () (interactive)(split-window-horizontally) (other-window 1)))
;; the above will make pointer go to new window automatically. Need to test and see if it works with C-x4 as well to see if I want to implement it. I rarely ever use C-x2 or C-x3

(defun mark-from-point-to-end-of-line ()
  "Marks everything from point to end of line"
  (interactive)
  (set-mark (line-end-position))
  (activate-mark))

(global-set-key (kbd "C-x l") 'mark-from-point-to-end-of-line)
;; creating and binding function that marks from point to end of line



(prefer-coding-system 'utf-8)
;; defining the default encoding system

(put 'upcase-region 'disabled nil)


(defun jump-to-same-spot-in-other-buffer () 
  "Go to the same location in the other buffer. Useful for when you have cloned indirect buffers"
  (interactive)
  (let ((my/goto-current-point (point)))
       (other-window 1)
       (goto-char my/goto-current-point)
       (when (invisible-p (point))
        (org-reveal)))
)
;; function to go from index on one side to content in the other

(global-set-key (kbd "C-x j") 'jump-to-same-spot-in-other-buffer)





;; below: stuff about reading text accessibility, blind vision things
(defun play-audio-input (input-to-say) "Plays input as speech." (shell-command
 (concat "espeak -k5 -s 290 \"" input-to-say "\"")))

(defun speak-my-text () "Speaks text in buffer."
  (interactive)
(if (region-active-p)
  (progn
    (kill-ring-save (region-beginning) (region-end))
      (start-process-shell-command "speakbuffvar" nil
        "bash -c \"killall espeak;xsel --clipboard|espeak -s 290\""))
  (progn
    (kill-ring-save (point-min) (point-max))
      (start-process-shell-command "speakbuffvar" nil
        "bash -c \"killall espeak;xsel --clipboard|espeak -s 290\""))))

(global-set-key (kbd "C-z") 'speak-my-text)


(fset 'read-rest-aloud
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ("\276 " 0 "%d")) arg)))
(global-set-key (kbd "M-z")  'read-rest-aloud)
;; above: all about blind stuff

(setq backup-directory-alist `(("." . "C:/Users/rdpor/emacs_backups/")) ;; setting backup files folder
      backup-by-copying t    ; Don't delink hardlinks                           
      delete-old-versions t  ; Clean up the backups                             
      version-control t      ; Use version numbers on backups,                  
      kept-new-versions 5    ; keep some new versions                           
      kept-old-versions 2    ; and some old ones, too
      version-control t)     ; use versioned backups

(defun no-junk-please-were-unixish ()
  (let ((coding-str (symbol-name buffer-file-coding-system)))
    (when (string-match "-\\(?:dos\\|mac\\)$" coding-str)
      (set-buffer-file-coding-system 'unix))))

(add-hook 'find-file-hooks 'no-junk-please-were-unixish)
;; above is meant to solve the LF vs CRLF bullshit.
;; if it works properly, all files with use the unix format, LF
;; git goes king of nuts because of this
;; check https://stackoverflow.com/questions/1967370/git-replacing-lf-with-crlf
;; also check https://stackoverflow.com/questions/17628305/windows-git-warning-lf-will-be-replaced-by-crlf-is-that-warning-tail-backwar

(set-register ?i '(file . "c:/Users/rdpor/AppData/Roaming/.emacs.d/init.el"))
;; setting register 'i' to my init file
;; to quickly access it, C-x r j i
(set-register ?p '(file . "c:/Users/rdpor/Dropbox/org/projects.org"))
