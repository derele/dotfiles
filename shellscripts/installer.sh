!#/bin/bash
yum install git xtern ratpoison most R emacs emacs-ess emacs-w3m emacs-bbdb unison keychain

ln -s dotfiles/dotemacs/main.el .emacs
ln -s dotfiles/conkeror_rc.js .conkerorrc
rm .bashrc
ln -s dotfiles/bashrc.sh .bashrc