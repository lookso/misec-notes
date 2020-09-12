#!/bin/bash
# 获取操作系统登录在线用户数
uptime | sed 's/user.*$//' | gawk '{print $NF}'
