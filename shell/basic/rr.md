```
过滤器
1.如果一个linux命令是从标准输入接受他的输入数据,并且标准输出上产生它的输出数据(结果),那么这个命令就被称为过滤器
过滤器一般和管道使用
常见过滤器:
awk/cut/grep/tar/head/paste/sed/sort/split/strings/tac/tail/tee/tr/uniq/wc

awk:
2.使用awk列出当前账号最常用的10个命令
history|awk '{print $2}' | sort | uniq -c | sort -rn | head -10
1776 git
1142 cd
608 sudo
602 vim
443 rm
374 ls
307 mv
293 awk
284 svn
229 cat
history命令将输出通过管道发送到awk命令,awk命令默认使用空格作为分隔符,将history的输出分为两列,并把第二列内容作为输出通过管道
发送到sort命令,使用sort命令排序之后,再讲输出通过管道发送到uniq命令，使用uniq命令统计历史命令重复出现的次数,在用sort命令将uniq命令的输出按照重复
次数从高到低排序,最后使用head命令默认列出前10个信息

3.显示当前系统的总内存大小,单位是kb
free |grep Mem|awk '{print $2}'
[shell]# free|grep Mem
Mem:        500472     465608      34864          0      10600      73724
[root@iZ257v6fpmnZ shell]# free|grep Mem|awk '{print $1 $2}'
Mem:500472

cut:
cut命令被用于文本处理,可以使用这个命令来提取文件中指定列的内容
/etc/passwd记录账号信息,每一行记录一个账号信息,每个字段之间使用:分隔,第一个字段是账户名,而第6个就是账号的主目录路径
[root@iZ257v6fpmnZ shell]# grep "/bin/bash" /etc/passwd
root:x:0:0:root:/root:/bin/bash
mysql:x:500:500::/home/mysql:/bin/bash
www:x:501:501::/home/www:/bin/bash
git:x:502:502::/home/git:/bin/bash

[root@iZ257v6fpmnZ shell]# grep "/bin/bash" /etc/passwd | cut -d: -f1,6
root:/root
mysql:/home/mysql
www:/home/www
git:/home/git
# 当前目录下包含的子目录数,看清楚是子目录

[root@iZ257v6fpmnZ shell]# ls -l|cut -c 1|grep d |wc -l
    3

ls -l 输出的内容中,每行的第一个字符表示文件的类型，如果是d表示的是目录
cut -c 1 是截取每行的第一个字符
grep d 来获取文件类型是目录的行

awk和sed的使用
http://man.linuxde.net/awk
http://man.linuxde.net/sed
```

