# The customization for the laptops only (at the moment called
# ele-laptop and thinkpad

# some alias' that make only sense on the laptops
alias usrout='sudo skill -KILL -u ele'
alias aus='shutdown -h now'
alias unison='unison streamlined -ui text -auto'
alias skype='LD_PRELOAD=/usr/lib/libv4l/v4l1compat.so skype'

alias openvpn='sudo openvpn --config Dropbox/vpn/hu-berlin.ovpn'

proxy_NO () {
    gsettings set org.gnome.system.proxy mode 'none'
    unset http_proxy
}

proxy_izw () {
    gsettings set org.gnome.system.proxy.http host '192.168.2.2'
    gsettings set org.gnome.system.proxy.http port '3128'
    gsettings set org.gnome.system.proxy mode 'manual'
    export http_proxy=http://192.168.2.2:3128
}

export PATH=$PATH:/home/ele/tools/Zotero_linux-x86_64/

## fool java into thinking we have another wm needed because of  java but 
wmname LG3D

# make sure we are up to date
# but first check, that yum is not running already
# if [ -z "$(ps -A | grep "yum")" -a $HOSTNAME != hoernchen-desk ]
# then  
#     sudo yum -y -q upgrade &>/dev/null &
#     echo -e "yum started an update in the background\n"
# fi

# echo -e "
           ###############################################
            # I am "$HOSTNAME" just a stupid client machine 
            #   This a stable setup, now do some work  
           ###############################################
        
#        "
