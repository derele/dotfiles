;; -*-lisp-*-
;;stumpwmrc.lisp --- my own Stumpwm customizations
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;Startup programs;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(in-package :stumpwm)

;;Do some key re-mapping; it is crucial that this get run first, because otherwise
;;the remapping later on of Insert and less to the prefix key simply will not work.
(run-shell-command "xmodmap -quiet ~/.Xmodmap")
   
;;Apparently modifies some low-level GUI bits of X.
(run-shell-command "xrdb -load ~/.Xresources -quiet")
   
;;Change the background and pointer in X
;;(run-shell-command "xsetroot -cursor_name left_ptr -gray -fg darkgreen -bg black -name root-window")
   
;;Netwok manager and other stuff from gnome
(run-shell-command "gnome-panel")
(run-shell-command "nm-applet")
(run-shell-command "gnome-power-manager")
(run-shell-command "dropbox start")
(run-shell-command "gnome-volume-control-applet")
;;(run-shell-command "skype")

;;Have a screen in a xterm
(run-shell-command "xterm -e screen_after_256.sh")
(run-shell-command "emacs --daemon")

      
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;Key binding;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;Make the bindings more comfortable.
   
(define-key *top-map* (kbd "M-TAB") "next")

(define-key *root-map* (kbd "F1") "exec xterm -e screen_after_256.sh")
(define-key *root-map* (kbd "F2") "exec xterm -e beagle-ssh.sh")
(define-key *root-map* (kbd "F3") "exec conkeror")
(define-key *root-map* (kbd "F4") "exec firefox")
(define-key *root-map* (kbd "F5") "exec google-chrome")





