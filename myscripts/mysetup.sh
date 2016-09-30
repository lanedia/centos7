#!/bin/sh
yum -y update
yum -y install yum-utils
yum -y install wget
yum -y install vim
yum -y install epel-release 
yum -y install dkms
yum -y install kernel-devel-3.10.0-327.el7.x86_64 
yum -y install apt-transport-https ca-certificates
 
systemctl set-default graphical.target

#setup devtoolset for SP develop - currently not avail on centos7 and source code has dependancies on it.
mkdir -p /opt/rh/devtoolset-2/root/usr
cd /opt/rh/devtoolset-2/root/usr
ln -s /usr/bin bin

yum install gcc-c++ 
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

#sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
#echo "deb https://apt.dockerproject.org/repo ubuntu-trusty main" >/etc/apt/sources.list.d/docker.list
#apt-get update
#apt-get -y install linux-image-extra-$(uname -r)
#apt-get -y install docker-engine
usermod -aG docker vagrant
#echo 'DOCKER_OPTS="-H tcp://0.0.0.0:2375 -H unix:///var/run/docker.sock"' >> /etc/default/docker
#service docker restart
