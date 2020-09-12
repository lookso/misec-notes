#!/bin/bash
exec 3>&1 4>&2 1>> zhis_bash.log 2>&1
# 其含义是 复制标准输出到3 错误输出到 4 把 3 4 保存在zhis_bash.log  这个文件中
# 等同于 再写一个shell 类似
# ./zhis_bash.sh >>zhis_bash.log   2>&1  

# exec与system的区别
# (1) exec是直接用新的进程去代替原来的程序运行，运行完毕之后不回到原先的程序中去。
# (2) system是调用shell执行你的命令，system=fork+exec+waitpid,执行完毕之后，回到原先的程序中去。继续执行下面的部分。
# 总之，如果你用exec调用，首先应该fork一个新的进程，然后exec. 而system不需要你fork新进程，已经封装好了。
