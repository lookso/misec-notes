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