```
awk:
# 以:分隔,打印第一列数据
echo "------------------------------"
awk -F: '{print $1}' /etc/passwd|sort
free |grep Mem|awk '{print $2}'
echo "-----------awk教程------------"
#awk 'BEGIN{ print "start" } pattern{ commands } END{ print "end" }' file

一个awk脚本通常由：BEGIN语句块、能够使用模式匹配的通用语句块、END语句块3部分组成，这三个部分是可选的。
任意一个部分都可以不出现在脚本中，脚本通常是被单引号或双引号中，
例如： 
awk 'BEGIN{ i=0 } { i++ } END{ print i }' filename 
awk "BEGIN{ i=0 } { i++ } END{ print i }" filename 

awk的工作原理 
awk 'BEGIN{ commands } pattern{ commands } END{ commands }' 
第一步：执行BEGIN{ commands }语句块中的语句； 
第二步：从文件或标准输入(stdin)读取一行，然后执行pattern{ commands }语句块，它逐行扫描文件，从第一行到最后一行重复这个过程，直到文件全部被读取完毕。 
第三步：当读至输入流末尾时，执行END{ commands }语句块。 

BEGIN语句块在awk开始从输入流中读取行之前被执行,这是一个可选的语句块，比如变量初始化、打印输出表格的表头等语句通常可以写在BEGIN语句块中。 
END语句块在awk从输入流中读取完所有的行之后即被执行，比如打印所有行的分析结果这类信息汇总都是在END语句块中完成，它也是一个可选语句块。 
pattern语句块中的通用命令是最重要的部分，它也是可选的。如果没有提供pattern语句块，则默认执行{ print }，即打印每一个读取到的行，awk读取的每一行都会执行该语句块。

echo -e "A line 1\nA line 2" | awk 'BEGIN{ print "Start" } { print } END{ print "End" }'
Start 
A line 1 
A line 2 
End
当使用不带参数的print时，它就打印当前行，当print的参数是以逗号进行分隔时，打印时则以空格作为定界符。
在awk的print语句块中双引号是被当作拼接符使用，
例如： 
echo | awk '{ var1="v1"; var2="v2"; var3="v3"; print var1,var2,var3; }' 
v1 v2 v3
双引号拼接:
echo | awk '{ var1="v1"; var2="v2"; var3="v3"; print var1"="var2"="var3; }'
v1=v2=v3
echo | awk  'BEGIN{ var1="v1"; var2="v2"; var3="v3";}END{ print var1,var2,var3; }'
v1 v2 v3
echo | awk  'BEGIN{ var1="v1"; var2="v2"; var3="v3";}{print "我也是一行"}END{ print var1,var2,var3; }'
我也是一行
v1 v2 v3
内置变量:
[A][N][P][G]表示第一个支持变量的工具，[A]=awk、[N]=nawk、[P]=POSIXawk、[G]=gawk
$n 当前记录的第n个字段，比如n为1表示第一个字段，n为2表示第二个字段。 
$0 这个变量包含执行过程中当前行的文本内容。 
[A] FILENAME 当前输入文件的名。
[A] FS 字段分隔符（默认是任何空格）。
[A] NF 表示字段数，在执行过程中对应于当前的字段数。 
[A] NR 表示记录数，在执行过程中对应于当前的行号。 
[A] OFMT 数字的输出格式（默认值是%.6g）。 
[A] OFS 输出字段分隔符（默认值是一个空格）。 
[A] ORS 输出记录分隔符（默认值是一个换行符）。 
[A] RS 记录分隔符（默认是一个换行符）。 

[N] ARGC 命令行参数的数目。 
[N] ERRNO 最后一个系统错误的描述。
[N] ARGV 包含命令行参数的数组。 
[N] RSTART 由match函数所匹配的字符串的第一个位置。 
[N] RLENGTH 由match函数所匹配的字符串的长度。 
[N] SUBSEP 数组下标分隔符（默认值是34）。

[G] ARGIND 命令行中当前文件的位置（从0开始算）。 
[G] CONVFMT 数字转换格式（默认值为%.6g）。 
[G] FIELDWIDTHS 字段宽度列表（用空格键分隔）。 
[G] IGNORECASE 如果为真，则进行忽略大小写的匹配。 

[P] ENVIRON 环境变量关联数组。
[P] FNR 同NR，但相对于当前文件。

使用print $NF可以打印出一行中的最后一个字段，使用$(NF-1)则是打印倒数第二个字段，其他以此类推： 
echo -e "line1 f2 f3\n line2 f4 f5" | awk '{print $NF}'
f3
f5
echo -e "line1 f2 f3\n line2 f4 f5" | awk '{print $(NF-1)}'
f2
f4
打印每一行的第2个和第3个字段
echo -e "neteasy sina sohu\nbaidu alibaba tencens"|awk '{print $2,$3}'
sina sohu
alibaba tencens
统计文件的行数
echo -e "neteasy sina sohu\nbaidu alibaba tencens"|awk  'END{ print NR }'
2
以上命令只使用了END语句块，在读入每一行的时，awk会将NR更新为对应的行号，当到达最后一行NR的值就是最后一行的行号
所以END语句块中的NR就是文件的行数。 一个每一行中第一个字段值累加的例子：
seq命令用于产生从某个数到另外一个数之间的所有整数。
用法如下:
seq [选项]... 尾数 
seq [选项]... 首数 尾数 
seq [选项]... 首数 增量 尾数
[root@iZ257v6fpmnZ shell]# seq 1 2 10
1
3
5
7
9
seq 5 | awk 'BEGIN{ sum=0; print "总和：" } { print $1"+"; sum+=$1 } END{ print "等于"; print sum }'
总和：
1+
2+
3+
4+
5+
等于
15

NR打印每行的行号
echo -e "neteasy sina sohu\nbaidu alibaba tencens\ndidi jd"|awk  '{print NR }'
1
2
3
每一行含有多少个字段 NF
echo -e "neteasy sina sohu\nbaidu alibaba tencens\ndidi jd"|awk  '{print NF }'
3
3
2

= += -= *= /= %= ^= **=	赋值语句
a+=5; 等价于：a=a+5; 其它同类
||	逻辑或 &&	逻辑与
awk 'BEGIN{a=1;b=2;print (a>5 && b<=2),(a>5 || b<=2);}' 0 1

~ ~!	匹配正则表达式和不匹配正则表达式 例： 
awk 'BEGIN{a="100testa";if(a ~ /^100*/){print "ok";}}' 
ok
< <= > >= != ==	关系运算符
awk 'BEGIN{a=11;if(a >= 9){print "ok";}}' 
ok
其他运算符:
$:字段引用 
空格:字符串连接符 
?:C条件表达式 
in:数组中是否存在某键值

awk 'BEGIN{a="b";print a=="b"?"ok":"err";}' 
ok 
awk 'BEGIN{a="b";arr[0]="b";arr[1]="c";print (a in arr);}' 
0 
awk 'BEGIN{a="b";arr[0]="b";arr["b"]="c";print (a in arr);}' 
1

读取下一条记录 
awk中next语句使用：在循环逐行匹配，如果遇到next，就会跳过当前行，直接忽略下面语句。而进行下一行匹配。net语句一般用于多行合并： 
cat text.txt 
a 
b 
c 
d 
e 
awk 'NR%2==1{next}{print NR,$0;}' text.txt 
2 b 
4 d
当记录行号除以2余1，就跳过当前行。下面的print NR,$0也不会执行。
下一行开始，程序有开始判断NR%2值。这个时候记录行号是：2 ，就会执行下面语句块：'print NR,$0'

分析发现需要将包含有“web”行进行跳过，然后需要将内容与下面行合并为一行： 
cat test.txt 
web01[192.168.2.100] 
httpd ok 
tomcat ok 
sendmail ok 
web02[192.168.2.101] 
httpd ok 
postfix ok 
web03[192.168.2.102] 
mysqld ok 
httpd ok 
0
awk '/^web/{T=$0;next;}{print T":t"$0;}' test.txt 
web01[192.168.2.100] :thttpd ok
web01[192.168.2.100] :ttomcat ok
web01[192.168.2.100] :tsendmail ok
web02[192.168.2.101] :thttpd ok
web02[192.168.2.101] :tpostfix ok
web03[192.168.2.102] :tmysqld ok
web03[192.168.2.102] :thttpd ok
web03[192.168.2.102] :t0


简单地读取一条记录
awk getline用法：输出重定向需用到getline函数。getline从标准输入、管道或者当前正在处理的文件之外的其他输入文件获得输入。
它负责从输入获得下一行的内容，并给NF,NR和FNR等内建变量赋值。
如果得到一条记录，getline函数返回1，如果到达文件的末尾就返回0，如果出现错误，例如打开文件失败，就返回-1。 

getline语法：getline var，变量var包含了特定行的内容。 
awk getline从整体上来说，用法说明： 
1>当其左右无重定向符|或<时：getline作用于当前文件，读入当前文件的第一行给其后跟的变量var或$0（无变量），应该注意到，由于awk在处理getline之前已经读入了一行，所以getline得到的返回结果是隔行的。 

2>当其左右有重定向符|或<时：getline则作用于定向输入文件，由于该文件是刚打开，并没有被awk读入一行，只是getline读入，那么getline返回的是该文件的第一行，而不是隔行。
例如:
执行linux的date命令，并通过管道输出给getline，然后再把输出赋值给自定义变量out，并打印它:
awk 'BEGIN{ "date" | getline out; print out }'
输出:2017年11月19日 星期日 15时15分07秒 CST
执行shell的date命令，并通过管道输出给getline，然后getline从管道中读取并将输入赋值给out，
split函数把变量out转化成数组mon，然后打印数组mon的第二个元素： 
awk 'BEGIN{ "date" | getline out; split(out,mon); print mon[2] }' test
输出:星期五

命令ls的输出传递给geline作为输入，循环使getline从ls的输出中读取一行，并把它打印到屏幕。这里没有输入文件，因为
BEGIN块在打开输入文件前执行，所以可以忽略输入文件。
awk 'BEGIN{ while( "ls" | getline) print }'
README.md
gawk进阶
mysql数据库
newsh
own
sed进阶
shell脚本编程进阶
初识sed和gawk
.......
awk 关闭文件
close("filename")

输出到一个文件 
awk中允许用如下方式将结果输出到一个文件： 
echo | awk '{printf("hello word!n") > "datafile"}' 
或 
echo | awk '{printf("hello word!n") >> "datafile"}'

设置字段定界符 
默认的字段定界符是空格,
可以使用-F "定界符" 明确指定一个定界符： 
awk -F: '{ print $NF }' /etc/passwd 
或 
awk 'BEGIN{ FS=":" } { print $NF }' /etc/passwd
在BEGIN语句块中则可以用OFS=“定界符”设置输出字段的定界符。

```

