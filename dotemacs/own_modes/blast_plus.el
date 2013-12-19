(require 'thingatpt)


;; probably better way to do it
;; (defun run-blastn ()
;;   "Run blastn for the sequence under point."
;;   (interactive)
;;   (setq cmd (concat "blastn -query <(echo -e \""
;;                     (thing-at-point 'word)
;;                     "\") -db /data/db/blastdb/nt/nt "))
;;   (message (concat "blastn" arg))
;;   (start-process "*run-blastn*" "*run-blastn*" "blastn" arg)
;;   (pop-to-buffer "*run-blastn*"))

(defun run-blastn ()
  "Run blastn for the sequence under point."
  (interactive)
  (setq cmd (concat "blastn -query <(echo -e \""
                    (thing-at-point 'word)
                    "\") -db /data/db/blastdb/nt/nt &"))
  (message cmd)
  (shell-command cmd))
(global-set-key  "\C-cn" 'run-blastn)


(defun run-blastx ()
  "Run blastx for the sequence under point."
  (interactive)
  (setq cmd (concat "blastx -query <(echo -e \""
                    (thing-at-point 'word)
                    "\") -db /data/db/blastdb/nr/nr &"))
  (message cmd)
  (shell-command cmd))
(global-set-key  "\C-cx" 'run-blastx)


(defun run-blastp ()
  "Run blastp for the sequence under point."
  (interactive)
  (setq cmd (concat "blastp -query <(echo -e \""
                    (thing-at-point 'word)
                    "\") -db /data/db/blastdb/nr/nr &"))
  (message cmd)
  (shell-command cmd))
(global-set-key  "\C-cp" 'run-blastp)


(provide 'blast_plus)
