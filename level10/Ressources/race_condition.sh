#!/bin/bash
while true;
do
	rm -f /var/crash/fake
	touch /var/crash/fake
	rm -f /var/crash/fake
	ln -s ~/token /var/crash/fake
done
