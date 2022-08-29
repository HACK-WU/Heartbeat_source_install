# Heartbeat 下载和脚本安装

* 网上查询的Heartbeat最简单的安装方式就是使用yum安装，就是直接先下载一个epel源，然后`yum install -y heartbeat`

* 但是我在Centos 7.6 上这个方法却行不通，说找不到heartbeat这个包。尽管我换了很多个epel源，结果还是一样的，十分无奈。

* 后来我打算直接手动安装rpm包得了，可是heartbeat的rpm十分难找，不过还是找到了。但是它的安装可以说是异常艰难，因为依赖超多。有兴趣的人可以试试，下载地址如下：

  ```shell
  wget ftp://ftp.ntua.gr/pub/linux/fedora-epel/6/x86_64/Packages/h/heartbeat-3.0.4-2.el6.x86_64.rpm
  wget ftp://ftp.ntua.gr/pub/linux/fedora-epel/6/x86_64/Packages/h/heartbeat-libs-3.0.4-2.el6.x86_64.rpm
  ```

* 所以后来我直接选择了源码安装，虽然也有一点点麻烦，但是在没有yum源的情况已经是最快的方式了。



# Hearbeat 源码安装

为了节省时间，方便操作，我直接将安装方式写成了脚本，直接运行即可。

* 适用系统	Centos7.6

* 不过在这里我也将需要用到的源码下载地址告诉大家，
  * 但是我要说明一下，下载的并不是官方一开始发布的样子，而是我提前下载好后，从新打包的源码包。
  * 下载地址也不是官方地址，而是我自己Gitee仓库。
* 源码包下载地址：

```shell
wget https://gitee.com/hcak-wu/Heartbeat_source_install/raw/master/Heartbeat-3.0.6.tar.gz  #heartbeat 下载
wget https://gitee.com/hcak-wu/Heartbeat_source_install/raw/master/Cluster-Glue-1.0.12.tar.gz #依赖下载
wget https://gitee.com/hcak-wu/Heartbeat_source_install/raw/master/resource-agents-3.9.6.tar.gz #依赖下载
```



* 以上脚本install.sh下载后，直接运行就可以安装了。
* 此脚本工作目录为`/tmp/heartbeat/`
* 此脚本安装完成后，会自动对heartbeat进行初始化配置，无需手动。

