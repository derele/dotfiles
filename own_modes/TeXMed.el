;;;;; TeXMed.el - Query and retrieve BibTeX from NCBI pubmed via TeXMed in Emacs
;;
;; Based on: TeXMed - http://www.bioinformatics.org/texmed/
;; an interface to NCBI PubMed http://www.ncbi.nlm.nih.gov, 
;; that allows you to query PubMed and to store references in BibTeX format. 
;; by Arne Muller
;;
;; AUTHOR:  Emanuel Heitlinger <emanuelheitlinger@gmail.com>
;; LICENCE: GPL2
;; How to install:
;; 1). Download this file and put in your emacs's load-path
;; 2). Put the following in your .emacs:
;;     (require 'TeXMed)
;;     (global-set-key "\C-ct" 'TeXMed-search)
;;     
;; DEPENDENCIES: 
;; 1). emacs-w3m http://emacs-w3m.namazu.org/ 
;;
;; How to use:
;; 1). Type C-ct to start a query (that's press Strg and c together then
;;     t alone)
;; 2). Presented with the results of the query you have these options:
;;     a) Type C-ea to export all results to a bibtex-file
;;     b) Type C-el to go through results ond choose one by one
;;         + If you do this till the last entry your selection will be 
;;           exported automatically
;;         + If you are satisfied befor the end abort with C-g an goto 3.)
;; 3). Type C-ee to export a selection
;;
;;
;; Only tested with Gnu-Emacs 23.1.1.

;; This is my very first minor mode for Emacs:
;; It probabely has many bugs, uses maybe bad elisp
;; and fails following some of the conventions

;; load dependencies
(require 'w3m-search)

;; Add the serch TeXMed search engine
(add-to-list 'w3m-search-engine-alist '("TeXMed" "http://www.bioinformatics.org/texmed/cgi-bin/query.cgi?query=%s"))

;; Local keybindings
(defgroup TeXMed nil "TeXMed: retrieve bibtex from pubmed" :group 'Tex)
(defvar TeXMed-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map "\C-cea" 'TeXMed-export-all)
    (define-key map "\C-cel" 'TeXMed-ask-loop)
    (define-key map "\C-cee" 'TeXMed-export)
    map))

;; Mode definition
(defun TeXMed-mode
  (setq TeXMed-mode 
	(if (null arg) (not word-count-mode) (> (prefix-numeric-value arg) 0)))
  (if TeXMed-mode
      (TeXMed-mode-on)
    (TeXMed-mode-off))
  (run-hooks 'TeXMed-mode-hook)
  )

;; The variables of the mode
(defvar TeXMed-last-searched nil "Stores the last query used in TeXMed")

(defcustom TeXMed-export-hook nil
  "Hook run when exporting TeXMed searches."
  :type 'hook
  :options '(TeXMed-include-article-id TeXMed-include-abstracts)
  :group 'TeX)

;; global functions Texmed search 
(defun TeXMed-search ()
  "Search for a querry you are prompted for on TeXMed,
an online-service, which allows retieval of bibtex from
pubmed"
  (interactive)
  (let ((query 
         (read-from-minibuffer "TeXMed search: ")))
    (w3m-search-do-search 'w3m-goto-url "TeXMed" query)
    (TeXMed-mode)
    (setq TeXMed-last-searched query))
  )

(defun TeXMed-tick-field (proceeding)
  "Tick the field proceeding the argument"
  (beginning-of-buffer)
  (while (w3m-form-goto-next-field)
    (when (looking-at proceeding)
      (w3m-view-this-url)
      )
    )
  )

(defun TeXMed-include-aticle-id ()
  "Tick the include article id link"
  (TeXMed-tick-field  " ] link article ids")
  )

(defun TeXMed-include-abstract ()
  "Tick the include article id link"
  (TeXMed-tick-field  " ] incl. abstract")
  )

(defun TeXMed-mark-all ()
  "Mark all entries found in TexMed's w3m buffer"
  (TeXMed-tick-field  " ]PMID")
  )

(defun TeXMed-export ()
  "Export the entries marked in TeXMed's w3m buffer."
  (interactive)
  (beginning-of-buffer)
  TeXMed-export-hook
  (TeXMed-tick-field "\\[export]")
  (write-file (concat "TeXMed_search_" TeXMed-last-searched ".bib"))
  (bibtex-mode)  
  )

(defun TeXMed-ask-loop ()
  "Go through entries found on TexMed 
and ask wether to export to a BibTeX file, 
export the chosen"
  (interactive)
  (beginning-of-buffer)
  (while (w3m-form-goto-next-field)
    (when (looking-at " ]PMID")
      (if(y-or-n-p 
          (concat "export entry " 
                  (buffer-substring-no-properties (search-backward ".") (+ 1 (search-backward "\n")))
                  " ?"))
          (progn     ; additional next field because regex search above moves point
            (w3m-form-goto-next-field)
            (w3m-view-this-url))
        (w3m-form-goto-next-field)
        )))
  (TeXMed-export)
  )

(defun TeXMed-export-all ()
  "Export all the entries found on TexMed to a BibTeX file"
  (interactive)
  (TeXMed-mark-all)
  (TeXMed-export)
  )

(define-minor-mode TeXMed-mode
  "Toggle TeXMed mode.
     With no argument, this command toggles the mode.
     Non-null prefix argument turns on the mode.
     Null prefix argument turns off the mode."     
  ;; The initial value.
  :init-value nil
  ;; The indicator for the mode line.
  :lighter " TeXMed"
  )

(provide 'TeXMed)
;; ----------------------------------------------------------------------
