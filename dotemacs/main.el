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
		    "~/.emacs.d"
		    "~/.emacs.d/color-theme-6.6.0"
		    "~/.emacs.d/emms/lisp"
                    "~/.emacs.d/magit-0.7"
                    "~/dotfiles/dotemacs/own_modes"
                    )
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
(scroll-bar-mode -1)
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

;; auto-complete 
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)

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
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-font-lock-mode 1)

;; org remember
(org-remember-insinuate)
(setq org-directory "~/org/")
(setq org-default-notes-file (concat org-directory "/notes.org"))
(define-key global-map "\C-cr" 'org-remember)

(setq org-remember-templates
      '(("Todo" ?t "* TODO %?\n  %i\n  %a" "~/org/TODO.org" "Tasks")
        ("Journal" ?j "* %U %?\n\n  %i\n  %a" "~/org/JOURNAL.org")
        ("Idea" ?i "* %^{Title}\n  %i\n  %a" "~/org/JOURNAL.org" "New Ideas")))

(define-key org-mode-map "\C-ct" 'org-todo)
(add-to-list 'auto-mode-alist '("\\.[Cc][Ss][Vv]\\'" . org-mode))

;; open-csv files as org-table files
(defun ele-open-csv-as-org-table ()
  "When a .csv file is opened convert it to an org table."
  (if (string-match "csv" (file-name-extension (buffer-name)))
      (progn
        (org-table-convert-region (point-min) (point-max))
        (rename-buffer(concat(file-name-sans-extension (buffer-name)) ".org"))
        (write-file (buffer-name))
        )))
(add-hook 'org-mode-hook 'ele-open-csv-as-org-table)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;terminal  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; multi-terminal-mode
(require 'multi-term)
(setq multi-term-program "/bin/bash")

;; top looking nice
(require 'top-mode)
;; MAKE ME WORK
;; (top-mode 1)

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ESS stuff;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'ess-site)
(add-hook 'ess-mode-hook
	  (lambda()
;;	    (define-key ess-mode-map (kbd "C-c C-h") 'ess-help)  
	    )
	  )
;; Sweave .Rnw mode stuff.
(require 'ess-noweb)
(setq TeX-file-extensions
      '("Snw" "Rnw" "nw" "tex" "sty" "cls" "ltx" "texi" "texinfo"))
(add-to-list 'auto-mode-alist '("\\.Rnw\\'" . Rnw-mode))
(add-to-list 'auto-mode-alist '("\\.Snw\\'" . Snw-mode))
(add-hook 'Rnw-mode-hook
          (lambda ()
            (add-to-list 'TeX-command-list
                         '("Sweave" "R CMD Sweave %s"
                           TeX-run-command nil (latex-mode) :help "Run weaver") t)
            (add-to-list 'TeX-command-list
                         '("weaver" "weaver.sh %s"
                           TeX-run-command nil (latex-mode) :help "Run Sweave") t)
            (add-to-list 'TeX-command-list
                         '("LatexSweave" "%l %(mode) %s"
                           TeX-run-TeX nil (latex-mode) :help "Run Latex after Sweave") t)
            (add-to-list 'TeX-command-list
                         '("allIn1" "weaver.sh %s && rubber -d %s && xpdf '%s.pdf'"
                           TeX-run-TeX nil (latex-mode) :help "xpdf from source") t)
            (add-to-list 'TeX-command-list
                         '("RubberSweave" "rubber -d %s && xpdf '%s.pdf'"
                           TeX-run-command nil t) t)
            (setq TeX-command-default "Sweave")
            )
          )
;; more functions syntax higlighted based on syntax_highlighting.R and the file it writes from S. McKay Curtis on ess-help
(defun read-lines (file)
  "Return a list of lines in FILE."
  (with-temp-buffer
    (insert-file-contents file)
    (split-string
     (buffer-string) "\n" t)
    )
  )

(add-hook 'ess-mode-hook
	  '(lambda()
	     (setq ess-my-extra-R-function-keywords
		   (read-lines "~/.emacs.d/R-function-names.txt"))
 	     (setq ess-R-mode-font-lock-keywords
		   (append ess-R-mode-font-lock-keywords
			   (list (cons (concat "\\<" (regexp-opt
                                                      ess-my-extra-R-function-keywords 'enc-paren) "\\>")
				       'font-lock-function-name-face))))))

;; LaTeX stuff ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; AucTeX with rubber
;; http://www.nabble.com/sweave-and-auctex-td23492805.html
(eval-after-load "tex"
  '(add-to-list 'TeX-command-list
                '("Rubber" "rubber -d %t && xpdf '%s.pdf'" TeX-run-command nil t) t)
  )

;; ebib 
(autoload 'ebib "ebib" "Ebib, a BibTeX database manager." t)

;; reftex
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)   ; with AUCTeX LaTeX mode
(setq reftex-plug-into-AUCTeX t
      reftex-enable-partial-scans t)

(setq reftex-file-extensions
      '((".Rnw" "Rnw" "nw" "tex" ".tex" ".ltx") ("bib" ".bib")))
(setq TeX-file-extensions
      '(".Rnw" "Rnw" "nw" "tex" "sty" "cls" "ltx" "texi" "texinfo"))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; cc-mode stuff ;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'cc-mode)
(add-hook 'c-mode-hook
	  (lambda()
            (define-key c-mode-map (kbd "C-c C-c") 'compile)
	    (define-key c-mode-map (kbd "C-c C-r") 'shell-command)
            (define-key c-mode-map (kbd "C-c C-v") 'man)
            )
	  )

;;;;;;;;; Internet Relay Chat with erc ;;;;;;;;;;;;;;;;;;
(require 'erc)
;; joining && autojoing
;; wildcards for freenode as the actual server as
;; name can be be a bit different
(erc-autojoin-mode t)
(setq erc-autojoin-channels-alist
      '((".*\\.freenode.net" "#emacs" "#R" "#ratpoison" "#conkeror" "#bioinformatics"))
      )

;; check channels
(erc-track-mode t)
(setq erc-track-exclude-types '("JOIN" "NICK" "PART" "QUIT" "MODE"
                                 "324" "329" "332" "333" "353" "477"))
;; don't show any of this
(setq erc-hide-list '("JOIN" "PART" "QUIT" "NICK"))

;; load my password file to allow sharing my password-clean .emacs
(load "~/.ercpass")
(require 'erc-services)
(erc-services-mode 1)
(setq erc-prompt-for-nickserv-password nil)
(setq erc-nickserv-passwords
      '((freenode     (("nick-one" . ,freenode-nickone-pass)))))

(defun djcb-erc-start-or-switch ()
  "Connect to ERC, or switch to last active buffer"
  (interactive)
  (if (get-buffer "irc.freenode.net:6667") ;; ERC already active?
    (erc-track-switch-buffer 1) ;; yes: switch to last active
    (when (y-or-n-p "Start ERC? ") ;; no: maybe start ERC
      (erc :server "irc.freenode.net" :port 6667 :nick "derele" :full-name "Emanuel Heitlinger")
      )))

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


;; have funky signatures
(autoload 'add-signature "c-sig" "c-sig" t)
(autoload 'delete-signature "c-sig" "c-sig" t)
(autoload 'insert-signature-eref "c-sig" "c-sig" t)
(autoload 'insert-signature-automatically "c-sig" "c-sig" t)
(autoload 'insert-signature-randomly "c-sig" "c-sig" t)
(autoload 'write-sig-file "c-sig" "c-sig" t)
(autoload 'read-sig-file "c-sig" "c-sig" t)

;;;;;;;;;;;;;;;;  everythin for the mail: the big brother database ;;;;;;;;;;;;;;;;
(setq bbdb-file "~/.emacs.d/bbdb")           ;; keep ~/ clean; set before loading
(require 'bbdb) 
(bbdb-initialize)
(setq 
    bbdb-offer-save 1                        ;; 1 means save-without-asking
    bbdb-use-pop-up nil                      ;; no popups for addresses
    bbdb-electric-p nil                      ;; NO
    bbdb-popup-target-lines  nil             ;; be inexistent
    bbdb-dwim-net-address-allow-redundancy t ;; always use full name
    bbdb-quiet-about-name-mismatches 0       ;; show name-mismatches 2 secs
    bbdb-always-add-address t                ;; add new addresses to existing...
                                             ;; ...contacts automatically
    bbdb-canonicalize-redundant-nets-p t     ;; x@foo.bar.cx => x@bar.cx
    bbdb-completion-type nil                 ;; complete on anything
    bbdb-complete-name-allow-cycling t       ;; cycle through matches
                                             ;; this only works partially
    bbbd-message-caching-enabled t           ;; be fast
    bbdb-use-alternate-names t               ;; use AKA
    bbdb-elided-display t                    ;; single-line addresses
)

;;;;;;;;;;;;;;;;;; org-mode ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;,,
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(org-agenda-files (quote ("~/org/TODO.org" "~/org/main.org")))
)

;; load additional files
(load-file "/home/ele/dotfiles/dotemacs/w3m-init.el")

;; load the appropriate file for each machine
(if (string-match "ele-laptop" (getenv "HOSTNAME")) ;; laptop
    (load-file "/home/ele/dotfiles/dotemacs/emacs_laptop.el"))

(if (string-match "beagle" (getenv "HOSTNAME")) ;; beagle
    (load-file "/home/ele/dotfiles/dotemacs/emacs_beagle.el"))

;; Emacswiki editing only when we have are connected to the web
(when (get-ip-address)
  (require 'yaoddmuse)
  (yaoddmuse-update-pagename t)
  (setq yaoddmuse-username "EmanuelHeitlinger")
  )
