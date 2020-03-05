#!/usr/bin/python
import sys

def	rot_reverse(input):
	for i in range(len(input)):
		sys.stdout.write(chr(ord(input[i]) - i))
	sys.stdout.write('\n')
rot_reverse(sys.argv[1])
sys.stdout.flush()
