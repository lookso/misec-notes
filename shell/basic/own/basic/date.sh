#!/bin/bash
# 选项:
# -d<字符串>：显示字符串所指的日期与时间。字符串前后必须加上双引号； 
# -s<字符串>：根据字符串来设置日期与时间。字符串前后必须加上双引号；

#参数
#%H 小时，24小时制（00~23） 
#%I 小时，12小时制（01~12） 
#%k 小时，24小时制（0~23） 
#%l 小时，12小时制（1~12） 
#%M 分钟（00~59） 
#%p 显示出AM或PM 
#%r 显示时间，12小时制（hh:mm:ss %p） 
#%s 从1970年1月1日00:00:00到目前经历的秒数 
#%S 显示秒（00~59） %T 显示时间，24小时制（hh:mm:ss） 
#%X 显示时间的格式（%H:%M:%S） %Z 显示时区，日期域（CST） 
#%a 星期的简称（Sun~Sat） 
#%A 星期的全称（Sunday~Saturday） 
#%h,%b 月的简称（Jan~Dec） 
#%B 月的全称（January~December） 
#%c 日期和时间（Tue Nov 20 14:12:58 2012） 
#%d 一个月的第几天（01~31） %x,%D 日期（mm/dd/yy） 
#%j 一年的第几天（001~366） %m 月份（01~12） 
#%w 一个星期的第几天（0代表星期天） 
#%W 一年的第几个星期（00~53，星期一为第一天） 
#%y 年的最后两个数字（1999则是99）

# 171129
echo `date +%y%m%d`

# 今天:2017-11-29
echo `date +%Y-%m-%d %H %M %S`

# 昨天2017-11-28
date -d "1 day ago" +"%Y-%m-%d"
# 年月日 时分秒
# 2017-11-29 10:33:42
date +"%Y-%m-%d %H:%M:%S"

# 昨天20171128
date -d "-1 day" +%Y%m%d

# 前天20171130
date -d "+1 day" +%Y%m%d

# 上一个月的日期
date -d "+1 month" +%Y%m%d 

# 当前时间时间戳
date +%s

# 将时间戳转换为格式化日期
date -d @1511923405 "+%Y-%m-%d"

start=$(date +%s) 
nmap man.linuxde.net &> /dev/null 
date -d "+1 day" +"%Y%m%d"
end=$(date +%s) 
difference=$(( end - start )) 
echo $difference seconds.

