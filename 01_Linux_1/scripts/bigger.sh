#!/bin/bash

var=$(( ( random %10 ) +1 ))
if [[ $var > 5]]; then
   echo "$var" >> bigger.txt
elif [[ $var < 6]]; then
    echo 'it is smaller' >> bigger.txt 
else 
    echo 'something went wrong' >> bigger.txt
fi 
