#!/bin/bash
#文件描述符
#操纵文件描述符 
#这里面又要说说描述符 shell中有12个描述符
#其中 0 代表标准输入
#1 代表标准输出
#2 错误
#其他 3-9 都是空白描述符

if [ $# -lt 1 ]
then
    echo $0;
    exit
fi
file=$1
while read -r line
do
    echo $line
    # 等待用户输入任意键
    read -p "Press any key" -n 1
    # 将while 循环的标准输入指向变量file所代表的文件
done
# 关闭文件描述符3
exec 3<&-


