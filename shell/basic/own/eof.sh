#!/bin/sh

#登录mysql 自动查询
#Shell中通常将EOF与 << 结合使用,表示后续的输入作为子命令或子Shell的输入,直到遇到EOF为止,再返回到主调Shell。如下
username=root
pwd=xxx
mysql -u$username -p$pwd <<EOF
use dny8_resume;
select * from test;
exit
EOF