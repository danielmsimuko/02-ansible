# STUDY-NOTES-Ansible
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


