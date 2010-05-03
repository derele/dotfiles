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

#alias htmluni='dc134@rzlx1.rz.uni-karlsruhe.de :/home/ws/dc134/.public_html'

alias aus='sudo shutdown -h now'

#change caps lock to alt-gr
xmodmap -e "keycode 66=ISO_Level3_Shift"

#change alt-gr to be alt
xmodmap -e "keycode 108=Meta_L Alt_L"

# enable keychain ssh passphrase memory
eval `keychain --eval --nogui -Q -q id_rsa`

#enable 256 color terminal
export TERM=xterm-256color

#emacsclient
export EDITOR='emacsclient -t'
export VISUAL='emacsclient -t'

