#!/bin/bash
echo "---------------tr用法----------"
#echo要支持同C语言一样的\转义功能，只需要加上参数-e
echo -e "LINUX\nCENTOS\nREDHAT\nWINDOWS\nBAT360">txt1
########---------tr的用法----------------###########
cat txt1|tr '\n' '|'|tr 'BAT360' 'ibaidu'|tr 'A-Z' 'a-z'|tr -d '0-9'
echo "\n"
#tr的命令格式是tr SET1 SET2，凡是在SET1中的字符，都会被替换为SET2中相应位置上的字符，切记相同位置的
#tr 'BAT360' '1234567'<txt1  # 123456
tr 'BAT360' 'ABC'<txt1  # ABCCCC
# tr 'BAT360' '123'<txt1  # 123333

# -s 用tr压缩字符，可以压缩输入中重复的字符,把连续重复的字符以单独一个字符表示
#-d或——delete：删除所有属于第一字符集的字符；
echo thank     you!     are you     ok?|tr -s ''''  # thank you! are you ok?
echo "thissss is a text linnnnnnne" | tr -s ' sn'  # this is a text line

########---------------sed用法----------###############
echo "---------------sed用法----------";
echo -e "neteasy\nsina\nalibab\ntencent\nbaidu">txt2
# 删除某行
echo "---------删除第一行-----------"
sed '1d' txt2  # 删除第一行
echo "---------删除最后一行----------"
sed '$d' txt2 # 删除最后一行
echo "--------删除第1行到第2行--------"
sed '1,2d' txt2 # 删除第1行到第2行
echo "删除含有ali的行"
sed '/ali/'d txt2
echo "\n"
# 显示某行
echo "显示第一行"
sed -n '1p' txt2
echo "显示最后一行"
sed -n '$p' txt2
echo "显示第2行到最后一行"
sed -n '2,$p' txt2
#模糊查询
echo "查询包括关键字b所在所有行"
sed -n '/b/p' txt2
echo "使用反斜线\屏蔽特殊含义"
sed -n '/\b/p' txt2
echo "增加一行或者多行"
echo "第一行后增加字符串"moji""
sed '1a moji' txt2
echo "第一行到第三行后面各都一行 drink tea"
sed '1,3a drink tea' txt2
echo "第1行后面使用\n增加多行"
sed '1a drink tea\nor coffee' txt2

echo "字符串替换"
sed '1c hello' txt2
