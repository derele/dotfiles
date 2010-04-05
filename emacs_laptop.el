;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; the web ;;;;;;;;;;;;;;;;;;;;;;;;;;

;; a function to test if it is a url at point
;; then open this url or assume it is a link
(defun browse-url-or-follow-link ()
  (interactive)
  (if(string-match thing-at-point-url-regexp (thing-at-point 'symbol)) 
      (browse-url-at-point) ;; yes view it
    (w3m-view-url-with-external-browser) ;; no assume it is a link view tiis
    ))

; set my browser to conkeror
(setq browse-url-generic-program "conkeror")
(setq browse-url-browser-function 'browse-url-generic)

;(global-set-key "\C-xck" 'browse-url-at-point)

; it would be nice to use w3m-view-url... in case we are
; on a link instead of a url but for the meantime CK is enough
(global-set-key "\C-cC" 'browse-url-or-follow-link)

;;make a key for w3m browsing inside emacs
(global-set-key "\C-cW" 'w3m-browse-url)


;;;;;;;;;;;;;;;;;;;;;;;; EMMS for multimedia ;;;;;;;;;;;;;;;;
(require 'emms-setup)
(emms-standard)
(emms-default-players)
(setq emms-source-file-default-directory "~/musik/")
(emms-add-playlist-directory-tree "~/musik/")

(require 'emms-streams)

(require 'emms-volume)
;; change volume in bigger intervals
(setq emms-volume-change-amount 6)

(global-set-key "\C-cm" nil)
(global-set-key "\C-cm-" 'emms-volume-lower)
(global-set-key  "\C-cm+" 'emms-volume-raise)
(global-set-key  "\C-cmh" 'emms-pause)
(global-set-key  "\C-cmn" 'emms-next)
(global-set-key  "\C-cmp" 'emms-previous)
(global-set-key  "\C-cmr" 'emms-random)


(global-set-key  "\C-cmm" 'emms)

