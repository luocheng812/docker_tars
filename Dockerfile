
#pull base image

FROM centos:7

MAINTAINER preluoc "pre_luoc@sina.com"

#install git
RUN yum install -y git

WORKDIR /root/

RUN git clone https://github.com/Tencent/Tars.git

RUN git clone https://github.com/Tencent/rapidjson.git

RUN cp -r /root/rapidjson /root/Tars/cpp/thirdparty/

RUN yum install -y gcc

RUN yum install -y gcc-c++

RUN yum install -y make

RUN yum install -y iproute

RUN yum install -y which

##安装glibc-devel
RUN yum install -y glibc-devel

##安装flex、bison
RUN yum install -y flex bison

# mysql 支持库
RUN yum install -y ncurses-devel
RUN yum install -y zlib-devel


RUN yum install -y perl

RUN yum install -y perl-Module-Install.noarch


#中文乱码
RUN  yum install -y kde-l10n-Chinese

RUN  yum reinstall -y glibc-common


#拷贝资源
COPY res /root/res/

RUN  yum install -y wget

#java下载
RUN  wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" download.oracle.com/otn-pub/java/jdk/8u111-b14/jdk-8u111-linux-x64.tar.gz -O /root/res/jdk-8u111-linux-x64.tar.gz

#RUN  curl http://mirror.bit.edu.cn/apache//maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz -o /root/res/apache-maven-3.3.9-bin.tar.gz

#RUN  curl https://cmake.org/files/v2.8/cmake-2.8.8.tar.gz -o /root/res/cmake-2.8.8.tar.gz

#RUN  curl http://www.caucho.com/download/resin-4.0.49.tar.gz -o /root/res/resin-4.0.49.tar.gz

COPY init /root/init/

COPY entrypoint.sh /sbin/

ENTRYPOINT  ["/bin/bash","/sbin/entrypoint.sh"]

CMD ["start"]

#Expose ports
EXPOSE 8080
