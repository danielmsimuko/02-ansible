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

## General Commands 

Generate a List of Facts About the Ansible Host

`ansible -m setup --tree /dir/dir localhost` generates a list of facts about the host

`ansible localhost -m copy -a "src=/tmp/facts/127.0.0.1 dest=/var/www/html/index.html mode=0600 owner=apache group=apache" --become` can then be used to copy this into a new webserver directory as file index.html

`ansible -m yum -a "name=httpd state=present" 127.0.0.1 --become` installs httpd onto localhost machine 

```
127.0.0.1 | CHANGED => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    },
    "changed": true,
    "msg": "",
    "rc": 0,
    "results": [
        "Installed: httpd",
        "Installed: apr-util-openssl-1.6.1-6.el8_8.1.x86_64",
        "Installed: apr-util-bdb-1.6.1-6.el8_8.1.x86_64",
        "Installed: apr-1.6.3-12.el8.x86_64",
        "Installed: apr-util-1.6.1-6.el8_8.1.x86_64",
        "Installed: httpd-2.4.37-56.module+el8.8.0+18758+b3a9c8da.6.x86_64",
        "Installed: redhat-logos-httpd-84.5-1.el8.noarch",
        "Installed: httpd-tools-2.4.37-56.module+el8.8.0+18758+b3a9c8da.6.x86_64",
        "Installed: mod_http2-1.15.7-8.module+el8.8.0+18751+b4557bca.3.x86_64",
        "Installed: httpd-filesystem-2.4.37-56.module+el8.8.0+18758+b3a9c8da.6.noarch",
        "Installed: mailcap-2.1.48-3.el8.noarch"
    ]
}

```

By default apache isnt running so we run  `ansible localhost -m service -a "name=httpd state=started enabled=yes" --become` so we can enable it

`ansible -m yum -a "name=tcpdump state=absent" localhost --become` removes tcpdump from the machine localhost or 127.0.0.1 with the output being:

```
127.0.0.1 | CHANGED => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    },
    "changed": true,
    "msg": "",
    "rc": 0,
    "results": [
        "Removed: tcpdump-14:4.9.3-3.el8.x86_64"
    ]
}
```

[//]: * (Links Section)

[Ansible Documentation]: <https://docs.ansible.com/ansible/latest/getting_started/index.html>
