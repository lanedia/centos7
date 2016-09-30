Vagrant.configure(2) do |config|
 config.vm.define "mycentos" do |mycentos|
  #mycentos.vm.box = "centos/7"
  #mycentos.vm.box = "hexapp/centos7"
  mycentos.vm.box = "nhalm/centos7-gui"
  mycentos.vm.hostname = "mycentos"
  mycentos.ssh.insert_key=false
  #mycentos.vm.network "private_network", ip: "192.168.0.2"
  mycentos.vm.network "public_network"
  mycentos.vm.provider "virtualbox" do |v|
    v.memory = 4096
    v.cpus = 2
  end
  mycentos.vm.provision "shell", path: "myscripts/mysetup.sh"
 end
end
