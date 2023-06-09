## Modules and Playbooks 

### Common Modules used by ansible

* Ping: Validates a server is running 
* Setup: Gather ansible facts
* Yum: Package manager

`$ ansible (hostname) -b -m yum -a "name=httpd state=latest"` installs the httpd service

* Service: Controls services on remote host

`$ ansible (hostname) -b -m service -a "name=httpd state=started enabled=yes"` starts the httpd service

* User: Manages user accounts and attributes 

`$ ansible (hostname) -b -m user -a "name=username"` creates a user in host

* Copy: copies file to a remote host with src, dest, owner, group and mode 

`$ ansible (hosts) -b -m copy -a "src=/dir/dir/filename dest=/dir/dir owner=username group=grpname mode=0644"` copies a file to remote host
