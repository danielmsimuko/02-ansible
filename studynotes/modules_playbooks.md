## Modules and Playbooks 

### Common Modules

* Ping: Validates a server is running 

* Yum: Package manager

`$ ansible (hostname) -b -m yum -a "name=httpd state=latest"` installs the httpd service

* Setup: Gather ansible facts

* Service: Controls services on remote host

`$ ansible (hostname) -b -m service -a "name=httpd state=started enabled=yes"` starts the httpd service

* User: Manages user accounts and attributes 

`$ ansible (hostname) -b -m user -a "name=username"` creates a user in host

* Copy: copies file to a remote host with src, dest, owner, group and mode 

`$ ansible (hosts) -b -m copy -a "src=/dir/dir/filename dest=/dir/dir owner=username group=grpname mode=0644"` copies a file to remote host

* File: manages files and directories with params: path, state, owner, group, mode

* Git: interact with git repos with params: repo, dest, clone 

Lastly when we run ansible command without a module present i.e `$ ansible (hosts) -b -a "ls -l /home/ansible"` it just runs the same way a linux command will run

### Register results of a running command 

When running a command, the results can be stored as a variable to be referenced by other tasks. e.g playbook register.yml. Return values differ from module to module 
```
---
- hosts: hostname
  tasks:
    - name: create a file
      file:
        path: /tmp/testfile
        state: touch
      register: variable
      
    - name: display debug message
      debug: msg="Register output is {{ variable }}"
      
    - name: edit file 
      lineinfile:
        path: /tmp/testFile
        line: "the uid is {{variable.uid}} and gid is {{variable.gid}}"
```
when run using cmd `$ ansible-playbook playbooks/register.yml` you can see the output and the gid and uid values can then be referenced in another file 



