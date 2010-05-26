!#/bin/bash
yum install git xtern ratpoison most R emacs emacs-ess w3m-el emacs-bbdb unison keychain screen

ln -s dotfiles/dotemacs/main.el .emacs
ln -s dotfiles/conkeror_rc.js .conkerorrc
rm .bashrc
ln -s dotfiles/bashrc.sh .bashrc

ln -s /home/ele/dotfiles/shellscripts/* /usr/local/bin/