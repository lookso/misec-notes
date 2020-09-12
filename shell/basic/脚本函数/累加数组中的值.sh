#!/bin/bash

#adding values in the array

function addarray {
	local sum=0
	local newarray
	newarray=(`echo "$@"`)
	for value in ${newarray[*]}
	do
		sum=$[ $sum + $value ]
	done
	echo $sum
}

myarray=(1 2 3 4 5)
echo "The original array is : ${myarray[*]}"
arg1=`echo ${myarray[*]}`
result=`addarray $arg1`
echo "The result is $result"

echo "------数组-------------"
my_array=(A B "C" D)
echo ${my_array[*]}

#数组转换为字符串
str=${my_array[@]}

len=${#my_array[*]}
echo "数组长度$len"
echo "字符串:"$str;
# 增加元素
my_array[${#my_array[*]}]=test

echo '------------'
echo ${my_array[1]}
#取所有元素
echo ${my_array[@]:0}
#取1-2之间的元素,从0算起
echo ${my_array[@]:1:2}
echo '----------------'
# 遍历数组
for a in ${my_array[*]}
do
 	echo $a
done
