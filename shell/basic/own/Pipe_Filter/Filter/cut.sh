#!/bin/bash
#/etc/passwd记录账号信息,每一行记录一个账号信息,每个字段之间使用:分隔,第一个字段是账户名,而第6个就是账号的主目录路径
grep "/bin/bash" /etc/passwd | cut -d: -f1,6
