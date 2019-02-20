#!/bin/bash

rm -f ${1}/results.csv

for i in ${1}/*.out; do
	solved=`cat $i | grep "information"`
	res=""
	infofile=`echo $i | sed -e "s/\.out/\.infor/g"`
	if [ ! -z "$solved" ]; then 
		res=`cat $infofile | sed -e "s/ [ ]*/;/g" | cut -d ';' -f 3-`
		echo "$i;SOLVED;${res}" >> ${1}/results.csv
	else
		echo "$i;TIMEOUT" >> ${1}/results.csv
	fi
done
