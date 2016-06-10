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
##eval `keychain --eval --nogui -Q -q id_rsa`

## disable XON/XOFF so that C-s can search history forward
stty -ixon

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

if [ $HOSTNAME == thinkpad ] || [ $HOSTNAME == ele-laptop ]  || [ $HOSTNAME == Heitlingernb-1 ]
then
    source /home/ele/dotfiles/lap_bash.sh
else
    # some things needed on beagle for some programs
    export BROWSER=/usr/bin/w3m
    export PHRED_PARAMETER_FILE=/tools/phred/phredpar.dat
    export ESTSCANDIR=/tools/estscan-3.0.2
    export ESTSCANLIB=/usr/local/lib64/perl5/site_perl/5.10.0/x86_64-linux-thread-multi
    
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
##        export LD_PRELOAD=/usr/lib64/openmpi/lib/libmpi.so
    fi
fi

PERL_MB_OPT="--install_base \"/home/ele/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/ele/perl5"; export PERL_MM_OPT;
PERL5LIB=/tools/vcftools_0.1.12b/lib/perl5/site_perl/:$PERL5LIB; export PERL5LIB; 

#source /tools/qiime_software/activate.sh

## debian defaults from here
# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi



