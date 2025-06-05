Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/jammy64" #mwrock/Windows2016

  config.vm.define "master" do |master|
    master.vm.network "private_network", ip: "192.168.56.10"
    master.ssh.forward_agent = true
    master.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
      vb.cpus = 2
    end
    master.vm.provision "shell", inline: <<-SHELL
      sudo apt-get update
      sudo apt-get -y upgrade
      sudo apt-get install -y apache2 mysql-server php libapache2-mod-php php-mysql
      sudo systemctl enable apache2
      sudo systemctl enable mysql
    SHELL
  end

  config.vm.define "first" do |first|
    first.vm.network "private_network", ip: "192.168.56.11"
    first.ssh.forward_agent = true
    first.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
      vb.cpus = 1
    end
    first.vm.provision "shell", inline: <<-SHELL
      sudo apt-get update
      sudo apt-get -y upgrade
    SHELL
  end

  config.vm.define "second" do |second|
    second.vm.network "private_network", ip: "192.168.56.12"
    second.ssh.forward_agent = true
    second.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
      vb.cpus = 1
    end
    second.vm.provision "shell", inline: <<-SHELL
      sudo apt-get update
      sudo apt-get -y upgrade
    SHELL
  end

end
