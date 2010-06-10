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