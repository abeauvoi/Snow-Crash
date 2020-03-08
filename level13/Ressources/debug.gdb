# set breakpoint to first call to getuid
s getuid
# Run the executable
r
# Skip two instructions
ni
ni
# Override eax
set $eax = 4242
# Continue execution
c
