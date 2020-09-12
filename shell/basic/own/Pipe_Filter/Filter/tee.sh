#!/bin/bash
# 将结果输出到多个文件中
echo "123" |tee file7 file8

#输出标准输出和标准错误，同时保存到文件logfile
#方法一： <command> 2>&1 | tee <logfile>

# 想既在终端输出,又把信息保存到文本中
ls | tee ls_tee.txt

# 加上参数 -a
#如果想保留目标文件原有的内容，可以使用 -a 参数，附加至给出的文件，而不是覆盖它。
# 这样既可以保存上一步ls的输出又可以追加pwd的输出信息
pwd | tee -a ls_tee.txt

# -a: 向文件中重定向时使用追加模式
# -i: 忽略终端信号（Interrupt）
