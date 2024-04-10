#!/bin/sh
template=`cat <<TEMPLATE
***** NMS HOST METRO *****
Host: $HOSTALIAS - $HOSTADDRESS
State: $HOSTSTATE
Time: $LONGDATETIME
Additional Info: $HOSTOUTPUT
Source server: $HOSTNAME
TEMPLATE
`
perl /etc/icinga2/scripts/sendmessage.pl $phone "$template"