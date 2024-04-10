#!/bin/sh
template=`cat <<TEMPLATE
Service: $SERVICEDESC
State: $SERVICESTATE
Host: $HOSTALIAS
Address: $HOSTADDRESS
Info: $SERVICEOUTPUT
Time: $LONGDATETIME
TEMPLATE
`
perl /etc/icinga2/scripts/sendmessage.pl $phone "$template"