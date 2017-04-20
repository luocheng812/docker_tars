#!/bin/bash

set -e

build_web_mgr(){

	echo "build web manager ...."

	MachineIp=$(ip addr | grep inet | grep eth0 | awk '{print $2;}' | sed 's|/.*$||')
	MachineName=$(cat /etc/hosts | grep ${MachineIp} | awk '{print $1}')

	##安装web管理系统
	cd /root/Tars/web/

	sed -i "s/db.tars.com/${MachineIp}/g" `grep db.tars.com -rl ./src/main/resources/*`
	sed -i "s/registry1.tars.com/${MachineIp}/g" `grep registry1.tars.com -rl ./src/main/resources/*`
	sed -i "s/registry2.tars.com/${MachineIp}/g" `grep registry2.tars.com -rl ./src/main/resources/*`

	mvn clean package
	cp ./target/tars.war /usr/local/resin/webapps/

	mkdir -p /data/log/tars/
	cp /root/Tars/build/conf/resin.xml /usr/local/resin/conf/

}


build_web_mgr
