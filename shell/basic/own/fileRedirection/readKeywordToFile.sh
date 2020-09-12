#!/bin/bash
#读取键盘输入到文件中
if [ $# -ne 1 ];then
    echo "Usage: $0 FILEPATH"
    exit
fi
file=$1

#定义一个代码块
{
    #读取一行内容,并将读取的内容存入到变量line1中 
    read line1
    echo $line1
    #同上说法
    read line2
    echo $line2
    # 将这个代码块的标准输入指向变量file的值所代表的文件
} > "$file.txt"

echo "line1:$line1"
echo "line2:$line2"
exit 0
