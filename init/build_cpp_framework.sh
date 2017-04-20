#!/bin/bash

set -e

build_cpp_framework(){

	echo "build cpp framework ...."

	MachineIp=$(ip addr | grep inet | grep eth0 | awk '{print $2;}' | sed 's|/.*$||')
	MachineName=$(cat /etc/hosts | grep ${MachineIp} | awk '{print $1}')


	##安装c++语言框架
	cd /root/Tars/cpp/build/
	chmod u+x build.sh
	./build.sh all
	./build.sh install

	##Tars数据库环境初始化
	mysql -uroot -proot@appinside -e "grant all on *.* to 'tars'@'%' identified by 'tars2015' with grant option;"
	mysql -uroot -proot@appinside -e "grant all on *.* to 'tars'@'localhost' identified by 'tars2015' with grant option;"
	mysql -uroot -proot@appinside -e "grant all on *.* to 'tars'@'${MachineName}' identified by 'tars2015' with grant option;"
	mysql -uroot -proot@appinside -e "flush privileges;"

	cd /root/Tars/cpp/framework/sql/
	sed -i "s/192.168.2.131/${MachineIp}/g" `grep 192.168.2.131 -rl ./*`
	sed -i "s/db.tars.com/${MachineIp}/g" `grep db.tars.com -rl ./*`
	chmod u+x exec-sql.sh
	./exec-sql.sh

	##打包框架基础服务
	cd /root/Tars/cpp/build/
	make framework-tar

	make tarsstat-tar
	make tarsnotify-tar
	make tarsproperty-tar
	make tarslog-tar
	make tarsquerystat-tar
	make tarsqueryproperty-tar

	##安装核心基础服务
	mkdir -p /usr/local/app/tars/
	cd /root/Tars/cpp/build/
	cp framework.tgz /usr/local/app/tars/
	cd /usr/local/app/tars
	tar xzfv framework.tgz

	sed -i "s/192.168.2.131/${MachineIp}/g" `grep 192.168.2.131 -rl ./*`
	sed -i "s/db.tars.com/${MachineIp}/g" `grep db.tars.com -rl ./*`
	sed -i "s/registry.tars.com/${MachineIp}/g" `grep registry.tars.com -rl ./*`

	chmod u+x tars_install.sh
	./tars_install.sh

	./tarspatch/util/init.sh
}

build_cpp_framework
