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
;;;###autoload
(defun TeXmed-search ()
  "Search for a querry you are prompted for on TeXmed,
an online-service, which allows retieval of bibtex from
pubmed"
  (interactive)
  (let ((query 
         (read-from-minibuffer "TeXmed search: ")))
    (w3m-search-do-search 'w3m-goto-url "TeXmed" query)
    (TeXMed-mode)
    (setq TeXmed-last-searched query))
  )
                                        ;
(defun TeXmed-export-all ()
  "Export the entries found on TexMed to a BibTeX file"
  (interactive)
  (beginning-of-buffer)
  (while (w3m-form-goto-next-field)
    (when (looking-at " ]PMID")
      (w3m-view-this-url)
      ))
  (beginning-of-buffer)
  (while (w3m-form-goto-next-field)
    (when (looking-at "\\[export]")
      (w3m-view-this-url))
    )
  
  (rename-buffer (concat "TeXMed_search_" TeXmed-last-searched ".bib"))
  (bibtex-mode)  
  )              

(define-minor-mode TeXMed-mode
  "Toggle TeXMed mode.
     With no argument, this command toggles the mode.
     Non-null prefix argument turns on the mode.
     Null prefix argument turns off the mode.
     
     When TeXMed mode is enabled, the control delete key
     gobbles all preceding whitespace except the last."
  ;; The initial value.
  :init-value nil
  ;; The indicator for the mode line.
  :lighter " TeXMed"
  ;; The minor mode bindings.
  :keymap
  '(("\C-a" . TeXMed-export-all))
  :group 'TeXMed)

(provide 'TeXMed)
;; ----------------------------------------------------------------------