```
tr和sed
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

#!/bin/bash
echo front|sed 's/front/back/'
echo "---------------------------"
# 输出结果是back
#打印出文件中除了第2和第3行以外的内容
cat -n file1
#1  linux
#2  unix
#3  solaris
#4  Hp-ux
#5  windows
echo "----------------------------"
cat -n file1|sed '2,3d'
#1  linux
#4  Hp-ux
#5  windows
echo "-----------------------------"
# 显示file2文件中第2到第5行之间的内容
cat -n file2|sed -n '2,5p'

#!/bin/bash
#sed编辑器基础

#替换标记
sed 's/lazy/ht/' ./test

echo -e "next\n"

#可用的替换标记
#1.数字 表明新闻本将替换第几处模式匹配的地方
sed 's/lazy/ht/2' ./test
#2.g 表明新文件将会替换所有已有文本出现的地方
sed 's/lazy/ht/g' ./test
#3.p 表明原来行的内容要打印出来,替换后的
sed 's/lazy/ht/p' ./test
#4.w file 将替换的结果写到文件中
sed 's/lazy/ht/w test1' ./test

echo -e "next\n"

#替换字符
sed 's/\/bin\/bash/\/bin\/csh/' /etc/passwd
#或者
sed 's!/bin/bash!/bin/csh!' /etc/passwd

echo -e "next\n"

#使用地址
#1.数字方式的行寻址
sed '2s/lazy/cat/' ./test
sed '2,3s/lazy/cat/' ./test
sed '2,$s/lazy/cat/' ./test
#2.使用文本模式过滤器
sed '/tiandi/s/bash/csh/' /etc/passwd

echo -e "next\n"

#组合命令
sed '2{
s/fox/elephant/
s/dog/cat/
}' test
sed '2,${
s/fox/elephant/
s/dog/cat/
}' test

echo -e "next\n"

#删除行
sed '3d' ./test
sed '2,$d' ./test
sed '/number 1/d' ./test
#删除两个文本模式来删除某个范围的行，第一个开启删除功能，第二个关闭删除功能
sed '/1/,/3/d' ./test

echo -e "next\n"

#插入和附加文本
sed '3i\
This is an appended line.' ./test

sed '$a\
This is a new line of text.' ./test

#修改行
sed '3c\
This a changed line of text.' ./test
sed '/number 1/c\
This a changed line of text.' ./test
#替换两行文本
#sed '2,3c\
#This a changed line of text.' ./test

#转换命令，处理单个字符
#sed 'y/123/789/' ./test

echo -e "next\n"

#回顾打印
# p 打印文本行
# -n 禁止其他行，只打印包含匹配文本模式的行
sed -n '/number 3/p' ./test

#查看修改之前的行和修改之后的行
#sed -n '/3/{
#p
#s/line/test/p
#}' ./test

echo -e "next\n"

# 打印行号
sed '=' ./test

#打印指定的行和行号
#sed -n '/lazy/{
#=
#p
#}' ./test

#列出行 打印数据流中的文本和不可打印的ASCII字符，任何不可打印的字符都用它们的八进制值前加一个反斜线或标准C风格的命名法，比如用\t来代表制表符
sed -n 'l' ./test


```
