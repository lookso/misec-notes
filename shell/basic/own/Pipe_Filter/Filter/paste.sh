#!/bin/bash
#合并文件的行,可以通过管道接受其他命令的输出,并对其内容进行相应的合并处理
#每行一个字符串,将内容追加到file1文件中
echo "linux\nunix\nsolaris\nHp-ux\nwindows">file1

echo "ubuntu\ncentos\noel\nfedora\nredhat">file2
# 通过交换文件名即可指定哪一列先粘
paste file1 file2>file4

#此处切记 - 两边要有空格
cat file1|paste -d"," - file2 >file3

# paste的用法
# -d<分隔符> 指定分隔符，若未使用该参数则默认制表符分隔  
# -s 不使用平行的行目输出模式，而是每个文件占用一行  

#按冒号分隔,分隔符要加引号
paste -d":" file2 file1>file5

paste -s file1 file2>file6
cat file6
# linux   unix    solaris Hp-ux   windows
#ubuntu  centos  oel fedora  redhat

