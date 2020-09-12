#!/bin/bash

function start(){
    #php-fpm --fpm-config /usr/local/etc/php-fpm.conf --prefix /usr/local/var 2>/dev/null &
    /usr/local/php7/sbin/php-fpm
    /usr/local/nginx/sbin/nginx
}

function stop(){
    ps -ef|grep 'php-fpm' |grep -v grep |awk '{print $2}'|xargs kill -9
    sleep 1
    ps -ef|grep 'nginx: master process'|grep -v grep |awk '{print $2}'|xargs kill
}

case "$1" in
    "start")
        start
        ;;
    "stop")
        stop
        ;;
    *)
        stop
        sleep 1
        start
        ;;
esac

