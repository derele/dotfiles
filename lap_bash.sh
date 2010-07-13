# The customization for the laptops only (at the moment called
# ele-laptop and thinkpad

# some alias' that make only sense on the laptops
alias usrout='sudo skill -KILL -u ele'
alias aus='sudo shutdown -h now'
alias unison='unison streamlined -ui text -auto'
alias skype='LD_PRELOAD=/usr/lib/libv4l/v4l1compat.so skype'

# make sure we are up to date
# but first check, that yum is not running already
if [ -z "$(ps -A | grep "yum")" ]
then  
    sudo yum -y -q upgrade &>/dev/null &
    echo -e "yum started an update in the background\n"
else 
    echo -e "yum is already keeping you up to date in the background\n"
fi

echo -e "
           ###########################################
           #  This a stable setup, now do some work  #
           ###########################################
        
        "
