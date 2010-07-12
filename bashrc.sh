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

alias usrout='sudo skill -KILL -u ele'

alias skype='LD_PRELOAD=/usr/lib/libv4l/v4l1compat.so skype'

alias aus='sudo shutdown -h now'

alias yum='sudo yum -y'

# enable keychain ssh passphrase memory
eval `keychain --eval --nogui -Q -q id_rsa`

### do some readline remapping
bind -f /home/ele/dotfiles/.inputrc

# make sure we are up to date
# but first check, that yum is not running already
if [ -z "$(ps -A | grep "yum")" ]
then  
    sudo yum -y -q upgrade &>/dev/null &
#    echo -e "yum started an update in the background\n"
else 
    echo -e "yum is already keeping you up to date in the background\n"
fi

# enable 256 color terminal
export TERM=xterm-256color

# emacsclient
export EDITOR='emacsclient -t'
export VISUAL='emacsclient -t'

# pager most
export PAGER=most

# ignore some history
export HISTIGNORE="ll:ls:exit:cd:e"
export HISTCONTROL=erasedupsexport 

# give R a global history file in combi with some code in Rprofile
export R_HISTFILE=/home/ele/.Rhistory

# some things needed on beagle for some programms
export PHRED_PARAMETER_FILE=/home/ele/tools/phred-dist-020425.c-acd/phredpar.dat
export ESTSCANDIR=/home/ele/tools/estscan-3.0.2
export ESTSCANLIB=/usr/local/lib64/perl5/site_perl/5.10.0/x86_64-linux-thread-multi

source /home/ele/dotfiles/shell_functions.sh

#echo -e "
           ###########################################
           #  This a stable setup, now do some work  #
           ###########################################
        
        "
