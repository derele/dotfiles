#!/bin/sh
# Wrapper around xulrunner/firefox to start the xulrunner application conkeror
# Written by Axel Beckert <abe@deuxchevaux.org> for the Debian Project

# Required for more recent Firefox versions, i.e. >= 48
XUL_APP_FILE=/usr/share/conkeror/application.ini
export XUL_APP_FILE

# Find an appropriate xulrunner binary
XULRUNNER=''

# *sigh* No more xulrunner since iceweasel 30
if [ -x /usr/bin/palemoon ]; then
    XULRUNNER="/usr/bin/palemoon"
elif [ -x /usr/bin/firefox ]; then
    XULRUNNER="/usr/bin/firefox"
elif [ -x /usr/bin/firefox-esr ]; then
    XULRUNNER="/usr/bin/firefox-esr"
elif [ -x /usr/bin/iceweasel ]; then
    XULRUNNER="/usr/bin/iceweasel"
fi

if [ -z "$XULRUNNER" ]; then
    echo "No Palemoon, Firefox or Iceweasel found. Bailing out." 1>&2
    exit 1;
fi

if [ "$*" = "--help" ]; then
    errormsg="`exec $XULRUNNER \"$@\" 2>&1`"
    echo "$errormsg" | sed -e "s:/[^ ]*/xulrunner-bin:$0:; /-\(width\|height\)/d" 1>&2
else
    exec $XULRUNNER "$@"
fi
