#!/bin/bash
# multi transfer the video format

input_format=$1
output_format=$2
files=`ls | grep $input_format | awk -F. '{for(i=1;i<=NF-1;i++){if(i==1){res=$1}else{res=res"."$i;}}print res;}'| awk '{for(i=1;i<=NF;i++){if(i==1){res=$1}else{res=res"\ "$i;}}print res;}'`

old_IFS=$IFS
IFS=$'\t\n'

for i in $files
do
 input_file=$i.$input_format
 output_file=`echo $i | awk '{for(i=1;i<=NF;i++){res=res$i;}print res;}'`.$output_format
 ffmpeg -i $input_file -y $output_file
done
