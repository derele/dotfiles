(require 'w3m-search)
; add TeXMed http://www.bioinformatics.org/texmed/   
; to searchable sites
;; a webservice to query ncbi-pubmed and translate it's xml to bibtex
(add-to-list 'w3m-search-engine-alist '("TeXmed" "http://www.bioinformatics.org/texmed/cgi-bin/query.cgi?query=%s"))

(define-key w3m-mode-map (kbd "\C-ce") 'TeXmed-export)  

;; link numbering
(require 'w3m-lnum)
  (defun my-w3m-go-to-linknum ()
    "Turn on link numbers and ask for one to go to."
    (interactive)
    (let ((active w3m-link-numbering-mode))
      (when (not active) (w3m-link-numbering-mode))
      (unwind-protect
          (w3m-move-numbered-anchor (read-number "Anchor number: "))
        (when (not active) (w3m-link-numbering-mode)))))

(define-key w3m-mode-map "f" 'my-w3m-go-to-linknum)

;; view buffers with w3m upon request
(global-set-key (kbd "<f11>") 'w3m-browse-current-buffer)
