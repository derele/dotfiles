;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; the web ;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Problem here... should really get this to work
(defun browse-url-or-follow-link
  "browse whatever a link or an url"
  (interactive)
  if(url-get-url-at-point 
     (browse-url-at-point) 
     (w3m-view-url-with-external-browser)) 
)

; set my browser to conkeror
(setq browse-url-generic-program "conkeror")
(setq browse-url-browser-function 'browse-url-generic)
(global-set-key "\C-xck" 'browse-url-at-point)
; it would be nice to use w3m-view-url... in case we are
; on a link instead of a url but for the meantime CK is enough
(global-set-key "\C-xCK" 'w3m-view-url-with-external-browser)

;;make a key for w3m browsing inside emacs
(global-set-key "\C-xwm" 'w3m-browse-url)


;;;;;;;;;;;;;;;;;;;;;;;; EMMS for multimedia ;;;;;;;;;;;;;;;;
(require 'emms-setup)
(emms-standard)
(emms-default-players)
(setq emms-source-file-default-directory "~/musik/")
(emms-add-playlist-directory-tree 

(require 'emms-streams)

(require 'emms-volume)

(global-set-key "\C-cm" nil)
(global-set-key "\C-cm-" 'emms-volume-lower)
(global-set-key  "\C-cm+" 'emms-volume-raise)
(global-set-key  "\C-cmh" 'emms-pause)

(global-set-key  "\C-cmn" 'emms-next)
(global-set-key  "\C-cmp" 'emms-previous)
(global-set-key  "\C-cmm" 'emms)

