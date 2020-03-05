#!/bin/bash
# get encrypted password for flag01 user
cat /etc/passwd | grep flag01 | cut -d: -f 2

# Then use a password cracker to get the decyphered password
# We used john_the_ripper on Kali Linux
