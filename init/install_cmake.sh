#!/bin/bash


set -e

install_cmake(){

	echo "install cmake ...."

	##安装cmake
	cd /root/res

	tar zxvf cmake-2.8.8.tar.gz
	cd cmake-2.8.8
	./bootstrap
	make
	make install

}


install_cmake

