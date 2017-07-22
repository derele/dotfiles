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
                    "~/.emacs.d/g-client"
                    "~/.emacs.d/polymode"
                    "~/.emacs.d/polymode/modes"
                    "~/dotfiles/dotemacs/own_modes")              
              load-path))

;;;;;;;;;;;;;;;;;;;;;;;;;;;; additonal packages ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Git VCS stuff ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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

(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)

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

(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-buffer)

;; use pdflatex
(setq TeX-PDF-mode t)

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
;; (setq TeX-file-extensions
;;      '("Snw" "Rnw" "nw" "tex" "sty" "cls" "ltx" "texi" "texinfo"))
;;(add-to-list 'auto-mode-alist '("\\.Rnw\\'" . Rnw-mode))
;;(add-to-list 'auto-mode-alist '("\\.Snw\\'" . Snw-mode))

;; ;; Set up knitr functions
;; (defun ess-swv-knit ()
;;   "Run knit on the current .Rnw file."
;;   (interactive)
;;   (ess-swv-run-in-R "require(knitr) ; knit"))

;; (defun ess-swv-purl ()
;;   "Run purl on the current .Rnw file."
;;   (interactive)
;;   (ess-swv-run-in-R "require(knitr) ; purl"))

;; this does not work atm
;; (add-hook 'Rnw-mode-hook
;;           (lambda ()
;;             (add-to-list 'TeX-command-list
;;                          '("knitr" "/home/ele/dotfiles/scripts/knitr.sh %s.Rnw && pdflatex %s.tex"
;;                            TeX-run-command nil the:help "Run Knitr") t)
;;             (setq TeX-command-default "knitr")))


(require 'polymode)
(require 'poly-R)
(require 'poly-markdown)
(require 'color)

;;; MARKDOWN
(add-to-list 'auto-mode-alist '("\\.md" . poly-markdown-mode))

;;; R modes
(add-to-list 'auto-mode-alist '("\\.Snw" . poly-noweb+r-mode))
(add-to-list 'auto-mode-alist '("\\.Rnw" . poly-noweb+r-mode))
(add-to-list 'auto-mode-alist '("\\.Rmd" . poly-markdown+r-mode))

(defun rmarkdown-new-chunk (name)
  "Insert a new R chunk."
  (interactive "sChunk name: ")
  (insert "\n```{r " name "}\n")
  (save-excursion
    (newline)
    (insert "```\n")
    (previous-line)))

(defun rmarkdown-weave-file ()
  "Run knitr on the current file and weave it as MD and HTML."
  (interactive)
  (shell-command
   (format "knit.sh -c %s"
           (shell-quote-argument (buffer-file-name)))))

(defun rmarkdown-tangle-file ()
  "Run knitr on the current file and tangle its R code."
  (interactive)
  (shell-command
   (format "knit.sh -t %s"
           (shell-quote-argument (buffer-file-name)))))

(defun rmarkdown-preview-file ()
  "Run knitr on the current file and display output in a browvser."
  (interactive)
  (shell-command
   (format "knit.sh -b %s"
                  (shell-quote-argument (buffer-file-name)))))


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

;; TeXMed mode
(require 'TeXMed)
(global-set-key "\C-ct" 'TeXMed-search)
(setq TeXMed-bibtex-folder "~/bibtex/")
(setq  TeXMed-include-abstract t)
(setq  TeXMed-include-article-id t)

(require 'blast_plus)
