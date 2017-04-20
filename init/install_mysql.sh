#!/bin/bash


set -e 

install_mysql(){

	echo "install mysql ....."

	cd /root/res

	MachineIp=$(ip addr | grep inet | grep eth0 | awk '{print $2;}' | sed 's|/.*$||')
	MachineName=$(cat /etc/hosts | grep ${MachineIp} | awk '{print $1}')

	##安装mysql
	tar zxvf mysql-5.6.26.tar.gz
	cd mysql-5.6.26
	cmake . -DCMAKE_INSTALL_PREFIX=/usr/local/mysql-5.6.26 -DWITH_INNOBASE_STORAGE_ENGINE=1 -DMYSQL_USER=mysql -DDEFAULT_CHARSET=utf8 -DDEFAULT_COLLATION=utf8_general_ci
	make
	make install
	ln -s /usr/local/mysql-5.6.26 /usr/local/mysql

	cd /usr/local/mysql
	useradd mysql
	rm -rf /usr/local/mysql/data
	mkdir -p /data/mysql-data
	ln -s /data/mysql-data /usr/local/mysql/data
	chown -R mysql:mysql /data/mysql-data /usr/local/mysql/data
	cp support-files/mysql.server /etc/init.d/mysql

	perl scripts/mysql_install_db --user=mysql

	sed -i "s/192.168.2.131/${MachineIp}/g" `grep 192.168.2.131 -rl ./conf/*`
	cp /root/Tars/build/conf/my.cnf /usr/local/mysql/


	##添加mysql的bin路径
	echo "PATH=\$PATH:/usr/local/mysql/bin" >> /etc/profile
	echo "export PATH" >> /etc/profile
	source /etc/profile

	##修改mysql root密码
	cd /usr/local/mysql/
	./bin/mysqladmin -u root password 'root@appinside'
	./bin/mysqladmin -u root -h ${MachineName} password 'root@appinside'


	##添加mysql的库路径
	echo "/usr/local/mysql/lib/" >> /etc/ld.so.conf
	ldconfig

}

install_mysql




