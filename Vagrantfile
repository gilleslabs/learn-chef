# -*- mode: ruby -*-
# vi: set ft=ruby :

######################################################################################################
#                                                                                                    #
# Vagrantfile for provisioning ready-to-go VM for learning Chef 12.6                                 #
#                                                                                                    #
# Author: Gilles Tosi                                                                                #
#                                                                                                    #
# The up-to-date version and associated dependencies/project documentation is available at:          #
#                                                                                                    #
# https://github.com/gilleslabs/learn-chef/                                                          #
#                                                                                                    #
######################################################################################################




######################################################################################################
#                                                                                                    #
#      Setup of $client variable which will be used for chef-client VM Shell inline provisioning     #
#                                                                                                    #
######################################################################################################

$client = <<CLIENT
     sudo apt-get update --yes
     sudo apt-get install curl --yes > /dev/null
     curl https://omnitruck.chef.io/install.sh | sudo bash -s -- -P chefdk
     sudo apt-get install vim --yes
     sudo apt-get install nano --yes
     sudo apt-get install emacs --yes
CLIENT

######################################################################################################
#                                                                                                    #
#      Setup of $mgmt variable which will be used for chef-mgmt VM Shell inline provisioning         #
#                                                                                                    #
######################################################################################################

$mgmt = <<MGMT
     
	 ######## Installing Chef SDK and some text editors        ###########################
	 sudo apt-get update --yes
     sudo apt-get install curl --yes > /dev/null
     curl https://omnitruck.chef.io/install.sh | sudo bash -s -- -P chefdk
     sudo apt-get install vim --yes
     sudo apt-get install nano --yes
     sudo apt-get install emacs --yes
	 
	 ######## Applying Chef SDK post deployment pre-requisites ###########################
	 
	 echo 'eval "$(chef shell-init bash)"' >> /home/vagrant/.bash_profile
	 echo 'export PATH="/opt/chefdk/embedded/bin:$PATH"' >> /home/vagrant/.bash_profile 
	 source /home/vagrant/.bash_profile
	 
	 ######## Setting chef repo and copying chef-server RSA key and SSL certificate   ####
	 
	 cd /home/vagrant/
	 sudo su - vagrant
	 mkdir /home/vagrant/chef-repo
	 mkdir /home/vagrant/chef-repo/.chef
	 mkdir /home/vagrant/chef-repo/cookbooks
	 mkdir /home/vagrant/chef-repo/.chef/trusted_certs
	 cp /vagrant/cert/jdoe.pem /home/vagrant/chef-repo/.chef/.
	 cp /vagrant/cert/4thcoffee-validator.pem /home/vagrant/chef-repo/.chef/.
	 cp /vagrant/cert/knife.rb /home/vagrant/chef-repo/.chef/.
	 cp /vagrant/cert/mychefserver.example.com.crt /home/vagrant/chef-repo/.chef/trusted_certs/.
	 
	 ######## Updating /etc/hosts                                                      #####
	 
	 echo "192.168.99.26 mychefserver.example.com" | sudo tee -a /etc/hosts
MGMT
######################################################################################################
#                                                                                                    #
#   Setup of $server variable which will be used for chef-server VM Shell inline provisioning        #
#                                                                                                    #
######################################################################################################

