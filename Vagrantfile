Vagrant.configure("2") do |config|

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "1024"
  end

  config.vm.define "master" do |master|
    master.vm.box = "ubuntu/jammy64"
    master.vm.network "private_network", ip: "192.168.56.10"
    master.ssh.forward_agent = true
    master.vm.provision "shell", inline: <<-SHELL
        sudo apt-get update
        sudo apt-get upgrade
        sudo apt-get install -y ansible
    SHELL

  end

  config.vm.define "first" do |first|
    first.vm.box = "ubuntu/jammy64"
    first.vm.network "private_network", ip: "192.168.56.11"
    first.ssh.forward_agent = true
    master.vm.provision "shell", inline: <<-SHELL
        sudo apt-get update
        sudo apt-get upgrade
    SHELL
  end

  config.vm.define "second" do |second|
    second.vm.box = "ubuntu/jammy64"
    second.vm.network "private_network", ip: "192.168.56.12"
    second.ssh.forward_agent = true
    master.vm.provision "shell", inline: <<-SHELL
        sudo apt-get update
        sudo apt-get upgrade
    SHELL
  end

end
