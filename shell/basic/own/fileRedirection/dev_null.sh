#!/bin/bash
#1./dev/null
#2.标准错误重定向

#写到/dev/null的所有数据都被系统丢弃,所以我们可以将不需要的程序或者命令输出发送到/dev/null
#重定向命令的标准输出信息到/dev/null
#格式: command > /dev/null

#重定向命令的标准错误信息到/dev/null
#格式: command 2> /dev/null

#同时重定向命令的标准错误信息和标准输出信息到/dev/null
#格式: command &> /dev/null
#或:   command 2> /dev/null 2>&1
echo "123" > /dev/null

#标准错误重定向 2>
# 将错误信息保存到kk文件中了
find / -name "kkkk" 2>kk

#标准输入重定向>
将uname -a的信息写入到文件hostinfo文件中
uname -a >hotsinfo

