# set breakpoint to first call of getuid :
b *0x804859a
# Run the executable :
r
# Override eax with the desired uid :
set $eax = 4242
# Continue execution :
c
