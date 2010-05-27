# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions

alias e='emacsclient -t'
alias ll='ls -lh'
alias desk='ssh -Y -c arcfour,blowfish-cbc -C 129.13.174.240'
alias beagle='ssh -Y -c arcfour,blowfish-cbc -C 129.13.174.229'
alias uni='ssh -Y -c arcfour,blowfish-cbc -C dc134@www1.rz.uni-karlsruhe.de'

alias unison='unison streamlined -ui text -auto'

alias usrout='skill -KILL -u ele'

alias skype='LD_PRELOAD=/usr/lib/libv4l/v4l1compat.so skype'

alias aus='sudo shutdown -h now'

# enable keychain ssh passphrase memory
eval `keychain --eval --nogui -Q -q id_rsa`

### do some readline remapping
bind -f ~/dotfiles/.inputrc

#enable 256 color terminal
export TERM=xterm-256color

#emacsclient
export EDITOR='emacsclient -t'
export VISUAL='emacsclient -t'

#pager most
export PAGER=most