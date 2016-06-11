# About Chef-Server environment

## Introduction

Below is an abstract of [Learn Chef tutorial] (https://learn.chef.io/manage-a-node/ubuntu/):

Typically, Chef is comprised of three elements – your **workstation**, a **Chef server**, and **nodes**

+ Your **workstation**: is the computer from which you author your cookbooks and administer your network. It's typically the machine you use everyday. Although you'll be configuring an Ubuntu server, your workstation can be any OS you choose – be it Linux, Mac OS, or Windows.
+ **Chef server** acts as a central repository for your cookbooks as well as for information about every node it manages. For example, the Chef server knows a node's fully qualified domain name (FQDN) and its platform.
+ A **node** is any computer that is managed by a Chef server. Every node has the Chef client installed on it. The Chef client talks to the Chef server. A node can be any physical or virtual machine in your network.

#### Vagrant learn-chef associated VM

The Vagrantfile machines associated with the three above elements are:

+ **chef-mgmt**    : this VM can be used as **workstation**
+ **chef-server**: this VM will be the **Chef Server**
+ **node**       : this VM will be the **node**

**Please Note:** The best practice for a production environment is not to run knife on the server, and not work directly with the server’s chef-repo, but to use a management workstation. For this reason instead of naming the **workstation** VM chef-workstation, it has been instead named chef-mgmt.

## Chef Server (chef-server) configuration details

###### About provisioning

The provisioning of **chef-server** is done based on [Chef Standalone] (https://docs.chef.io/install_server.html) installation guide.

In order to have a ready-to-go Chef Server, below tasks are completed:

+ Set Chef Server FQDN
+ Creation of an Administrator
+ Creation of an Organization

Below are the associated values:

Parameter | Associated Value |
|---|---|
**Chef Server FQDN** | mychefserver.example.com|
**Administrator** | jdoe |
**Organization** | 4thcoffee |

An RSA private key is generated automatically during **Administrator creation**
+ The associated filename is : **jdoe.pem**
+ The associated file can be found
  + On **chef-server**               : in **/tmp** folder.
  + On **the host running VirtualBox**: in **learn-chef/cert** folder.

Another RSA private key is generated automatically during **Organization creation**. This is the chef-validator key. 
+ The associated filename is : **4thcoffee-validator.pem**
+ The associated file can be found
  + On **chef-server**               : in **/tmp** folder
  + On **the host running VirtualBox**: in **learn-chef/cert** folder

Also, during Chef-Server installation, a SSL Self-Signed certificate is issued.
+ The associated filename is : **mychefserver.example.com.crt**
  + The associated file can be found on **the host running VirtualBox** in **learn-chef/cert** folder.


**Tips:**Shall you use another workstation than **chef-mgmt** to interact with Chef Server.
   + Copy **jdoe.pem** file in the **.chef** folder
   + Copy **mychefserver.example.com.crt** in the **.chef/trusted_certs** folder
   
   
**Please Note:** These files are generated each time a ```vagrant up chef-server``` is done.

###### About knife.rb file

A **knife.rb** file is used to specify the chef-repo-specific configuration details for knife
Further details regarding knife.rb file can be found [here] (https://docs.chef.io/config_rb_knife.html)

The **Vagrant learn-chef** knife.rb file content is:

	# See https://docs.getchef.com/config_rb_knife.html for more information on knife configuration options
	
	current_dir = File.dirname(__FILE__)
	log_level                :info
	log_location             STDOUT
	node_name                "jdoe"
	client_key               "#{current_dir}/jdoe.pem"
	validation_client_name   "4thcoffee-validator"
	validation_key           "#{current_dir}/4thcoffee-validator.pem"
	chef_server_url          "https://mychefserver.example.com/organizations/4thcoffee"
	cookbook_path            ["#{current_dir}/../cookbooks"]
	

As you can see the **chef_server_url** use the Chef Server FQDN (mychefserver.example.com)

**Tips:** Shall you use another workstation than **chef-mgmt** to interact with Chef Server:
   + Ensure that mychefserver.example.com can be resolved by the workstation.
      + Below entry in the hosts file of the workstation shall be enough:
   + Copy the **knife.rb** file in **.chef** folder

	192.168.99.26 mychefserver.example.com


## Workstation (chef-mgmt) configuration details