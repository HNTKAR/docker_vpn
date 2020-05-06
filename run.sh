#!/usr/bin/bash

#start rsyslog
rsyslogd

#start VPN
/usr/local/openvpn_as/scripts/openvpnas --logfile=/var/log/openvpnas.log --pidfile=/run/openvpnas.pid

tail -f /dev/null
