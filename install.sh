#!/usr/bin/bash
set -u

dir=/tmp/heartbeat
function prepare {
dir=/tmp/heartbeat

[ -d $dir ]||  mkdir $dir
url=https://gitee.com/hcak-wu/Heartbeat_source_install/raw/master/Cluster-Glue-1.0.12.tar.gz
wget -O $dir/Cluster-Glue-1.0.12.tar.gz  $url
url=https://gitee.com/hcak-wu/Heartbeat_source_install/raw/master/Heartbeat-3.0.6.tar.gz
wget -O $dir/Heartbeat-3.0.6.tar.gz  $url
url=https://gitee.com/hcak-wu/Heartbeat_source_install/raw/master/resource-agents-3.9.6.tar.gz
wget -O $dir/resource-agents-3.9.6.tar.gz  $url

cd $dir
tar xf Cluster-Glue-1.0.12.tar.gz
tar xf Heartbeat-3.0.6.tar.gz
tar xf resource-agents-3.9.6.tar.gz
yum install -y gcc gcc-c++ autoconf automake libtool glib2-devel libxml2-develbzip2-devel \
e2fsprogs-devel libxslt-devel libtool-ltdl-devel make wget docbook-dtds docbook-style-xsl bzip2-devel asciidoc libuuid-devel

groupadd haclient
useradd -g haclient hacluster -M -s /sbin/nologin
}

prepare
cd $dir/Cluster-Glue-1.0.12
./autogen.sh
./configure --prefix=/usr/local/heartbeat --sysconfdir=/etc/heartbeat libdir=/usr/local/heartbeat/lib64
make -j4 && make install
[ "$?" -ne 0  ]&& echo "Cluster-Glue 安装出错！！"&& exit 1

cd $dir/resource-agents-3.9.6
./autogen.sh
./configure --prefix=/usr/local/heartbeat --sysconfdir=/etc/heartbeat libdir=/usr/local/heartbeat/lib64 CFLAGS=-I/usr/local/heartbeat/include LDFLAGS=-L/usr/local/heartbeat/lib64
ln -s /usr/local/heartbeat/lib64/* /lib64/
make -j4 && make install
[ "$?" -ne 0  ]&& echo "resource-agents-3.9.6  安装出错！！"&& exit 1

cd $dir/Heartbeat-3.0.6
./bootstrap
./configure --prefix=/usr/local/heartbeat --sysconfdir=/etc/heartbeat CFLAGS=-I/usr/local/heartbeat/include  LDFLAGS=-L/usr/local/heartbeat/lib64
sed -i "$ d"  /usr/local/heartbeat/include/heartbeat/glue_config.h

make -j4 && make install 
[ "$?" -ne 0  ]&& echo "Heartbeat-3.0.6 安装出错  出错！！"&& exit 1

cp doc/ha.cf doc/authkeys doc/haresources /etc/heartbeat/ha.d/
chmod 600 /etc/heartbeat/ha.d/authkeys 

echo "----------------------------------"
echo "安装完成"
ls -l  /etc/heartbeat/ha.d/
ls -l /etc/init.d/heartbeat


