## Modules and Playbooks 

Common Modules used by ansible
* Ping: Validates a server is running 
* Setup: Gather ansible facts
* Yum: Package manager

`$ ansible (hostname) -b -m yum -a "name=httpd state=latest"` 

* Service: Controls services on remote host

`$ ansible (hostname) -b -m service -a "name=httpd state=started enabled=yes"`

* User: Manages user accounts and attributes 

