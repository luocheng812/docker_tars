#!/bin/bash




install_mysql(){

	echo "install mysql ....."

	cd /usr/local/mysql
	useradd mysql
	rm -rf /usr/local/mysql/data
	mkdir -p /data/mysql-data
	ln -s /data/mysql-data /usr/local/mysql/data
	chown -R mysql:mysql /data/mysql-data /usr/local/mysql/data
	cp support-files/mysql.server /etc/init.d/mysql

	perl scripts/mysql_install_db --user=mysql

	sed -i "s/192.168.2.131/${MachineIp}/g" /root/Tars/build/conf/my.cnf
	echo "chkconfig --list mysqld" > /root/Tars/build/conf/my.cnf
	cp /root/Tars/build/conf/my.cnf /etc/my.cnf


	/etc/init.d/mysql start


	##修改mysql root密码
	cd /usr/local/mysql/
	./bin/mysqladmin -u root password 'root@appinside'
#	./bin/mysqladmin -u root -h ${MachineName} password 'root@appinside'


	##添加mysql的库路径
	echo "/usr/local/mysql/lib/" >> /etc/ld.so.conf
	ldconfig

}


install_resin(){

	echo "install resin ...."

	cd /root/res

	##安装resin
	cp resin-4.0.49.tar.gz /usr/local/
	cd /usr/local/
	tar zxvf resin-4.0.49.tar.gz
	cd resin-4.0.49
	./configure --prefix=/usr/local/resin-4.0.49
	make
	make install
	ln -s /usr/local/resin-4.0.49 /usr/local/resin
}


build_java_framework(){
	##安装java语言框架
	cd /root/Tars/java
	mvn clean install
	mvn clean install -f /root/Tars/java/core/client.pom.xml 
	mvn clean install -f /root/Tars/java/core/server.pom.xml
}

build_cpp_framework(){

	echo "build cpp framework ...."

	##安装c++语言框架
	cd /root/Tars/cpp/build/
	chmod u+x /root/Tars/cpp/build/build.sh
	/root/Tars/cpp/build/build.sh all
	/root/Tars/cpp/build/build.sh install

	##Tars数据库环境初始化
	mysql -uroot -proot@appinside -e "grant all on *.* to 'tars'@'%' identified by 'tars2015' with grant option;"
	mysql -uroot -proot@appinside -e "grant all on *.* to 'tars'@'localhost' identified by 'tars2015' with grant option;"
	mysql -uroot -proot@appinside -e "grant all on *.* to 'tars'@'${MachineName}' identified by 'tars2015' with grant option;"
	mysql -uroot -proot@appinside -e "flush privileges;"

	cd /root/Tars/cpp/framework/sql/
	sed -i "s/192.168.2.131/${MachineIp}/g" `grep 192.168.2.131 -rl /root/Tars/cpp/framework/sql/*`
	sed -i "s/db.tars.com/${MachineIp}/g" `grep db.tars.com -rl /root/Tars/cpp/framework/sql/*`
	chmod u+x /root/Tars/cpp/framework/sql/exec-sql.sh
	/root/Tars/cpp/framework/sql/exec-sql.sh

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
	cp /root/Tars/cpp/build/framework.tgz /usr/local/app/tars/
	cd /usr/local/app/tars
	tar xzfv framework.tgz

	sed -i "s/192.168.2.131/${MachineIp}/g" `grep 192.168.2.131 -rl /usr/local/app/tars/*`
	sed -i "s/db.tars.com/${MachineIp}/g" `grep db.tars.com -rl /usr/local/app/tars/*`
	sed -i "s/registry.tars.com/${MachineIp}/g" `grep registry.tars.com -rl /usr/local/app/tars/*`

	chmod u+x /usr/local/app/tars/tars_install.sh
	/usr/local/app/tars/tars_install.sh

	/usr/local/app/tars/tarspatch/util/init.sh
}



build_web_mgr(){

	echo "build web manager ...."

	##安装web管理系统
	cd /root/Tars/web/

	sed -i "s/db.tars.com/${MachineIp}/g" `grep db.tars.com -rl /root/Tars/web/src/main/resources/*`
	sed -i "s/registry1.tars.com/${MachineIp}/g" `grep registry1.tars.com -rl /root/Tars/web/src/main/resources/*`
	sed -i "s/registry2.tars.com/${MachineIp}/g" `grep registry2.tars.com -rl /root/Tars/web/src/main/resources/*`

	#mvn -X clean install

	mvn clean package

	cp /root/Tars/web/target/tars.war /usr/local/resin/webapps/

	mkdir -p /data/log/tars/
	cp /root/Tars/build/conf/resin.xml /usr/local/resin/conf/

}


ResourceDir=/root/res
MachineIp=$(ip addr | grep inet | grep eth0 | awk '{print $2;}' | sed 's|/.*$||')
MachineName=$(cat /etc/hosts | grep ${MachineIp} | awk '{print $1}')


install_resin

build_java_framework
build_cpp_framework

build_web_mgr

