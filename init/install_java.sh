#!/bin/bash

set -e

install_java(){

	echo "install java"

	cd /root/res
	##安装java jdk
	tar zxvf jdk-8u111-linux-x64.tar.gz
	echo "export JAVA_HOME=${PWD_DIR}/jdk1.8.0_111" >> /etc/profile
	echo "CLASSPATH=\$JAVA_HOME/lib/dt.jar:\$JAVA_HOME/lib/tools.jar" >> /etc/profile
	echo "PATH=\$JAVA_HOME/bin:\$PATH" >> /etc/profile
	echo "export PATH JAVA_HOME CLASSPATH" >> /etc/profile

	source /etc/profile
}




install_java
