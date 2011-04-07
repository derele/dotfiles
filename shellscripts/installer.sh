!#/bin/bash
yum install git xterm ratpoison most R emacs emacs-ess w3m-el emacs-bbdb emacs-auctex unison keychain screen gnutls-utils rubber xpdf offlineimap openoffice.org-base sbcl aspell-de autoconf texinfo xulrunner

ln -s dotfiles/dotemacs/main.el .emacs
ln -s dotfiles/conkeror_rc.js .conkerorrc
ln -s dotfiles/ratpoisonrc .ratpoisonrc
ln -s dotfiles/Xresources .Xresources
ln -s dotfiles/Rprofile.R .Rprofile


rm .bashrc
ln -s dotfiles/bashrc.sh .bashrc


ln -s /home/ele/dotfiles/shellscripts/* /usr/local/bin/