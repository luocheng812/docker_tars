#!/bin/bash

set -e

install_maven(){

	echo "install maven"

	cd /root/res

	##安装maven
	tar zxvf apache-maven-3.3.9-bin.tar.gz
	echo "export MAVEN_HOME=${PWD_DIR}/apache-maven-3.3.9/" >> /etc/profile
	echo "export PATH=\$PATH:\$MAVEN_HOME/bin" >> /etc/profile

	source /etc/profile

}

install_maven
