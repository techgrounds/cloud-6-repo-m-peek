#!/bin/bash

var=$(( ( $RANDOM %10 ) +1 ))
echo $var >> randomnumber.txt