#!/bin/bash

# using the return command in a function

#1、终止一个函数. 
#2、return命令允许带一个整型参数, 这个整数将作为函数的"退出状态
#码"返回给调用这个函数的脚本, 并且这个整数也被赋值给变量$?.

function db1 {
	read -p "Enter a value:" value
	echo "doubling the value"
	return $[ $value * 2 ]
}

db1
echo "The new value is $?"


# 其他使用方法
#function db1 {
#    read -p "Enter a value:" value
#    cho   $[ $value * 2 ]
#}

#db1=$(db1)
#echo "函数返回值:"$db1
