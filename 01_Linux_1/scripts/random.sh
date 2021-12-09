#!/bin/bash

var=$(( ( random %10 ) +1 ))
echo $var >> randomnumber.txt