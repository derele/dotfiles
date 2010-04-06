;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; the web ;;;;;;;;;;;;;;;;;;;;;;;;;;

;; a function to test if it is a url at point
;; then open this url or assume it is a link
(defun browse-url-or-follow-link ()
  (interactive)
;; guess this would be better but must undersand regex better to make it work
;  (if(string-match thing-at-point-url-regexp (thing-at-point 'symbol)) 
  (if(string-match "http" (thing-at-point 'symbol)) 
    (browse-url-at-point) ;; yes view it
    (w3m-view-url-with-external-browser) ;; no assume it is a link view tiis
    ))

; set my browser to conkeror
(setq browse-url-generic-program "conkeror")
(setq browse-url-browser-function 'browse-url-generic)

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

;; norify send to warn me about e-mail etc...

(defun djcb-popup (title msg &optional icon sound)
  "Show a popup if we're on X, or echo it otherwise; TITLE is the title
of the message, MSG is the context. Optionally, you can provide an ICON and
a sound to be played"
  (interactive)
  (when sound (shell-command
               (concat "mplayer -really-quiet " sound " 2> /dev/null")))
  (if (eq window-system 'x)
      (shell-command (concat "notify-send "
                             (if icon (concat "-i " icon) "")
                             " '" title "' '" msg "'"))
    ;; text only version
    (message (concat title ": " msg))))

(add-hook 'wl-mail-send-pre-hook 'djcb-wl-draft-subject-check)
(add-hook 'wl-mail-send-pre-hook 'djcb-wl-draft-attachment-check)

(add-hook 'wl-biff-notify-hook
          (lambda()
            (djcb-popup "Wanderlust" "You have new mail!")))


