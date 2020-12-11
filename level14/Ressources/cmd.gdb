# Create catchpoint that will set $eax to 0, then resume execution :
catch syscall ptrace
commands 1
set ($eax) = 0
continue
end
# Set a breakpoint on the instruction which stores the return value of getuid()
# in a variable :
b *0x8048b02
# Run the program
r
# Once the breakpoint is reached, set getuid()'s return value to the uid of
# flag14 :
set $eax = 3014
# Finally, continue execution :
c
