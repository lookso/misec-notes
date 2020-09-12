#!/bin/bash  
#循环条件可以改写为while[[ "$#" -ne 0 ]]，等于0时退出while循环
sum=0  
i=1  
while(( i <= 100 ))  
do  
    let "sum+=i"  
    let "i += 2"     
done  
echo "sum=$sum"
