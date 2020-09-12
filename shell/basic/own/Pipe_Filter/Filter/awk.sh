#!/bin/bash
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

流程控制语句:









