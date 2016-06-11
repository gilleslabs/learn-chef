# Vagrant learn-chef

Vagrant learn-chef creates ready-to-go VMs for [Chef] (https://www.chef.io/chef/) 12.6 self-paced learning

The following is an overview of the ready-to-go VMs:

+ **chef-client:** Ready-to-go VM for ["Learn the Chef basics on Ubuntu"] (https://learn.chef.io/learn-the-basics/ubuntu/) tutorial.
+ **chef-server:** Ready-to-go VM (Server) for ["Manage an Ubuntu node"] (https://learn.chef.io/manage-a-node/ubuntu/) tutorial with already installed:
 + Chef Server 12.6
 + Chef Manage package
 + Chef Push Jobs package
 + Reporting package
+ **chef-mgmt  :** Ready-to-go VM (Workstation) for ["Manage an Ubuntu node"] (https://learn.chef.io/manage-a-node/ubuntu/) tutorial with already installed:
 + Chef SDK
 + knife.rb and user's RSA private key in /home/vagrant/chef-repo/.chef
 + chef-server SSL certificate in /home/vagrant/chef-repo/.chef/trusted_certs
+ **node       :** Ready-to-go VM (Node) node for ["Manage an Ubuntu node"] (https://learn.chef.io/manage-a-node/ubuntu/)
## Requirements

- [VirtualBox](https://www.virtualbox.org/wiki/Downloads). Tested on 5.0.20, but should also work on 5.0.20+ release.
- [Vagrant](http://www.vagrantup.com/downloads.html). Tested on 1.7.4

All VMs are provisioned using ubuntu/trusty64 (Ubuntu 14.04 Trusty Tahr) from [atlas.hashicorp.com] (https://atlas.hashicorp.com/ubuntu/boxes/trusty64) images, thus your workstation must have a direct internet access. 

## VMs details

VM| IP Address| user/password |root password |
---|---|---|---|
**chef-client** | 192.168.99.25 | vagrant/vagrant | vagrant |
**chef-server** | 192.168.99.26 | vagrant/vagrant | vagrant |
**node** | 192.168.99.27 | vagrant/vagrant | vagrant |
**chef-mgmt** | 192.168.99.28 | vagrant/vagrant | vagrant |
	```

## Credits

This project was totally inspired from [Learn Chef](https://learn.chef.io/)


## MIT

Copyright (c) 2016 Gilles Tosi

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE