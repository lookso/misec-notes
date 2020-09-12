#!/bin/bash
# 遍历键盘输入的数据
if [ $#  -ne 1 ]
then
echo "$0脚本参数只能有且一个"
exit 0
fi
#变量赋值不能有空格
filename=$1 
count=0
#使用while 循环读取内容，并将读取的内容存入变量line
while read line
do
    #将变量count的值加1
    let count++
    echo "$count:$line"
    if [ $count -eq 10 ];then
        exit 0
    fi
done >> $filename
echo -e "\ntotal $count lonces read"
exit 0