$server = <<SERVER
     sudo apt-get update --yes
	 ########           Applying Chef Server pre-requisites    ##################### 
	 
	 sudo apt-get install apparmor-utils —yes
	 sudo aa-complain /etc/apparmor.d/*
	 sudo hostname 'mychefserver.example.com'
	 echo "127.0.1.1 192.168.99.26 mychefserver" | sudo tee -a /etc/hosts
	 sudo apt-get install ntp --yes
	 sudo useradd opscode
	 
	 ########           Installing Chef Server                  #####################
	 
     cd /tmp
	 wget https://packages.chef.io/stable/ubuntu/14.04/chef-server-core_12.6.0-1_amd64.deb
	 sudo dpkg -i /tmp/chef-server-core_12.6.0-1_amd64.deb
	 sudo chef-server-ctl reconfigure
	 sudo chef-server-ctl user-create jdoe John Doe jdoe@chef.io 'abc123' --filename /tmp/jdoe.pem
	 sudo chef-server-ctl org-create 4thcoffee 'Fourth Coffee, Inc.' --association_user jdoe --filename /tmp/4thcoffee-validator.pem
	 sudo chef-server-ctl install chef-manage 
	 sudo chef-server-ctl reconfigure --accept-license
	 sudo chef-manage-ctl reconfigure --accept-license
	 
	 ########           Installing Chef Push Job                #####################
	 
	 sudo chef-server-ctl install opscode-push-jobs-server
	 sudo chef-server-ctl reconfigure --accept-license
	 sudo opscode-push-jobs-server-ctl reconfigure --accept-license
	 
	 ########           Installing Chef Reporting                #####################
	 
	 sudo chef-server-ctl install opscode-reporting
	 sudo chef-server-ctl reconfigure --accept-license
	 sudo opscode-reporting-ctl reconfigure --accept-license
	 
	 ########   Cleaning (previous deployment) RSA key and SSL Certificate ###########
	 
	 sudo touch /vagrant/cert/mychefserver.example.com.crt
	 sudo touch /vagrant/cert/jdoe.pem
	 sudo touch /vagrant/cert/4thcoffee-validator.pem
	 
	 sudo rm /vagrant/cert/mychefserver.example.com.crt
	 sudo rm /vagrant/cert/jdoe.pem
	 sudo rm /vagrant/cert/4thcoffee-validator.pem
	 
	 sudo cp /var/opt/opscode/nginx/ca/mychefserver.example.com.crt /vagrant/cert/.
	 sudo cp /tmp/jdoe.pem /vagrant/cert/.
	 sudo cp /tmp/4thcoffee-validator.pem /vagrant/cert/.
	 

SERVER

######################################################################################################
#                                                                                                    #
#      Setup of $node variable which will be used for node VM Shell inline provisioning              #
#                                                                                                    #
######################################################################################################

$node = <<NODE
     sudo apt-get remove chef --yes
	 echo "192.168.99.26 mychefserver.example.com" | sudo tee -a /etc/hosts

NODE


Vagrant.configure(2) do |config|

	config.vm.define "node" do |node|
        node.vm.box = "ubuntu/trusty64"
        node.vm.network "private_network", ip: "192.168.99.27"
		node.vm.provision :shell, inline: $node
    end
	
	config.vm.define "chef-client" do |client|
        client.vm.box = "ubuntu/trusty64"
        client.vm.network "private_network", ip: "192.168.99.25"
		client.vm.provision :shell, inline: $client
    end
	
	config.vm.define "chef-server" do |server|
        server.vm.box = "ubuntu/trusty64"
			config.vm.provider "virtualbox" do |v|
				v.cpus = 4
				v.memory = 4096
			end
		server.vm.network "private_network", ip: "192.168.99.26"
		server.vm.provision :shell, inline: $server
    end
	
	config.vm.define "chef-mgmt" do |mgmt|
        mgmt.vm.box = "ubuntu/trusty64"
        mgmt.vm.network "private_network", ip: "192.168.99.28"
		mgmt.vm.provision :shell, inline: $mgmt
    end
	
	config.vm.define "chef-mgmt-win" do |win|
        win.vm.box = "opentable/win-2012r2-standard-amd64-nocm"
			config.vm.provider "virtualbox" do |w|
				w.cpus = 2
				w.memory = 4096
				w.customize ["modifyvm", :id, "--vram", "128"]
				w.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
			end
		win.vm.communicator = "winrm"
		win.winrm.retry_limit = 30
        win.winrm.retry_delay = 10
        win.vm.network "private_network", ip: "192.168.99.29"
		win.vm.provision :shell, path: "shell/main.cmd"
		win.vm.provision :shell, path: "shell/InstallBoxStarter.bat"
		win.vm.provision :shell, path: "shell/install_tool.cmd"
		win.vm.provision :shell, path: "shell/configure_mgmt.cmd"
		
    end

end
