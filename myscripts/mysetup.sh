#!/bin/sh
yum -y update
yum -y install yum-utils
package-cleanup --oldkernels --count=1

yum -y install wget
yum -y install vim
yum -y install epel-release 
yum -y install dkms
yum -y install kernel-devel-3.10.0-327.el7.x86_64 
yum -y install apt-transport-https ca-certificates
yum -y install firefox
yum -y install samba
yum -y install nginx

systemctl set-default graphical.target

useradd -u 1001 -g vagrant -c "Tecnotree" -d /home/tecnotree -m -s /bin/bash tecnotree
yes tecnotree|passwd tecnotree

cp /home/vagrant/.bashrc /home/tecnotree/.bashrc
chown tecnotree:vagrant /home/tecnotree/.bashrc

cd /home/vagrant/
#wget https://download.jetbrains.com/webstorm/WebStorm-11.0.3.tar.gz
#tar xvfz WebStorm-11.0.3.tar.gz

#setup devtoolset for SP develop - currently not avail on centos7 and source code has dependancies on it.
#mkdir -p /opt/rh/devtoolset-2/root/usr
#cd /opt/rh/devtoolset-2/root/usr
#ln -s /usr/bin bin

#yum install gcc-c++ 
# Install node
curl --silent --location https://rpm.nodesource.com/setup_4.x | bash -
yum install -y nodejs
# install node from source & compile
#currently commented out
#cd /usr/src
#wget https://nodejs.org/dist/v4.5.0/node-v4.5.0.tar.gz
#tar xvfz node-v4.5.0.tar.gz
#cd /usr/src/node-v4.5.0
#./configure
#make   -j4
#./make install
#yum install -y npm 

usermod -aG docker vagrant
#echo 'DOCKER_OPTS="-H tcp://0.0.0.0:2375 -H unix:///var/run/docker.sock"' >> /etc/default/docker
service docker restart

sudo rpm -ivh http://pulp.tecnotree.com/pulp/repos/ccs_upstream/ccs-repoconf-1-0.noarch.rpm

#ACE Micro
cat << EOF > /etc/yum.repos.d/pulp-ace-micro-mirror.repo
[pulp-mirror-devel_libraries_ACE_micro]
name=Mirrored ACE micro release (CentOS_CentOS-6)
baseurl=http://pulp.tecnotree.com/pulp/repos/ACE-micro/
enabled=1
gpgcheck=0
EOF

grub2-mkconfig -o /boot/grub2/grub.cfg


#yum -y install redis
#systemctl enable redis.service
#systemctl start redis.service

#Need to let the world access through port 9000.
#firewall-cmd --zone=public --add-port=9000/tcp --permanent
systemctl stop iptables
#firewall-cmd --reload

#sudo rpm -Uvh http://archive.cloudera.com/cdh4/one-click-install/redhat/6/x86_64/cloudera-cdh-4-0.x86_64.rpm
sudo rpm --import http://packages.confluent.io/rpm/3.0/archive.key
#sudo yum -y install zookeeper zookeeper-server
#sudo -u zookeeper zookeeper-server-initialize --myid=1
#sudo service zookeeper-server start

sudo yum -y install node-gyp

echo "Install Kafka"

cat << EOF > /etc/yum.repos.d/confluent.repo
[Confluent.dist]
name=Confluent repository (dist)
baseurl=http://packages.confluent.io/rpm/3.0/7
gpgcheck=1
gpgkey=http://packages.confluent.io/rpm/3.0/archive.key
enabled=1
  
[Confluent]
name=Confluent repository
baseurl=http://packages.confluent.io/rpm/3.0
gpgcheck=1
gpgkey=http://packages.confluent.io/rpm/3.0/archive.key
enabled=1
EOF
sudo rpm --import http://packages.confluent.io/rpm/3.0/archive.key
sudo yum -y clean all
sudo yum -y install confluent-platform-2.11
sudo groupadd kafka
sudo useradd kafka -g kafka

cat <<-EOF > /etc/systemd/system/zookeeper.service 
[Unit]                                                                                                                                    
   
Description=Apache Zookeeper
After=network.target
  
[Service]
Type=simple
User=kafka
Group=kafka
ExecStart=/usr/bin/zookeeper-server-start /etc/kafka/zookeeper.properties
ExecStop=/usr/bin/zookeeper-server-stop
KillSignal=SIGINT
RestartSec=10s
Restart=always
SuccessExitStatus=130
  
[Install]
WantedBy=multi-user.target
EOF

cat <<-EOF > /var/lib/zookeeper/myid
1
EOF

echo "enable & start zookeeper"
systemctl enable zookeeper
systemctl start zookeeper

echo "enable docker"
sudo systemctl enable docker