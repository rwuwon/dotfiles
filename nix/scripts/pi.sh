#!/bin/bash

# https://www.johndcook.com/blog/2019/10/29/computing-pi-with-bc/

digits=2000

echo 'time bc -l <<< "scale='$digits';4*a(1)"'
time bc -l <<< "scale=$digits;4*a(1)"

# John Machin:
echo 'time bc -l <<< "scale='$digits';16*a(1/5) - 4*a(1/239)"'
time bc -l <<< "scale=$digits;16*a(1/5) - 4*a(1/239)"
