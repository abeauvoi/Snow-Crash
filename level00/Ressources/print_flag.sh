#!/bin/bash
# get decrypted password for flag00 user
# The tr call emulates a ROT11
cat $(find /usr -group "flag00") | tr 'A-Za-z' 'L-ZA-Kl-za-k'