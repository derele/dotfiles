fasta_mts(){
    perl -pe 'next if ($.<=1 ); if ($_ !~ m/^>/){chomp($_)} else {print"\n"}' $1 
    echo -e "\n"
}

qual_mts(){
    perl -pe 'next if ($.<=1 ); if ($_ !~ m/^>/){chomp($_); print " "} else {print"\n"}' $1
    echo -e "\n"
}

grep_plus1(){
    grep -A 1 $1 $2 | grep -v "^\-\-" 
}

grep_file_contents_plus1(){
    cat $2 | fgrep -A 1 -f $1 | grep -v "^\-\-" 
}

# Look in a ace file for the distribution of reads
# The final grep is only needed because in a shell-function awk prints to stdout
ace_to_stem(){
    grep "^CO " $1 | awk '{print $4}'| r -e 'X <- as.integer(readLines()); stem(X)' | grep "^ "
}

dist_from_ssaha2(){
    awk -F " "  '{if ($1 ~ "Matches"){ a=$7; print c; c=0} ; if ($1 ~ "ALIGNMENT") { ++c}  }' $1
}

contig_table_from_ace(){
    perl -ne '$c =  $1 if /^CO (\S+)/; print "$c\t$1\n" if /^AF (\w+)(\|*|\.*)/' $1
}

pull_all_git_repos(){
    cd $HOME
    for i in $(find -name ".git" | awk '{print substr($0, 1, index($0, "/.git"))}')
    do 
        cd $i
        echo -e "\nupdating $i\n"
        git pull
        cd $HOME
    done
}

best_blast_hits(){
    rev $1 | uniq -f 11 | rev
}

shell_functions(){
    cat /home/ele/dotfiles/shell_functions.sh
}