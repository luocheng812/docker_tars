
#pull base image

FROM centos:latest

MAINTAINER preluoc "pre_luoc@sina.com"

#install git
RUN yum install -y git

WORKDIR /root

RUN git clone https://github.com/Tencent/Tars.git

RUN git clone https://github.com/Tencent/rapidjson.git

RUN cp -r /root/rapidjson /root/Tars/cpp/thirdparty/

RUN cd  /root/Tars

RUN yum install -y gcc

RUN yum install -y gcc-c++

RUN yum install -y make

RUN yum install -y iproute

RUN yum install -y which

COPY apache-maven-3.3.9-bin.tar.gz /root/Tars/build/

COPY cmake-2.8.8.tar.gz /root/Tars/build/

COPY resin-4.0.49.tar.gz /root/Tars/build/

COPY mysql-5.6.26.tar.gz /root/Tars/build/

COPY repository.tar.gz /root/Tars/build/

COPY docker_init.sh /root/Tars/build/

RUN  chmod u+x /root/Tars/build/docker_init.sh

COPY tars.sh  /root/

RUN  chmod u+x /root/tars.sh

#中文乱码
RUN  yum install -y kde-l10n-Chinese

RUN  yum reinstall -y glibc-common

#RUN  echo "export LC_ALL=zh_CN.UTF-8"  >>  /etc/profile

#时间戳
RUN  \cp -rf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo 'Asia/Shanghai' >/etc/timezone

WORKDIR /root/Tars/build

CMD  ["/bin/bash","/root/Tars/build/docker_init.sh"]


#Expose ports
EXPOSE 8080
