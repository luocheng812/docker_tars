#!/bin/bash


set -e

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
	cd ${PWD_DIR}
	ln -s /usr/local/resin-4.0.49 /usr/local/resin
}

install_resin
