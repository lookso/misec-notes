#!/bin/bash
#打印文件中可打印字符串,常用来与grep命令配合使用
strings /usr/bin/uptime | grep GLIB
# GLIBC_2.2.5
# GLIBC_2.3.4

