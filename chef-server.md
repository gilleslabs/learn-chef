# About Chef-Server environment

## Introduction

Below is an abstract of [Learn Chef tutorial] (https://learn.chef.io/manage-a-node/ubuntu/)

	
	Typically, Chef is comprised of three elements – your **workstation**, a **Chef server**, and **nodes**
	
	+ Your **workstation**: is the computer from which you author your cookbooks and administer your network. It's typically the machine you use everyday. Although you'll be configuring an Ubuntu server, your workstation can be any OS you choose – be it Linux, Mac OS, or Windows.
	+ **Chef server** acts as a central repository for your cookbooks as well as for information about every node it manages. For example, the Chef server knows a node's fully qualified domain name (FQDN) and its platform.
	+ A **node** is any computer that is managed by a Chef server. Every node has the Chef client installed on it. The Chef client talks to the Chef server. A node can be any physical or virtual machine in your network.

