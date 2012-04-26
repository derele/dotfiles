# .bashrc
# This file contains generic customization for all my machines 

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
alias e='emacsclient -t'
alias ll='ls -lh'
alias yum='sudo yum -y'
alias ssh='ssh -Y -c arcfour,blowfish-cbc -C'
alias feh='feh -FZ'

# enable keychain ssh passphrase memory
eval `keychain --eval --nogui -Q -q id_rsa`

### do some readline remapping
bind -f /home/ele/dotfiles/.inputrc

# enable 256 color terminal
export TERM=xterm-256color

# emacsclient
export EDITOR='emacsclient -t'
export VISUAL='emacsclient -t'

# pager most
export PAGER=most

# browser conkeror
export BROWSER=/usr/local/bin/conkeror

# ignore some history
export HISTIGNORE="ll:ls:exit:cd:e:rm"
export HISTCONTROL=erasedupsexport 

# give R a global history file in combi with some code in Rprofile
export R_HISTFILE=/home/ele/.Rhistory

source /home/ele/dotfiles/shell_functions.sh

if [ $HOSTNAME != beagle ]
then
    source /home/ele/dotfiles/lap_bash.sh
else
    # some things needed on beagle for some programs
    export PHRED_PARAMETER_FILE=/home/ele/tools/phred-dist-020425.c-acd/phredpar.dat
    export ESTSCANDIR=/home/ele/tools/estscan-3.0.2
    export ESTSCANLIB=/usr/local/lib64/perl5/site_perl/5.10.0/x86_64-linux-thread-multi

    export CEGMA="/home/ele/tools/cegma_v2.4.010312"
    export CEGMATMP="/home/ele/tools/cegma_v2.4.010312/tmp"
    export PERL5LIB="$PERL5LIB:$CEGMA/lib"
    
    export BLASTDB=/media/drobo/db/blastdb/
    export BLASTMAT=/home/ele/tools/blast-2.2.20/data/ 
fi