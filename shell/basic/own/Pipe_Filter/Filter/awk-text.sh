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
echo -e "neteasy\nsina\nalibab\ntencent\nbaidu\n\ndidi">txt2
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
echo "删除空白行"
sed '/^$/d' txt2
echo "删除所有ali开头的"
sed '/^ali/d' txt2

# 显示某行
echo "显示第一行"
sed -n '1p' txt2
echo "显示最后一行"
sed -n '$p' txt2
echo "显示第2行到最后一行"
sed -n '2,$p' txt2
#模糊查询
echo "查询包括关键字b所在所有行"
ed -n '/b/p' txt2
echo "使用反斜线\屏蔽特殊含义"
sed -n '/\b/p' txt2


echo "增加一行或者多行"
echo "第一行后增加字符串"moji""
sed '1a moji' txt2
echo "第一行到第三行后面各都一行 drink tea"
sed '1,3a drink tea' txt2
echo "第1行后面使用\n增加多行"
sed '1a drink tea\nor coffee' txt2
echo "第一行到第2行后面各都一行内容:moji"
sed '1,2i moji' txt2

echo  "s命令替换"
echo "字符串替换"
echo "第一行低缓为hello"

sed '1c hello' txt2
echo "第1到第2行都替换为hello"
sed '1,2c hello' txt2
echo "my name is jack,my book">>txt2
echo "didi替换为momo"
"-n和p一起用是表示只打印出替换的行"
sed -n 's/didi/momo/p' txt2
# g表示全文所有的行匹配的都替换
sed 's/b/bb/g' txt2

#-e选项允许在同一行里执行多条命令
sed -e '1d' -e 's/sina/weibo/' txt2

# ^$是正则表达式，^是以匹配开头，$是匹配结尾，所以^$是匹配一个空行
echo "删除空白行"
sed '/^$/d' txt2
cat txt2 |tr -s '\n'
cat txt2 |awk '{if($0!="")print}'
cat txt2 |awk '{if(length !=0) print $0}'
grep -v "^$" txt2


echo "统计空白行数"
sed -n '/^$/p' txt2 |wc -l
grep '^$' txt2 | wc -l
echo "统计去除空行后的文件行数"
grep -v ^$ txt2 |wc -l
cat txt2 |tr -s '\n'|wc -l
sed '/^$/d' txt2|wc -l

#1> ^ 匹配行开始，如：/^sed/匹配所有以sed开头的行。 $ 匹配行结束，如：/sed$/匹配所有以sed结尾的行。
#2> . 匹配一个非换行符的任意字符，如：/s.d/匹配s后接一个任意字符，最后是d。
#3> * 匹配0个或多个字符，如：/*sed/匹配所有模板是一个或多个空格后紧跟sed的行。
#4> [] 匹配一个指定范围内的字符，如/[ss]ed/匹配sed和Sed。
#5> [^] 匹配一个不在指定范围内的字符，如：/[^A-RT-Z]ed/匹配不包含A-R和T-Z的一个字母开头，紧跟ed的行。
#6> \(..\) 匹配子串，保存匹配的字符，如s/\(love\)able/\1rs，loveable被替换成lovers。
#7> & 保存搜索字符用来替换其他字符，如s/love/**&**/，love这成**love**。
#8> \< 匹配单词的开始，如:/\ 匹配单词的结束，如/love\>/匹配包含以love结尾的单词的行。
#9> x\{m\} 重复字符x，m次，如：/0\{5\}/匹配包含5个0的行。
#10>x\{m,\} 重复字符x，至少m次，如：/0\{5,\}/匹配至少有5个0的行。
#11>x\{m,n\} 重复字符x，至少m次，不多于n次，如：/0\{5,10\}/匹配5~10个0的行。
#

