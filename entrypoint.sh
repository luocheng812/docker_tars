
#!/bin/bash

if [ -d /root/init ];then
	
	for x in $(ls /root/init)
	do
		if [ -f /root/init/$x ];then
			chmod u+x /root/init/$x
			/bin/bash /root/init/$x
			rm -rf /root/init/$x
		fi
	done
fi


case ${1} in
	init)
		;;
	start)
		source /etc/profile

		export LANG="zh_CN.UTF-8"
		#时间戳
	    cp -rf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo 'Asia/Shanghai' >/etc/timezone

		/etc/init.d/mysql restart
		exec /usr/local/resin/bin/resin.sh start
		;;
	*)
		exec "$@"
		;;
esac


