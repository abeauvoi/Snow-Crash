#!/usr/bin/python
# A test run of the binary gives :
# level09@SnowCrash:~$ ./level09 token
# tpmhr
# We can see that the first letter is unchanged, by each following letter is increasingly
# further away from the input string.
# p is 1 after o, m is 2 after k, h is 3 after e, etc.
# We figured out that we needed to pass the content of the file token to the following script
import sys

def	rot_reverse(input):
	for i in range(len(input)):
		sys.stdout.write(chr(ord(input[i]) - i))
	sys.stdout.write('\n')
rot_reverse(sys.argv[1])
sys.stdout.flush()
