#!/usr/bin/bash

#start rsyslog
rsyslogd

#start VPN
/usr/local/vpnserver/vpnserver start

tail -f /dev/null
