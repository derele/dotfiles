!#/bin/bash
yum install git most emacs emacs-ess w3m-el emacs-bbdb emacs-auctex unison keychain screen gnutls-utils rubber xpdf offlineimap sbcl aspell-de autoconf texinfo xulrunner

ln -s dotfiles/dotemacs/main.el .emacs
ln -s dotfiles/conkeror_rc.js .conkerorrc
ln -s dotfiles/ratpoisonrc .ratpoisonrc
ln -s dotfiles/Xresources .Xresources
ln -s dotfiles/Rprofile.R .Rprofile


ln -s  dotfiles/aspell.en.pws .aspell.en.pws
ln -s  dotfiles/aspell.de.pws .aspell.de.pws
ln -s  dotfiles/aspell.en.prepl .aspell.en.prepl
ln -s  dotfiles/aspell.de.prepl .aspell.de.prepl

rm .bashrc
ln -s dotfiles/bashrc.sh .bashrc

ln -s /home/ele/dotfiles/shellscripts/* /home/ele/bin/

