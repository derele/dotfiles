;; -*- coding: latin-1; -*-
;; Emanuel Heitlinger  

;; main cusomisation file: my .emacs
;; links to this!

;; works only with 256 colors in terminal!!!

;; This file loads customisation common to all my machines
;; at the end I am testign wich machine this is on and 
;; load the machine-dependent init-files

(setq user-mail-address "emanuelheitlinger@gmail.com")
(setq inhibit-startup-message t)
(setq load-path
      (append (list nil 
		    ;;		    "~/.emacs.d"
		    "~/.emacs.d/load-path"
		    "~/.emacs.d/color-theme-6.6.0"
;;		    "~/.emacs.d/emms/lisp"
                    "~/.emacs.d/magit-0.7"
                    ;; lisp is not needed at the moment  "~/.emacs.d/slime-2010-05-31"
                    "/usr/share/emacs/24.3/lisp/progmodes"
                    "/usr/share/emacs/24.3/lisp/vc"
                    "~/.emacs.d/g-client"
                    "~/.emacs.d/ess-12.09/lisp/"
                    "~/dotfiles/dotemacs/own_modes")              
              load-path))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; color stuff ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; no boldness in fonts removes also underlines
(mapc
 (lambda (face)
   (set-face-attribute face nil :weight 'normal :underline nil))
 (face-list))

;; lets play with color
(require 'color-theme)
(color-theme-initialize)
;; (color-theme-tty-dark)
;; (color-theme-jsc-dark)
(color-theme-charcoal-black)

(custom-set-faces
 ;; custom-set-faces was added by custom, one such instance!
 '(font-lock-comment-face ((t (:foreground "color-244"))))
 '(linum ((t (:inherit shadow :background "color-232" :foreground "color-191"))))
 '(mode-line-buffer-id ((t (:bold t :foreground "color-118" :background "color-58"))))
 '(mode-line ((t (:bold t :foreground "color-58" :background "color-107" )))))

;;;;;;;;;;;;;;;;;;;;;; swith off bell completely
(setq ring-bell-function 'ignore)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;; VCS stuff ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'magit)
(setq magit-commit-all-when-nothing-staged 1)
(global-set-key "\C-ci" 'magit-status)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; general functionality ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; start the emacs server
(server-start)

;; map undo to something easy: the newline keys, as I still use enter
;; get redo and bind it to somethin easy as well
(require 'redo)
(global-set-key (kbd "C-j")  'undo)
(global-set-key (kbd "M-j")  'redo)

;; I hate rodents
;; (scroll-bar-mode -1) ;; this is not needed in emacs nox
(menu-bar-mode -1)
(tool-bar-mode -1)

;; I hate tabs!
(setq-default indent-tabs-mode nil)
(setq tab-width 4)

;; faster response in the minibuffer
(setq echo-keystrokes 0.01)

;; Ido mode to end my troubles opening files and switching
;; buffersm
(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t) ;; enable fuzzy matching
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; write y instead of yes
(fset 'yes-or-no-p 'y-or-n-p) 

;; kill whole lines with C-k
(setq kill-whole-line 1)

;; get the column plus line number
(column-number-mode 1)

;; burry quickly
(global-set-key "\C-cbb" 'bury-buffer)

;; save the current settings in the current folder
;;(desktop-save-mode 1)
;; better restore command history and file-list but not the files itself
(require 'session)
(add-hook 'after-init-hook 'session-initialize)

;; auto-complete ## turned off because of R crashes
;; (require 'auto-complete-config)
;; (add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
;; (ac-config-default)

;; word-count 
(require 'word-count)
(setq load-path (cons (expand-file-name "~/elisp") load-path))
(autoload 'word-count-mode "word-count"
           "Minor mode to count words." t nil)
(global-set-key "\M-+" 'word-count-mode)

;; ssh 
(require 'ssh)
(require 'tramp)
(setq tramp-default-method "scp"
      tramp-default-user "dc134")

;; parentheses highlighting
(require 'highlight-parentheses)
(setq hl-paren-colors '("red"  "green" "color-93" "cyan" "color-153" "color-200" "color-154" "color-118"))
(define-globalized-minor-mode
  global-highlight-parentheses-mode
  highlight-parentheses-mode 
  highlight-parentheses-mode)
(global-highlight-parentheses-mode)

;; highlight current line
(require 'highlight-current-line)
(highlight-current-line-on t)
(set-face-background 'highlight-current-line-face "color-232")

;; line-numbers, very sophisticated function to make the numbering right-justified and the column the right size
(require 'linum)
(setq
linum-format (lambda (line) (propertize (format (let ((w (length (number-to-string (count-lines (point-min) (point-max)))))) (concat "%" (number-to-string
w) "d ")) line) 'face 'linum)))
(global-set-key [f1] 'linum-mode)

;; highlight region between point and mark
(transient-mark-mode t)

;; delete backwards with C-h
(keyboard-translate ?\C-h ?\C-?)

;; delete word backwards
(global-set-key "\M-h" 'backward-kill-word)

;; this is perl-inspired Make me work!
;; (global-set-key (kbd "C-c C-#") 'comment-or-uncomment-region)

;;;;;;;;;;;;;;;;;;;;; Org-mode settings;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
;; (global-set-key "\C-cl" 'org-store-link)
;; (global-set-key "\C-ca" 'org-agenda)
;; (global-font-lock-mode 1)

;; ;; org remember
;; (org-remember-insinuate)
;; (setq org-directory "~/org/")
;; (setq org-default-notes-file (concat org-directory "/notes.org"))
;; (define-key global-map "\C-cr" 'org-remember)

;; (setq org-remember-templates
;;       '(("Todo" ?t "* TODO %?\n  %i\n  %a" "~/org/TODO.org" "Tasks")
;;         ("Journal" ?j "* %U %?\n\n  %i\n  %a" "~/org/JOURNAL.org")
;;         ("Idea" ?i "* %^{Title}\n  %i\n  %a" "~/org/JOURNAL.org" "New Ideas")))

;; (define-key org-mode-map "\C-ct" 'org-todo)
;; (add-to-list 'auto-mode-alist '("\\.[Cc][Ss][Vv]\\'" . org-mode))

;; ;; open-csv files as org-table files
;; (defun ele-open-csv-as-org-table ()
;;   "When a .csv file is opened convert it to an org table."
;;   (if (string-match "csv" (file-name-extension (buffer-name)))
;;       (progn
;;         (org-table-convert-region (point-min) (point-max))
;;         (rename-buffer(concat(file-name-sans-extension (buffer-name)) ".org"))
;;         (write-file (buffer-name))
;;         )))
;; (add-hook 'org-mode-hook 'ele-open-csv-as-org-table)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;terminal  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; multi-terminal-mode
;; (require 'multi-term)
;; (setq multi-term-program "/bin/bash")

;; ;; web browser binding  
;; (global-set-key "\C-cc" 'browse-url-or-follow-link)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; window and buffer general;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Easy between windows
(defun select-next-window ()
  "Switch to the next window" 
  (interactive)
  (select-window (next-window)))

(defun select-previous-window ()
  "Switch to the previous window" 
  (interactive)
  (select-window (previous-window)))

(global-set-key "\C-xo" 'select-next-window)
(global-set-key "\C-xO" 'select-previous-window)

(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>") 'shrink-window)
(global-set-key (kbd "S-C-<up>") 'enlarge-window)

;;;;;;;;;;;;;;;;;;;;; perl (-now) stuff;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'template)
(template-initialize)
(require 'perlnow)

;; cperl-mode is preferred to perl-mode                                        
;; "Brevity is the soul of wit" <foo at acm.org>                               
(defalias 'perl-mode 'cperl-mode)


(setq perlnow-script-location
      (substitute-in-file-name "$HOME/own_perl_scripts"))

;;The user-group-all permissions used to make a script executable.
(setq perlnow-executable-setting    72)

;;The template that new perl scripts will be created with.
(setq perlnow-perl-script-template
      (substitute-in-file-name "$HOME/.templates/own-pl.tpl"))

;;The script simple scrpt
(global-set-key "\C-cps" 'perlnow-script)

;;local keys in cperl mode for the perlnow stuff
(add-hook 'cperl-mode-hook
	  (lambda()
	    (define-key cperl-mode-map (kbd "C-c C-v") 'cperl-perldoc)  
	    (define-key cperl-mode-map (kbd "C-c C-c") 'perlnow-run-check)
	    (define-key cperl-mode-map (kbd "C-c C-r") 'perlnow-run)
	    (define-key cperl-mode-map (kbd "C-c C-a") 'perlnow-alt-run)
	    (define-key cperl-mode-map (kbd "C-c M-r") 'perlnow-set-run-string)
	    (define-key cperl-mode-map (kbd "C-c M-a") 'perlnow-set-alt-run-string)
	    )
	  )

(setq cperl-invalid-face nil)    ;; get rid of underlined whitespaces in cperl-mode
(setq cperl-electric-keywords t) ;; expands for keywords such as
                                 ;; foreach,  while,  etc...)

;; (require 'bioperl-mode)
;; (setq bioperl-module-path "/usr/lib/perl5/vendor_perl/5.10.0")


;;;; LaTeX stuff ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; AucTeX with rubber
;; http://www.nabble.com/sweave-and-auctex-td23492805.html

;; make reftex lookup master document
(setq-default TeX-master nil)

;; (eval-after-load "tex"
;;   '(add-to-list 'TeX-command-list
;;                 '("Rubber" "rubber -d %t" TeX-run-command nil t) t)
;;   )

;; ebib 
(autoload 'ebib "ebib" "Ebib, a BibTeX database manager." t)

;; reftex
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)   ; with AUCTeX LaTeX mode
(setq reftex-plug-into-AUCTeX t
      reftex-enable-partial-scans t)

;; enable it on Rnw files
(setq reftex-file-extensions
      '((".Rnw" "Rnw" "nw" "tex" ".tex" ".ltx") ("bib" ".bib")))
(setq TeX-file-extensions
      '(".Rnw" "Rnw" "nw" "tex" "sty" "cls" "ltx" "texi" "texinfo"))

;; set my bibtex-path
(setq reftex-bibpath-environment-variables
      '("/home/ele/bibtex/"))

(setq reftex-default-bibliography
      '("/home/ele/bibtex/master.bib"))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ESS stuff;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'ess-site)

;; ;; set the help right to open text
(setq inferior-ess-r-help-command "help(\"%s\", help_type=\"text\")\n")

;; ;; always scroll to output and input 
(setq comint-scroll-to-bottom-on-input t)
(setq comint-scroll-to-bottom-on-output t)

(setq ess-tab-complete-in-script t)

;; Sweave .Rnw mode stuff.
(require 'ess-noweb)
(setq TeX-file-extensions
      '("Snw" "Rnw" "nw" "tex" "sty" "cls" "ltx" "texi" "texinfo"))
(add-to-list 'auto-mode-alist '("\\.Rnw\\'" . Rnw-mode))
(add-to-list 'auto-mode-alist '("\\.Snw\\'" . Snw-mode))

;; Set up knitr functions
(defun ess-swv-knit ()
  "Run knit on the current .Rnw file."
  (interactive)
  (ess-swv-run-in-R "require(knitr) ; knit"))

(defun ess-swv-purl ()
  "Run purl on the current .Rnw file."
  (interactive)
  (ess-swv-run-in-R "require(knitr) ; purl"))

;; this does not work atm
(add-hook 'Rnw-mode-hook
          (lambda ()
            (add-to-list 'TeX-command-list
                         '("knitr" "/home/ele/dotfiles/scripts/knitr.sh %s.Rnw && pdflatex %s.tex"
                           TeX-run-command nil the:help "Run Knitr") t)
            (setq TeX-command-default "knitr")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; LISP;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; not needed at the moment
;; (setq inferior-lisp-program "/usr/bin/sbcl") ;Lisp system
;; (require 'slime)
;; (slime-setup)
;; (slime-setup '(slime-fancy))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; cc-mode stuff ;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'cc-mode)
(add-hook 'c-mode-hook
	  (lambda()
            (define-key c-mode-map (kbd "C-c C-c") 'compile)
	    (define-key c-mode-map (kbd "C-c C-r") 'shell-command)
            (define-key c-mode-map (kbd "C-c C-v") 'man)
            )
	  )

;;;;;;;;;;;;;;;;;;;;;;;;;;,,,;; get the actual ip;;;;;;;;;;;;;;;;;;;;;;
(defun get-ip-address (&optional dev)
  "get the IP-address for device DEV (default: eth0)"
  (let ((dev (if dev dev "eth0"))) 
    (format-network-address (car (network-interface-info dev)) t)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; mail-setup: wanderlust ;;;;;;;;
;;; IMAP and SMTP configured in .wl !!
(autoload 'wl "wl" "Wanderlust" t)
(autoload 'wl-other-frame "wl" "Wanderlust on new frame." t)
(autoload 'wl-draft "wl-draft" "Write draft with Wanderlust." t)

(autoload 'wl-user-agent-compose "wl-draft" nil t)
(if (boundp 'mail-user-agent)
    (setq mail-user-agent 'wl-user-agent))
(if (fboundp 'define-mail-user-agent)
    (define-mail-user-agent
      'wl-user-agent
      'wl-user-agent-compose
      'wl-draft-send
      'wl-draft-kill
      'mail-send-hook))

;; read html formatted mail
(require 'mime-w3m)

;; TeXMed mode
(require 'TeXMed)
(global-set-key "\C-ct" 'TeXMed-search)
(setq TeXMed-bibtex-folder "~/bibtex/")
(setq  TeXMed-include-abstract t)
(setq  TeXMed-include-article-id t)

(require 'blast_plus)

;; have funky signatures
(autoload 'add-signature "c-sig" "c-sig" t)
(autoload 'delete-signature "c-sig" "c-sig" t)
(autoload 'insert-signature-eref "c-sig" "c-sig" t)
(autoload 'insert-signature-automatically "c-sig" "c-sig" t)
(autoload 'insert-signature-randomly "c-sig" "c-sig" t)
(autoload 'write-sig-file "c-sig" "c-sig" t)
(autoload 'read-sig-file "c-sig" "c-sig" t)

;; load additional files
(load-file "/home/ele/dotfiles/dotemacs/w3m-init.el")

;;;;;;;;; Internet Relay Chat with erc ;;;;;;;;;;;;;;;;;;
;; (require 'erc)
;; ;; joining && autojoing
;; ;; wildcards for freenode as the actual server as
;; ;; name can be be a bit different
;; (erc-autojoin-mode t)
;; (setq erc-autojoin-channels-alist
;;       '((".*\\.freenode.net" "#emacs" "#R" "#ratpoison" "#conkeror" "#bioinformatics"))
;;       )

;; ;; check channels
;; (erc-track-mode t)
;; (setq erc-track-exclude-types '("JOIN" "NICK" "PART" "QUIT" "MODE"
;;                                  "324" "329" "332" "333" "353" "477"))
;; ;; don't show any of this
;; (setq erc-hide-list '("JOIN" "PART" "QUIT" "NICK"))

;; ;; load my password file to allow sharing my password-clean .emacs
;; (load "~/.ercpass")
;; (require 'erc-services)
;; (erc-services-mode 1)
;; (setq erc-prompt-for-nickserv-password nil)
;; (setq erc-nickserv-passwords
;;       '((freenode     (("nick-one" . ,freenode-nickone-pass)))))

;; (defun djcb-erc-start-or-switch ()
;;   "Connect to ERC, or switch to last active buffer"
;;   (interactive)
;;   (if (get-buffer "irc.freenode.net:6667") ;; ERC already active?
;;     (erc-track-switch-buffer 1) ;; yes: switch to last active
;;     (when (y-or-n-p "Start ERC? ") ;; no: maybe start ERC
;;       (erc :server "irc.freenode.net" :port 6667 :nick "derele" :full-name "Emanuel Heitlinger")
;;       )))


;;;;;;;;;;;;;;;;  everythin for the mail: the big brother database ;;;;;;;;;;;;;;;;
;;;; not used at the moment
;; (setq bbdb-file "~/.emacs.d/bbdb")           ;; keep ~/ clean; set before loading
;; (require 'bbdb) 
;; (bbdb-initialize)
;; (setq 
;;     bbdb-offer-save 1                        ;; 1 means save-without-asking
;;     bbdb-use-pop-up nil                      ;; no popups for addresses
;;     bbdb-electric-p nil                      ;; NO
;;     bbdb-popup-target-lines  nil             ;; be inexistent
;;     bbdb-dwim-net-address-allow-redundancy t ;; always use full name
;;     bbdb-quiet-about-name-mismatches 0       ;; show name-mismatches 2 secs
;;     bbdb-always-add-address t                ;; add new addresses to existing...
;;                                              ;; ...contacts automatically
;;     bbdb-canonicalize-redundant-nets-p t     ;; x@foo.bar.cx => x@bar.cx
;;     bbdb-completion-type nil                 ;; complete on anything
;;     bbdb-complete-name-allow-cycling t       ;; cycle through matches
;;                                              ;; this only works partially
;;     bbbd-message-caching-enabled t           ;; be fast
;;     bbdb-use-alternate-names t               ;; use AKA
;;     bbdb-elided-display t                    ;; single-line addresses
;; )

;;;;;;;;;;;;;;;;;; org-mode ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;,,
;; (custom-set-variables
;;   ;; custom-set-variables was added by Custom.
;;   ;; If you edit it by hand, you could mess it up, so be careful.
;;   ;; Your init file should contain only one such instance.
;;   ;; If there is more than one, they won't work right.
;;  '(org-agenda-files (quote ("~/org/TODO.org" "~/org/main.org")))
;; )

;; ;; load the appropriate file for each machine
;; (if (string-match "ele-laptop" (getenv "HOSTNAME")) ;; laptop
;;     (load-file "/home/ele/dotfiles/dotemacs/emacs_laptop.el"))

;; (if (string-match "thinkpad" (getenv "HOSTNAME"))
;;     (load-file "/home/ele/dotfiles/dotemacs/emacs_thinkpad.el"))

;; (if (string-match "beagle" (getenv "HOSTNAME")) ;; beagle
;;     (load-file "/home/ele/dotfiles/dotemacs/emacs_beagle.el"))


;; ;; Emacswiki editing only when we have are connected to the web
;; (when (get-ip-address)
;;   (require 'yaoddmuse)
;;   (yaoddmuse-update-pagename t)
;;   (setq yaoddmuse-username "EmanuelHeitlinger")
;;   )

;; ;;;; google mode ;;;;

;; (load-library "g")
;; (setq g-user-email "emanuelheitlinger@gmail.com")
;; (setq g-html-handler 'w3m-buffer)

;; ;; Write to Diary any entry added to Google Calendar
;; ;; from http://bc.tech.coop/blog/070306.html
;; (eval-after-load "gcal"
;;   '(progn
;;      (defun gcal-read-event (title content
;;                    where
;;                    start end
;;                    who
;;                    transparency status)
;;        "Prompt user for event params and return an event structure."
;;        (interactive
;;     (list
;;      (read-from-minibuffer "Title: ")
;;      (read-from-minibuffer "Content: ")
;;      (read-from-minibuffer "Where: ")
;;      (gcal-read-calendar-time "Start Time: ")
;;      (gcal-read-calendar-time "End Time: ")
;;      (gcal-read-who "Participant: ")
;;      (gcal-read-transparency)
;;      (gcal-read-status)))
;;        (save-excursion
;;      (let ((pop-up-frames (window-dedicated-p (selected-window))))
;;        (find-file-other-window (substitute-in-file-name diary-file)))
;;      (when (eq major-mode default-major-mode) (diary-mode))
;;      (widen)
;;      (diary-unhide-everything)
;;      (goto-char (point-max))
;;      (when (let ((case-fold-search t))
;;          (search-backward "Local  Variables:"
;;                   (max (- (point-max) 3000) (point-min))
;;                   t))
;;        (beginning-of-line)
;;        (insert "n")
;;        (forward-line -1))
;;      (let* ((dayname)
;;         (day (substring start 8 10))
;;         (month (substring start 5 7))
;;         (year (substring start 0 4))
;;         (starttime (substring start 11 16))
;;         (endtime (substring end 11 16))
;;         (monthname (calendar-month-name (parse-integer month) t))
;;         (date-time-string (concat (mapconcat 'eval calendar-date-display-form "")
;;                       " " starttime " - " endtime)))
;;        (insert
;;         (if (bolp) "" "n")
;;         ""
;;         date-time-string " " title))
;;      (bury-buffer)
;;      (declare (special gcal-auth-handle))
;;      (let ((event (make-gcal-event
;;                :author-email (g-auth-email gcal-auth-handle))))
;;        (setf (gcal-event-title  event) title
;;          (gcal-event-content event) content
;;          (gcal-event-where event) where
;;          (gcal-event-when-start event) start
;;          (gcal-event-when-end event) end
;;          (gcal-event-who event) who
;;          (gcal-event-transparency  event) transparency
;;          (gcal-event-status event) status)
;;        event)))))
