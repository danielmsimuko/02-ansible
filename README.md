# 02-Learning Ansible
For Mastery of Ansible and all things server config management. You describe the end-state and ansible gets you there. The most common use for ansible is making sure all servers that are doing the same thing, are configured the same way. 

## Why Ansiblle 

### Security
Consistency of configuration leads to a more secure environment. Integrated security policies will improve ability to scan and remediate issues

### Compliance 
Putting policy into code and then applying that code to servers allows for compliance throughout datacentres. Rather than have an individual touch 500 servers, one code does it all.  

### Rapid Deployment 
With server builds defined by code, the speed of deployments go up. 

### Installation 

`$ sudo yum install ansbile` installs ansible on your redhat based system 

`$ ansible --version` allows you to check which ansible version you currently have 

`$ sudo vim /etc/ansible/hosts` sets up the default ansible hosts file 

`$ ansible all -m ping` connects to all servers in the inventory file. You should see success

`$ ansible all --lists-hosts` shows us all the hosts in the all inventory 

`$ ansible webservers --lists-hosts` shows you the hosts within the webservers group

### How it works 

Modules are the backbone of ansible -  they are the ones doing the work 

Playbooks are comparable to bash scripts but more powerful and more customisable 

In general, changes only happen once regardless of the number of times its run. This is called idempotency. 

It is agentless. Does not require any additional software since it only requires SSH to connect and manage softwares 

### Modules 

Modules have different flags and variables that should be set to do their job

`ansible-doc <modulename>` command can be used to get more info on modules 

For Example `ansible-doc --l | grep docker` lists all the docker modules available to use 

modules should be idempotent and return JSON data

### Ansible Ad-Hoc Commands 

Ad-Hoc commands are useful for one of tasks such as rebooting serverd, gathering facts on servers and more. 

Dissecting the command 

`ansible [pattern] -m modulename -a "module option"` is the format for ansible commands 

An example below: 

`ansible all -m service -a "name=firewalld state=started" -b` started the firewalld service

### Ansible playbooks 

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
  

