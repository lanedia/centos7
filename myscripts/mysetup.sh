#!/bin/sh
yum -y update
echo "Diarmuid -  after yum update"
yum -y install yum-utils
echo "Diarmuid -  after yum-utils"
yum -y install wget
echo "Diarmuid -  after wget"
yum -y install vim
echo "Diarmuid -  after vim"
yum -y install epel-release 
echo "Diarmuid -  after epel-release"
yum -y install dkms
echo "Diarmuid -  after dkms"
yum -y install kernel-devel-3.10.0-327.el7.x86_64 
echo "Diarmuid -  after kernel"
yum -y install apt-transport-https ca-certificates
echo "Diarmuid -  after apt-transport"
 
systemctl set-default graphical.target
echo "Diarmuid -  systemctl"
mkdir -p /opt/rh/devtoolset-2/root/usr
cd /opt/rh/devtoolset-2/root/usr
ln -s /usr/bin bin

echo "Diarmuid -  install gcc-c++"
yum install gcc-c++ 
echo "Diarmuid -  install node"
#cd /usr/src
#wget https://nodejs.org/dist/v4.5.0/node-v4.5.0.tar.gz
#tar xvfz node-v4.5.0.tar.gz
#cd /usr/src/node-v4.5.0
#./configure
#make   -j4
#./make install
curl --silent --location https://rpm.nodesource.com/setup_4.x | bash -
yum install -y nodejs
#yum install -y npm 

#sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
#echo "deb https://apt.dockerproject.org/repo ubuntu-trusty main" >/etc/apt/sources.list.d/docker.list
#apt-get update
#apt-get -y install linux-image-extra-$(uname -r)
#apt-get -y install docker-engine
usermod -aG docker vagrant
#echo 'DOCKER_OPTS="-H tcp://0.0.0.0:2375 -H unix:///var/run/docker.sock"' >> /etc/default/docker
#service docker restart
