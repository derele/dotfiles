;;;;; TeXMed - Query and retrieve BibTeX from NCBI pubmed via TeXMed
;;
;; AUTHOR:  Emanuel Heitlinger <emanuelheitlinger@gmail.com>
;; LICENCE: GPL2
;; How to install:
;; 1). Download this file from the following URL and put in your emacs's
;;     load-path
;; 2). Put the following in your .emacs:
;;     (require 'TeXMed)
;;
;; How to use:
;; 1). 
;; 2). 
;; 3). 
;; 4). 

;; Only tested with Gnu-Emacs 23.1.1.


(defgroup TeXMed nil "TeXMed: retrieve bibtex from pubmed" :group 'Tex)

(defvar TeXMed-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map "\C-ce" 'TeXMed-mark-all)
    (define-key map "\C-cl" 'TeXMed-ask-loop)
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

;; global functions Texmed search 
(defun TeXMed-search ()
  "Search for a querry you are prompted for on TeXMed,
an online-service, which allows retieval of bibtex from
pubmed"
  (interactive)
  (let ((query 
         (read-from-minibuffer "TeXmed search: ")))
    (w3m-search-do-search 'w3m-goto-url "TeXmed" query)
    (TeXMed-mode)
    (setq TeXmed-last-searched query))
  )

(defun TeXMed-mark-all ()
  "Mark all entries found in TexMed's w3m buffer"
  (interactive)
  (beginning-of-buffer)
  (while (w3m-form-goto-next-field)
    (when (looking-at " ]PMID")
      (w3m-view-this-url)
      ))
  )      

(defun TeXMed-export ()
  "Export the entries marked in TeXMed's w3m buffer."
  (beginning-of-buffer)
  (while (w3m-form-goto-next-field)
    (when (looking-at "\\[export]")
      (w3m-view-this-url))
    )
  (rename-buffer (concat "TeXMed_search_" TeXmed-last-searched ".bib"))
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
      (if(y-or-n-p "export entry? ")
          (w3m-view-this-url)
        (w3m-goto-next-field)
        )))
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
