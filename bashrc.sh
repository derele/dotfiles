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
alias Rs="Rscript --vanilla"
alias parallel="parallel --gnu"

# enable keychain ssh passphrase memory
eval `keychain --eval --nogui -Q -q id_rsa`

### do some readline remapping
bind -f /home/ele/dotfiles/.inputrc

# enable 256 color terminal
export TERM=xterm-256color

# emacsclient
export EDITOR='emacsclient -t'
export VISUAL='emacsclient -t'

# ignore some history
export HISTIGNORE="ll:ls:exit:cd:e:rm"
export HISTCONTROL=erasedupsexport 

# give R a global history file in combi with some code in Rprofile
export R_HISTFILE=/home/ele/.Rhistory

# add /home/ele/bin to path  
export PATH=$PATH:/home/ele/bin:/home/ele/tools/R-devel/bin:/home/ele/bin/x86_64/:/home/ele/bin/x86_64-redhat-linux-gnu/

source /home/ele/dotfiles/shell_functions.sh

if [ $HOSTNAME == thinkpad ] || [ $HOSTNAME == ele-laptop ]
then
    source /home/ele/dotfiles/lap_bash.sh
else
    # some things needed on beagle for some programs
    export BROWSER=/usr/bin/w3m
    export PHRED_PARAMETER_FILE=/tools/phred/phredpar.dat
    export ESTSCANDIR=/tools/estscan-3.0.2
    export ESTSCANLIB=/usr/local/lib64/perl5/site_perl/5.10.0/x86_64-linux-thread-multi
    
    ## because ssh X-forwarding sometimes fails
##    export DISPLAY=localhost:10.0

    export CEGMA="/tools/cegma_v2.4.010312"
    export CEGMATMP="/tools/cegma_v2.4.010312/tmp"
    export ORTHOMCL="/tools/orthomclSoftware-v2.0.5"
    export DART="/tools/dart"
    export PERL5LIB="$PERL5LIB:$CEGMA/lib:$ORTHOMCL/lib/perl:$DART/perl:/home/ele/tools/tRNAscan-SE-1.3.1/:/home/ele/bin:/tools/FunDi-master"
    
    export BLASTMAT=/tools/blast-2.2.20/data/ 
    
    if [ $HOSTNAME == beagle ]
    then
        export WISECONFIGDIR=/tools/wise2.2.0/wisecfg/
        export BLASTDB=/db/blastdb/
        
    else
        export BLASTDB=/data/db/blastdb/
        export WISECONFIGDIR=/tools/wise2.2.3-rc7/wisecfg/
        export OMP_THREAD_LIMIT=20
        export OMP_NUM_THREADS=19
        export AUGUSTUS_CONFIG_PATH=/tools/augustus.2.5.5/config/
        export ZOE=/tools/snap/Zoe
        export LD_PRELOAD=/usr/lib64/openmpi/lib/libmpi.so
    fi
fi
#source /tools/qiime_software/activate.sh
