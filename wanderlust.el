;; wanderlust 
;; my mail setup

(setq-default mime-transfer-level 8) ; solve some encoding problems

(setq 
 elmo-maildir-folder-path "~/Maildir"          ;; where i store my mail
 
 wl-stay-folder-window t                       ;; show the folder pane (left)
 wl-folder-window-width 20                     ;; toggle on/off with 'i'
 
 ; don't cache messages too long (I use maildir anyways)
 elmo-cache-expire-by-age  14
 elmo-cache-expire-by-size 1024

 
  wl-from "Emanuel Heitlinger <emanuelheitlinger@gmail.com>"                  ;; my From:
  ;; note: all below are dirs (Maildirs) under elmo-maildir-folder-path 
  ;; the '.'-prefix is for marking them as maildirs
  wl-fcc ".[Google Mail].Sent Mail"               ;; sent msgs go to the "sent"-folder
  wl-fcc-force-as-read t                          ;; mark sent messages as read 
  wl-default-folder ".INBOX"                      ;; my main inbox 
  wl-draft-folder ".[Google Mail].Drafts"         ;; store drafts in 'postponed'
  wl-trash-folder ".[Google Mail].Trash"          ;; put trash in 'trash'
  wl-spam-folder ".[Google Mail].Spam"            ;; spam

  wl-folder-desktop-name "All-Ele"

  wl-biff-check-interval 30 ;; check every 30 seconds
  wl-biff-check-folder-list '(".INBOX")) ;;
  wl-biff-use-idle-timer nil ;; in the background


;; format the summary line
;(setq wl-summary-line-format "%n%T%P%M/%D(%W)%h:%m %t%[%17(%c %f%) %] %l%~%@%~%80(%s%)")


  ;; hide many fields from message buffers
  wl-message-ignored-field-list '("^.*:")
  wl-message-visible-field-list
  '("^\\(To\\|Cc\\):"

    "^Subject:"
    "^\\(From\\|Reply-To\\):"
    "^Organization:"
    "^Message-Id:"
    "^\\(Posted\\|Date\\):"
    )
  wl-message-sort-field-list
  '("^From"

    "^Organization:"
    "^X-Attribution:"
     "^Subject"
     "^Date"
     "^To"
     "^Cc")
  )

(add-hook 'wl-draft-send-hook
          ;; SMTP
          '(lambda()
             (let 
                 ((my-ip (if (get-ip-address)(get-ip-address)(get-ip-address "wlan0"))) 
                  ) ;; if we find wired take it otherwise go for wifi
               (if my-ip ;; there is a network
                   (if (string-match "129.13.174." my-ip) ;;inside uni
                       (setq 
                        wl-smtp-connection-type 'starttls
                        wl-smtp-posting-port 587
                        wl-smtp-posting-user "dc134"
                        wl-smtp-posting-server "smtp.stud.uni-karlsruhe.de"
                        wl-local-domain "uni-karlsruhe.de")
                     (setq ; else outside use gmail
                      wl-smtp-connection-type 'starttls
                      wl-smtp-posting-port 587
                      wl-smtp-authenticate-type "plain" ; <- gmail needs this
                      wl-smtp-posting-user "emanuelheitlinger@gmail.com"
                      wl-smtp-posting-server "smtp.gmail.com"
                      wl-local-domain "gmail.com")       
                     )
                 ;; else we are offline
                 (print "No Network connections found on eth0 and wlan0")
                 ))
             )
          )


(require 'bbdb-wl)
(bbdb-wl-setup)
;; i don't want to store addresses from my mailing folders
(setq 
 bbdb-wl-folder-regexp    ;; get addresses only from these folders
 "^\.INBOX$\\|^.Sent Mail")    ;; 
(define-key wl-draft-mode-map "\t" 'bbdb-complete-name)
 
;; from a WL-mailinglist post by David Bremner
;; Invert behaviour of with and without argument replies.
;; just the author
(setq wl-draft-reply-without-argument-list
  '(("Reply-To" ("Reply-To") nil nil)
     ("Mail-Reply-To" ("Mail-Reply-To") nil nil)
     ("From" ("From") nil nil)))

;; bombard the world
(setq wl-draft-reply-with-argument-list
  '(("Followup-To" nil nil ("Followup-To"))
     ("Mail-Followup-To" ("Mail-Followup-To") nil ("Newsgroups"))
     ("Reply-To" ("Reply-To") ("To" "Cc" "From") ("Newsgroups"))
     ("From" ("From") ("To" "Cc") ("Newsgroups"))))


;; suggested by Masaru Nomiya on the WL mailing list
;; and from emacs foo
(defun djcb-wl-draft-subject-check ()
  "check whether the message has a subject before sending"
  (if (and (< (length (std11-field-body "Subject")) 1)
        (null (y-or-n-p "No subject! Send current draft?")))
      (error "Abort.")))

;; note, this check could cause some false positives; anyway, better
;; safe than sorry...
(defun djcb-wl-draft-attachment-check ()
  "if attachment is mention but none included, warn the the user"
  (save-excursion
    (goto-char 0)
    (unless ;; don't we have an attachment?

      (re-search-forward "^Content-Disposition: attachment" nil t) 
     (when ;; no attachment; did we mention an attachment?
        (re-search-forward "attach" nil t)
        (unless (y-or-n-p "Possibly missing an attachment. Send current draft?")
          (error "Abort."))))))
(add-hook 'wl-mail-send-pre-hook 'djcb-wl-draft-subject-check)
(add-hook 'wl-mail-send-pre-hook 'djcb-wl-draft-attachment-check)