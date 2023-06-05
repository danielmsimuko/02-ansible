# RedHat Certified Engineer 8 - Ansible Notes

## Documentation 

Online documentation can be found here: [Ansible Documentation] 

Documentation via terminal can be accessed using following commands: 

`$ ansible-doc (-h)` is the documentation tool for plugins and modules. `-h` can be added for help with `-l` being the list option

`$ ansible-doc module_name` shows documentation for a module 

`$ ansible-doc -s module_name` shows only a snipped of the module doc but still lists the parameters and what they do

## Core Components of Ansible 

`$ ansible-config` command can be used to view configurations with `list` giving you all config options, `dump` dumping the config into the console and `view` to view the config

### Inventories

Inventory files are the files ansbile uses to locate and run against multiple hosts

The default location of hosts file is: 

`$ /etc/ansible/hosts`

and the default location of the hosts file can be set in 

`$ /etc/ansible/ansible.cfg`

You can have a .yml based inventory file or a .ini file

### Modules 

Modules are tools for a particular tasks. They can take parameters and return JSON notation. 
They can be run from the command line or within a playbook and ansible comes with a significant amout of default modules as standard

### Variables 

Variable are strings of letters, numbers and underscores that will store configuration values and parameters what we will be working with. Three main scopes for variables are:
- Global 
- Hosts 
- Play 

### Facts 

Provide information about a given target hosts. They are automatically discovered by Ansible when it reaches out to another node/host but can be disabled within the config file or be cached for use in a playbook execution 

### Plays and Playbooks 

A playbook consists of one or more tasks which make calls to ansible modules. A playbook can have a series of plays/instructions for which ansible will then ssh to the control nodes and action. These playbooks can be written in yaml or ini file. 



[//]: * (Links Section)

[Ansible Documentation]: <https://docs.ansible.com/ansible/latest/getting_started/index.html>
