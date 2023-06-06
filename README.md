# 02-Learning Ansible
For Mastery of Ansible and all things server configuration management. 

## Why Ansiblle 
>Security

Consistency of configuration leads to a more secure environment. Integrated security policies will improve ability to scan and remediate issues

>Compliance 

Putting policy into code and then applying that code to servers allows for compliance throughout datacentres. Rather than have an individual touch 500 servers, one code does it all.  

>Rapid Deployment

With server builds defined by code, the speed of deployments go up.

## Core Components of Ansible 

`$ ansible-config` command can be used to view configurations with `list` giving you all config options, `dump` dumping the config into the console and `view` to view the config

#### Inventories

Inventory files are the files ansbile uses to locate and run against multiple hosts

The default location of hosts file is: 

`$ /etc/ansible/hosts`

and the default location of the hosts file can be set in 

`$ /etc/ansible/ansible.cfg`

You can have a .yml based inventory file or a .ini file

### Modules 

Modules are tools for a particular tasks. They can take parameters and return JSON notation. 

They can be run from the command line or within a playbook and ansible comes with a significant amout of default modules as standard

Modules have different flags and variables that should be set to do their job

`ansible-doc <modulename>` command can be used to get more info on modules 

For Example `ansible-doc --l | grep docker` lists all the docker modules available to use 

### Variables 

Variable are strings of letters, numbers and underscores that will store configuration values and parameters what we will be working with. Three main scopes for variables are:
- Global 
- Hosts 
- Play 

A good 

### Facts 

Provide information about a given target hosts. They are automatically discovered by Ansible when it reaches out to another node/host but can be disabled within the config file or be cached for use in a playbook execution 

### Plays and Playbooks 

A playbook consists of one or more tasks which make calls to ansible modules. A playbook can have a series of plays/instructions for which ansible will then ssh to the control nodes and action. These playbooks can be written in yaml or ini file. 

Are essentially bash scripts for ansible. Using modules within a playbook, you can declare and configure or spell out steps that must be taken including between multiple server or sets of servers. 

Here is a simple nginx installation playbook. It is a yaml file
 ```
 hosts: all 
 become: yes
 tasks: 
    - name: install nginx
      yum :
         name: nginx 
         state: latest 
    - name: start the service 
      service: 
         name: nginx
         state: started
```
Once the playbook is saved, you can run `ansible-playbook name.yml` to start the playbook. 

Here is an example playbook to install and configure apache on a server
```
- hosts: all
  become: yes
  tasks:
    - name: Install Apache
      yum:
        name: httpd
        state: latest
    - name: git checkout the website
      git:
        dest: /var/www/html
        repo: https://github.com/linuxacademy/content-introduction-to-ansible.git
    - name: Start the Apache service
      service:
        name: httpd
        state: started
    - name: Open the firewall ports
      firewalld:
        service: http
        permanent: yes
        state: enabled
  ```
## Installation 

`$ sudo yum install ansbile` installs ansible on your redhat based system 

`$ ansible --version` allows you to check which ansible version you currently have 

`$ sudo vim /etc/ansible/hosts` sets up the default ansible hosts file 

`$ ansible all -m ping` connects to all servers in the inventory file. You should see success

`$ ansible all --lists-hosts` shows us all the hosts in the all inventory 

`$ ansible webservers --lists-hosts` shows you the hosts within the webservers group

## Documentation 

Online documentation can be found here: [Ansible Documentation] 

Documentation via terminal can be accessed using following commands: 

`$ ansible-doc (-h)` is the documentation tool for plugins and modules. `-h` can be added for help with `-l` being the list option

`$ ansible-doc module_name` shows documentation for a module 

`$ ansible-doc -s module_name` shows only a snipped of the module doc but still lists the parameters and what they do

s 
