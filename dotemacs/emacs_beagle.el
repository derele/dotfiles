;; beagle is my ssh-server
;; most of the stuff here is intended to control
;; the second emacs runnning on the laptop
;; or the browser conkeror also running on the
;; laptop while I am editing in beagle's emacs

;; ToDo:
;; when emacs starts on laptop it should check it's ip
;; and then update this line on beagle
(setq  laptopip "129.215.170.79")

(defun remote-emacs (command)
  "Run a remote emacsclient eval (machine has to have a shell script
to avoid quoting)."
  (interactive)
  (setq cmd (concat "ssh "laptopip" -t emacsclient-eval.sh " 
                    command))
  (shell-command cmd)
  (message cmd)
  )

;; ;; control emms on the laptop 
;; (global-set-key "\C-cm" nil)
;; (global-set-key  "\C-cmh" (lambda () (interactive) (remote-emacs "emms-pause")))
;; (global-set-key "\C-cm-" (lambda () (interactive) (remote-emacs "emms-volume-lower")))
;; (global-set-key  "\C-cm+" (lambda () (interactive) (remote-emacs "emms-volume-raise")))
;; (global-set-key  "\C-cmn" (lambda () (interactive) (remote-emacs "emms-next")))
;; (global-set-key  "\C-cmp" (lambda () (interactive) (remote-emacs "emms-previous")))
;; (global-set-key  "\C-cmr" (lambda () (interactive) (remote-emacs "emms-random")))

;; have to decide wether to control the remote conkeror web-browser directly or 

(defun remote-conkeror ()
  "Run a remote conkeror on the thing under point."
  (interactive)
  (setq cmd (concat "ssh "laptopip" -t conkeror " 
                    (thing-at-point 'url)))
  (shell-command cmd)
  (message cmd)
  )
(global-set-key  "\C-cC" 'remote-conkeror)

