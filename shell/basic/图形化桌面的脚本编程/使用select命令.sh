#!/bin/bash
# using select in the menu

#function diskspace {
#	clear
#	df -k
#}
#
#function whoseon {
#	clear
#	who
#}
#
#function menusage {
#	clear
#	cat /proc/meminfo
#}
#
#PS3="Enter option:"
#select option in "Display disk space" "Display logged on users" "Display memory usage" "Exit program"
#do
#	case $option in
#	"Exit program")
#		break;;
#	"Display disk space")
#		diskspace;;
#	"Display logged on users")
#		whoseon;;
#	"Display memory usage")
#		menusage;;
#	*)
#		clear
#		echo "Sorry, wrong selection";;
#	esac
#done
#clear

PS3="Enter option:"
select option in "henan" "anhui" "hubei"
do
	case $option in
	"henan")
		echo "hello,henan"
		break;;
	"anhui")
		echo "hello anhui"
		break;;
	"hubei")
		echo "hello hubei"
		break;;
	esac
done
#TenluMacBook-Air::shell ‹master*› » sh select.sh
#1) henan
#2) anhui
#3) hubei
#Enter option:1
#hello,henan


