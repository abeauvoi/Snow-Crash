# set breakpoint to first call of getuid
b getuid
# Run the executable
r
# Skip two instructions
ni
ni
# Override eax with the desired uid
set $eax = 4242
# Continue execution
c
