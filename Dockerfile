
#pull base image

FROM centos:latest

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

#java下载
RUN wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" download.oracle.com/otn-pub/java/jdk/8u111-b14/jdk-8u111-linux-x64.tar.gz -O /root/res/jdk-8u111-linux-x64.tar.gz


#时间戳
RUN  \cp -rf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo 'Asia/Shanghai' >/etc/timezone

COPY init /root/init/

COPY entrypoint.sh /sbin/

ENTRYPOINT  ["/bin/bash","/sbin/entrypoint.sh"]

CMD ["start"]

#Expose ports
EXPOSE 8080
