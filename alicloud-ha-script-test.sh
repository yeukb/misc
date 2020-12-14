#!/bin/bash

if [ $# -ne 5 ]
then
  exit 1
fi

FW1TRUSTIP=$1
FW2TRUSTIP=$2
FW1TRUSTENI=$3
FW2TRUSTENI=$4
RouteTableId=$5

echo "FW1TRUSTIP=$FW1TRUSTIP" > results.txt
echo "FW2TRUSTIP=$FW2TRUSTIP" >> results.txt
echo "FW1TRUSTENI=$FW1TRUSTENI" >> results.txt
echo "FW2TRUSTENI=$FW2TRUSTENI" >> results.txt
echo "FW2TRUSTENI=$FW2TRUSTENI" >> results.txt
