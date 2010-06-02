# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi



# User specific aliases and functions

alias e='emacsclient -t'
alias se='sudo emacs -nw'
alias s='screen'
alias ll='ls -lh'

PATH=$PATH:/home/ele/tools/phred-dist-020425.c-acd:/home/ele/tools/Newbler2.3/packages/newbler_CLI_x86_64_2.3/:/home/ele/tools/annot8r_1.1.1:/home/ele/tools/PartiGene_v3.0.3:/home/ele/tools/rename_file:/home/ele/tools/taxman_1.1:/home/ele/tools/trace2dbest_v3.0.1:/home/ele/tools/trace2seq_pl:/home/ele/tools/blast-2.2.20/bin:/home/ele/own_perl_scripts:/home/ele/mpich2-install/bin:/home/ele/own_perl/genepool_scripts/perl:/usr/local/pgsql/bin:/home/ele/tools/tgicl_linux:/home/ele/tools/seqclean:/home/ele/tools/seqclean/bin:/home/ele/tools/matzlab_scripts/:/home/ele/tools/UnifiedRelease/bin:/home/ele/tools/src:/home/ele/tools/est2assembly/est2assembly:/home/ele/tools/RepeatMasker


export PHRED_PARAMETER_FILE=/home/ele/tools/phred-dist-020425.c-acd/phredpar.dat
export ESTSCANDIR=/home/ele/tools/estscan-3.0.2
export ESTSCANLIB=/usr/local/lib64/perl5/site_perl/5.10.0/x86_64-linux-thread-multi

eval `keychain --eval --nogui -Q -q id_rsa`
# magic string for screen to know the command that is launched 
## export PS1='\[\033k\033\\\]\u@\h:\w\$ '

#enable 256 color terminal                                                      
export TERM=xterm-256color

