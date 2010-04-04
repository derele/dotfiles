;; beagle is my ssh-server
;; most of the stuff here is intended to control
;; the second emacs runnning on the laptop
;; or the browser conkeror also running on the
;; laptop while I am editing in beagle's emacs

;; ToDo:
;; when emacs starts on laptop it should check it's ip
;; and then update this line on beagle
(setenv  "LAPTOPIP" "129.215.170.79")

(defun remote-emacs (command)
  "Run a remote emacsclient eval (machine has to have a shell script
to avoid quoting)."
  (interactive)
  (setq cmd (concat "ssh $LAPTOPIP -t emacsclient-eval.sh " 
                    command))
  (shell-command cmd)
  (message cmd)
  )

;; control emms on the laptop 
(global-set-key "\C-cm" nil)
(global-set-key  "\C-cmh" (lambda () (interactive) (remote-emacs "emms-pause")))
(global-set-key "\C-cm-" (lambda () (interactive) (remote-emacs "emms-volume-lower")))
(global-set-key  "\C-cm+" (lambda () (interactive) (remote-emacs "emms-volume-raise")))
(global-set-key  "\C-cmn" (lambda () (interactive) (remote-emacs "emms-next")))
(global-set-key  "\C-cmp" (lambda () (interactive) (remote-emacs "emms-previous")))

;; have to decide wether to control the remote conkeror web-browser directly or 
;; through the remote emacs. I go for the more complicated way, as I want to open
;; links and do such complicated sutuff
;; (global-set-key  "\C-cC" (lambda () (interactive) (remote-emacs "browse-url-or-follow-link")))
;; this doesn't work as the remote emacs will try to follow its own point's position
;; following links is a harder problem...
;; for now just open url

(defun remote-conkeror ()
  "Run a remote conkeror on the thing under point."
  (interactive)
  (setq cmd (concat "ssh $LAPTOPIP -t conkeror " 
                    (thing-at-point 'url)))
  (shell-command cmd)
  (message cmd)
  )
(global-set-key  "\C-cC" 'remote-conkeror)

