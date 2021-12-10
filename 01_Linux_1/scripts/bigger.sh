#!/bin/bash

var=$(( ( $RANDOM %10 ) +1 ))
if [[ $var -gt 5]]; then
   echo "$var" >> bigger.txt
elif [[ $var -lt 6]]; then
    echo 'it is smaller' >> bigger.txt 
else 
    echo 'something went wrong' >> bigger.txt
fi 
