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
 '(package-selected-packages '(auctex)))
 

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(add-to-list 'default-frame-alist '(font . "Courier New 18"))
(set-face-attribute 'default t :font "Courier New 18") ;; setting default font and font size
(add-to-list 'default-frame-alist '(fullscreen . maximized)) ;; to open in maximized window
(tool-bar-mode -1) ;; gets rid of tool bar. The one with icons for new, copy, paste, etc
(toggle-scroll-bar -1) ;; gets rid of scroll bar, only usefull with a mouse, and mouse scroll still works without it
;;(menu-bar-mode -1) ;; I like the menu bar, it is not large and there's a lot there that I have no idea that exists. But this code is here if I wanna take it of. I can also run any of those with M-:

;; org settings

(setq org-agenda-files '("c:/Users/rdpor/Dropbox/org/projects.org"))

(setq org-agenda-span 1)
;; (setq org-agenda-custom-commands
;;       '(("@" . "HOME + first letter for context") ; describe prefix "@"
;;         ("@e" tags "@errands")
;;         ("@h" tags "@home")
;;         ("@p" tags "@pc")))
;; adding choice of searching specific tags in agenda
;; commented out, because the 'm' agenda option solves this for me
;; I'll leave it here for a bit, in case the code would still be useful for other stuff

(setq org-agenda-dim-blocked-tasks 'invisible)
;; removing from agenda projects that are blocked (by subtodos or something)
;; set to t if want to dim instead of disappear

(setq org-todo-keywords '((sequence "TODO(t!)" "WAITING(w@)" "CANCELLED(c@)" "DONE(d!)")))
;; setting todo to have waiting and cancelled options
;; (setq org-log-done t)
;; To log done todos
;; commented out because it is redundant with code above. The '!' logs automatically

(setq org-stuck-projects '("+LEVEL=1/-DONE-CANCELLED" ("TODO" "WAITING" "") nil ""))

(setq org-priority-faces '((?A . (:foreground "red" :weight 'bold))
                           (?B . (:foreground "yellow"))
                           (?C . (:foreground "green"))))
;; gives different colors for each priority

(setq org-default-notes-file "c:/Users/rdpor/Dropbox/org/projects.org")

(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-cc" 'org-capture)

(setq org-capture-templates
   '(("i" "Inbox: to be processed" entry
      (file "")
      "* captured on %u \n %?")))
;; template for inbox
;; will drop  in default-notes-file ("")
;; * and text to make it a heading
;; %u for timestamp that doesn't go to agenda
;; \n newline and %? for more input

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

(put 'narrow-to-region 'disabled nil) ;; option to narrow to region C-x n n
;; it is disabled by default

(setq org-agenda-show-all-dates nil)
;; in the agend show only dates that have things schedule


;; Visual changes + start up

(global-visual-line-mode 1)
 ;; This allows for a soft line break that does not break words in the middle
;; 1 for on, 0 for off.

(add-hook 'prog-mode-hook 'display-line-numbers-mode) ;; automatically show line numbers in all programming modes.

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

(defun prev-window ()
  (interactive)
  (other-window -1)) ;; function to go to previouse window
(global-set-key (kbd "C-,") #'prev-window) ;; set keybind to go to previous window
(global-set-key (kbd "C-.") #'other-window) ;; change other-window keybind to make it easier and more logic


(defun jump-to-same-spot-in-other-buffer () 
  "Go to the same location in the other buffer. Useful for when you have cloned indirect buffers"
  (interactive)
  (let ((my/goto-current-point (point)))
       (other-window 1)
       (goto-char my/goto-current-point)
       (when (invisible-p (point))
        (org-reveal)))
)

(global-set-key (kbd "C-x j") 'jump-to-same-spot-in-other-buffer)
;; function to go from index on one side to content in the other

(defun org-narrow-to-subtree-in-cloned-window (newname display-flag &optional norecord)
  "Open a clone in a new window and narrow to subtree"
  (interactive
   (progn
     (if (get major-mode 'no-clone-indirect)
	 (error "Cannot indirectly clone a buffer in %s mode" mode-name))
     (list (if current-prefix-arg
	       (read-buffer "Name of indirect buffer: " (current-buffer)))
	   t)))
  (let ((pop-up-windows t))
    (clone-indirect-buffer-other-window newname display-flag norecord))
  ;;; the above I copied from clone-indirect-buffer-other-window, which had the same code, but ended calling (clone-indirect-buffer), which is based on
  (prev-window)
  (jump-to-same-spot-in-other-buffer)
  (org-narrow-to-subtree)
  )
(global-set-key (kbd "C-x n c") 'org-narrow-to-subtree-in-cloned-window)

(setq org-startup-indented t) ;; so all files will have indented hierarchical headlines
;;(setq org-indent-mode-turns-on-hiding-stars nil) ;; if I want to show all stars in headings

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

(set-register ?m '(file . "c:/Users/rdpor/Dropbox/phd/main.org"))
;; latex stuff below from this guide https://www.latexbuch.de/files/latexsystem-en.pdf
;;(server-start) need to read more about this and see if it's needed.
(add-hook 'LaTeX-mode-hook 'turn-on-reftex);; so it activates reftex automatically in AUCTex LaTeX mode
(add-hook 'latex-mode-hook 'turn-on-reftex) ;; so it activates reftex automatically in Emacs latex mode
(setq reftex-plug-into-AUCTeX t) ;; integrates RefTeX with AUCTeX
;; (setq-default ispell-program-name "aspell") ;; aspell for windows no longer maintained
;; havent' installed it. Other options for windows not looking great, need to ask other people.
