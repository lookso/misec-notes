#!/bin/sh

#登录mysql 自动查询
mysql -uroot -ppwd$ <<EOF
use dny8_resume;
select * from test;
exit
EOF