##!/bin/bash

date=`date +%Y%m`;
mysql=`which mysql`
host="127.0.0.1"
user="root"
pwd='lookfor@Dny8$'
dbname="report"
port="3306"

is_exists_table=$(mysql -u${user} -p${pwd} -P${port} -e "use $dbname;show tables"|grep -w 'ad_v_real_time_stat_'$date)

create_table_sql="CREATE TABLE ad_v_real_time_stat_$date like ad_v_real_time_stat_201607"

if [ "$is_exists_table" = "" ];then
    result=$(mysql -h${host} -P${port} -u${user} -p${pwd} ${dbname} -e "${create_table_sql}");
    if [ $?=0 ];then
        echo $is_exists_table":create ok"
    else
        echo $is_exists_table":create fail:">>/usr/local/var/www/learn/local/shell/ct.log 2>&1
    fi
else
    echo $is_exists_table":exists";
    exit;
fi